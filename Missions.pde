class MissionManager extends LayerManager<Mission> {
    
    void generate() {
        layers.add(new Mission());
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
    String description;
    float progress;
    int goal;
    boolean done = false;

    Mission() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        progress = 0;
        goal = 15;
        done = false;
        description = String.format("Clear up %d pieces of Debris with your shield", goal);
    }

    public String toString() {
        return String.format("%s: %d/%d", description, int(progress), 15);
    }

    @Override
    protected void update() {
        progress = float(game.stats.catchedDebris);
        done = (progress >= goal);
    }
}
