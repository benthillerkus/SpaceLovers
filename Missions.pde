class MissionManager extends LayerManager<Mission> {
    
    void generate() {
        boolean hasDebris = false;
        for (Mission mission : layers) {
            if (mission instanceof PickUpDebrisMission) {
                hasDebris = true;
                break;
            }
        }
        if (!hasDebris) {
            layers.add(new PickUpDebrisMission());
        } else {
            layers.add(new GoToLocationMission());
        }
    }
    
    @Override
    protected void reset() {
        layers.clear();
    }

    @Override
    protected void draw() {
        int headingSize = int(25 * pixelFactor);
        int missionSize = int(16 * pixelFactor);
        int marginLeft = int(25 * pixelFactor);
        int marginTop = int(50 * pixelFactor);
        int strikeThroughOverdraw = int(2 * pixelFactor);
        int strikeThroughSize = int(2 * pixelFactor);
        textSize(headingSize);
        text("Missions", marginLeft, marginTop);

        textSize(missionSize);
        strokeWeight(strikeThroughSize);
        stroke(255);

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

class Mission extends Layer {
    boolean done = false;

    Mission() {
        super();
        done = false;
        reset();
    }
}

class GoToLocationMission extends Mission {
    PVector location;
    float radius;
    int progress;

    @Override
    protected void reset() {
        location = new PVector(0, 0);
        radius = 450;
        progress = 0;
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
