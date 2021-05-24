class MissionManager extends LayerManager<Mission> {
    GameWorld overlay = null;
    
    void generate() {
        boolean hasDebris = false;
        for (Mission mission : layers) {
            if (mission instanceof PickUpDebrisMission) {
                hasDebris = true;
                break;
            }
        }
        if (!hasDebris) {
            layers.add(new PickUpDebrisMission(overlay));
        } else {
            layers.add(new GoToLocationMission(overlay));
        }
    }
    
    @Override
    protected void reset() {
        layers.clear();
        if (overlay == null) {
            overlay = new GameWorld(game.camera);
        } else {
            overlay.layers.clear();
            overlay.reset();
        }
    }

    @Override
    protected void update() {
        super.update();
        overlay.process();
    }

    @Override
    protected void draw() {
        overlay.render();

        int headingSize = int(25 * pixelFactor);
        int missionSize = int(16 * pixelFactor);
        int marginLeft = int(25 * pixelFactor);
        int marginTop = int(50 * pixelFactor);
        int strikeThroughOverdraw = int(2 * pixelFactor);
        int strikeThroughSize = int(2 * pixelFactor);
        stroke(255);
        fill(255);

        textSize(headingSize);
        text("Missions", marginLeft, marginTop);

        textSize(missionSize);
        strokeWeight(strikeThroughSize);

        for (int i = 0; i < layers.size(); i++) {
            String txt = layers.get(i).toString();
            int offsetY = marginTop + headingSize + (5 + missionSize) * i;
            
            text(txt, marginLeft, offsetY);
            if (layers.get(i).done) {
                line(marginLeft - strikeThroughOverdraw,
                    offsetY - missionSize / 2 + strikeThroughSize,
                    marginLeft + textWidth(txt) + strikeThroughOverdraw,
                    offsetY - missionSize / 2 + strikeThroughSize);
            }
        }
    }
}

class Beacon extends GameObject {
    @Override
    protected void draw() {
        strokeWeight(3 * pixelFactor);
        stroke(230, 125, 245, 50);
        fill(230, 125, 245, 10);
        ellipseMode(CENTER);
        ellipse(position.x, position.y, size * 2, size * 2);
    }
}

class Mission extends Layer {
    boolean done = false;
    GameWorld world = null;

    Mission(GameWorld world) {
        super();
        done = false;
        this.world = world;
        reset();
    }
}

class GoToLocationMission extends Mission {
    PVector location;
    float radius;
    int progress;
    Beacon myBeacon;

    GoToLocationMission(GameWorld world) {
        super(world);
    }

    @Override
    protected void reset() {
        location = new PVector(0, 0);
        radius = 150;
        progress = 0;
        myBeacon = new Beacon();
        myBeacon.size = radius;
        myBeacon.position = location;
        world.layers.add(myBeacon);
    }

    @Override
    protected void update() {
        progress = max(0, int(PVector.dist(game.ship.position, location) - radius));
        done = progress < 1;
    }

    public String toString() {
        return String.format("Go to %d / %d! Only %d meters left.", int(location.x), int(location.y), progress);
    }
}

class PickUpDebrisMission extends Mission {
    String description;
    int progress;
    int goal;

    PickUpDebrisMission(GameWorld world) {
        super(world);
    }

    @Override
    protected void reset() {
        progress = 0;
        goal = 15;
        description = String.format("Clear up %d pieces of Debris with your shield", goal);
    }

    public String toString() {
        return String.format("%s: %d/%d", description, progress, 15);
    }

    @Override
    protected void update() {
        progress = game.stats.catchedDebris;
        done = (progress >= goal);
    }
}
