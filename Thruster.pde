class Thruster extends ShipComponent {
    boolean boost;

    @Override
    protected void reset() {
        super.reset();
        boost = false;
    }

    @Override
    protected void update() {
        if (!boost) {
            if (!sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.loop();
            if (sounds.thrusterLow.isPlaying()) sounds.thrusterLow.pause();
        } else {
            if (!sounds.thrusterLow.isPlaying()) sounds.thrusterLow.loop();
            if (sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.pause();
        }
        boost = false;
    }

    @Override
    protected void draw() {
        imageMode(CORNER);
        image(images.thruster, -12, 6, 24, -24);
    }

    @Override
    void action() {
        PVector thrust = new PVector(0, 0.1); // pointing up
        thrust.rotate(absoluteAngle());
        parent.speed.add(thrust);
        boost = true;
        // TODO: Terminal Velocity
    }
    
    @Override
    void enhancedAction() {}
}
