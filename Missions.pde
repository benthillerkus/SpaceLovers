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
            overlay.reset();
        }
        overlay.layers.clear();
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
            Mission current = layers.get(i);
            String txt = current.toString();
            int offsetY = marginTop + headingSize + (5 + missionSize) * i;

            fill(current.missionColor);
            
            text(txt, marginLeft, offsetY);
            if (current.done) {
                line(marginLeft - strikeThroughOverdraw,
                    offsetY - missionSize / 2 + strikeThroughSize,
                    marginLeft + textWidth(txt) + strikeThroughOverdraw,
                    offsetY - missionSize / 2 + strikeThroughSize);
            }
        }
    }
}

class Beacon extends GameObject {
    color missionColor;

    @Override
    protected void draw() {
        strokeWeight(3 * pixelFactor);
        stroke(missionColor, 50);
        fill(missionColor, 10);
        ellipseMode(RADIUS);
        ellipse(0, 0, size, size);
    }
}

class Arrow extends GameObject {
    PVector target;
    color missionColor;

    @Override
    protected void update() {
        position = game.ship.position;
        angle = PVector.sub(position, target).heading();
    }

    @Override
    protected void draw() {
        strokeWeight(3 * pixelFactor);
        noStroke();
        fill(missionColor, 60);
        rectMode(CORNERS);

        int arrowLength = int(18 * pixelFactor);
        int arrowHeight = int(8 * pixelFactor);
        int distance = int(-game.ship.size - 35 * pixelFactor);
        int triangleHeight = int(12 * pixelFactor);
        int triangleWidth = int(16 * pixelFactor);

        rect(distance - arrowLength, -arrowHeight / 2, distance, arrowHeight / 2);
        triangle(distance - arrowLength - triangleWidth, 0, distance - arrowLength, -triangleHeight, distance - arrowLength, triangleHeight);
    }
}

class Mission extends Layer {
    boolean done = false;
    GameWorld world = null;
    color missionColor;

    Mission(GameWorld world) {
        super();
        done = false;
        this.world = world;
        missionColor = color(random(125, 255), random(125, 255), random(125, 255));
        reset();
    }
}

class GoToLocationMission extends Mission {
    PVector location;
    float radius;
    int progress;
    Beacon myBeacon;
    Arrow diagShip;

    GoToLocationMission(GameWorld world) {
        super(world);
    }

    @Override
    protected void reset() {
        location = PVector.random2D().mult(4000);
        radius = 180;
        progress = 0;
        diagShip = new Arrow();
        diagShip.target = location;
        diagShip.missionColor = missionColor;
        myBeacon = new Beacon();
        myBeacon.missionColor = missionColor;
        myBeacon.size = radius;
        myBeacon.position = location;
        world.layers.add(myBeacon);
        world.layers.add(diagShip);
    }

    @Override
    protected void update() {
        progress = max(0, int(PVector.dist(game.ship.position, location) - radius));
        done = done ? done : progress < 1;
        diagShip.hidden = done;
        diagShip.frozen = done;
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
