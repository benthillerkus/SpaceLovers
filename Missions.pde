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
        textSize(headingSize);
        text("Missions", marginLeft, marginTop);

        textSize(missionSize);
        for (int i = 0; i < layers.size(); i++) {
            text(layers.get(i).toString(), marginLeft, marginTop + headingSize + (5 + missionSize) * i);
        }
    }
}

class Mission extends Layer {
    String description;
    float progress;
    int goal;

    Mission() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        progress = 0;
        goal = 15;
        description = String.format("Clear up %d pieces of Debris with your shield", goal);
    }

    public String toString() {
        return String.format("%s: %d/%d", description, int(progress), 15);
    }

    @Override
    protected void update() {
        progress = float(game.stats.catchedDebris);
    }
}
