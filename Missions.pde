enum MissionState {
    NotDone, Done, Finished;
}

// The mission manager can not only generate new missions
// but also render their hud elements such as beacons
// (marked positions in the world) and arrows.
// For this the mission manager has its own game world
// using the same camera as the main game.
// Currently there are only two types of missions, but adding more
// like time trials or similar should be easy.
class MissionManager extends LayerManager<Mission> {
    GameWorld overlay = null;
    boolean revealedEndPosition = false;
    MissionState state;
    
    // Generate a new mission
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
        revealedEndPosition = false;
        state = MissionState.NotDone;
    }

    @Override
    protected void update() {
        super.update();
        overlay.process();

        // Update the completed missions statistic
        game.stats.completedMissions = 0;
        // lol java 7 lol kein filter
        boolean allMissionsDone = true;
        for (Mission mission : layers) {
            if (!mission.done) {
                allMissionsDone = false;
                break;
            }
            game.stats.completedMissions++;
        }

        // Check if the game has been won
        if (allMissionsDone && !revealedEndPosition) {
            layers.add(new GoToLocationMission(overlay));
            revealedEndPosition = true;
            state = MissionState.Done;
        } else if(allMissionsDone && revealedEndPosition) {
            state = MissionState.Finished;
            game.gameOver();
        }
    }

    @Override
    protected void draw() {
        overlay.render();

        int headingSize = int(20 * (pixelFactor / 2 + 0.5));
        int missionSize = int(11 * (pixelFactor / 2 + 0.5));
        int marginLeft = int(25 * pixelFactor);
        int marginTop = int(50 * pixelFactor);
        int strikeThroughOverdraw = int(2 * pixelFactor);
        int strikeThroughSize = int(2 * pixelFactor);
        stroke(255);
        fill(255);

        textFont(fonts.pixel);
        textSize(headingSize);
        text("Missions", marginLeft, marginTop);

        textSize(missionSize);
        strokeWeight(strikeThroughSize);

        for (int i = 0; i < layers.size(); i++) {
            Mission current = layers.get(i);
            String txt = current.toString();
            int offsetY = marginTop + headingSize + (5 + missionSize) * i;

            fill(current.missionColor);
            stroke(current.missionColor);
            
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
    float length;

    @Override
    protected void update() {
        position = game.ship.position;
        PVector temp = PVector.sub(position, target);
        length = smoothstep(0, 3000, temp.mag()) + 0.8;
        angle = temp.heading();
    }

    @Override
    protected void draw() {
        strokeWeight(3 * pixelFactor);
        noStroke();
        fill(missionColor, 60);
        rectMode(CORNERS);

        float miniPixelFactor = pixelFactor * 0.4 + 0.6;

        float arrowLength = 18 * length * miniPixelFactor;
        float arrowHeight = 8 * ((3 - length) * 0.5 + 0.5) * miniPixelFactor;
        float distance = -game.ship.size - 35 * miniPixelFactor;
        float triangleHeight = 12 * miniPixelFactor;
        float triangleWidth = 16 * miniPixelFactor;

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
        myBeacon.hidden = done;
        myBeacon.frozen = done;
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
        goal = int(random(15, 50));
        description = String.format("Clear up %d pieces of Debris with your shield", goal);
    }

    public String toString() {
        return String.format("%s: %d/%d", description, progress, goal);
    }

    @Override
    protected void update() {
        progress = game.stats.caughtDebris;
        done = (progress >= goal);
    }
}
