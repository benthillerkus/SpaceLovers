class Mission extends Layer {
    String description;
    float progress;

    Mission() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        progress = 0;
        description = "Clear up 15 pieces of Debris with your shield";
    }

    public String toString() {
        return description + ": " + progress + "/15";
    }

    @Override
    protected void update() {
        // TODO: Check if condition has been met
        
    }
}
