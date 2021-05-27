class Thruster extends ShipComponent {

    @Override
    protected void update() {
        super.update();
        if (doingAction.isNow()) {
            if (!sounds.thrusterLow.isPlaying()) sounds.thrusterLow.loop();
            if (sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.pause();
            size = 20;
        } else {
            if (!sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.loop();
            if (sounds.thrusterLow.isPlaying()) sounds.thrusterLow.pause();
            size = 0;
        }
    }

    @Override
    protected void draw() {
        imageMode(CORNER);
        rotate(0.001);
        image(images.thruster, -12, 6, 24, -24);
        if (doingAction.isNow()) {
            scale((random(0, 1) >= 0.5 ? 1 : -1), 1);
            image(images.effectMuzzleMedium, -8 * random(0.95, 1.05), -40 * random(0.95, 1.05), 16 * random(0.95, 1.05), 36 * random(0.9, 1.1));
        }
    }

    @Override
    void doAction() {
        PVector thrust = new PVector(0, 0.1); // pointing up
        thrust.rotate(absoluteAngle());
        parent.speed.add(thrust);
        // TODO: Terminal Velocity
    }
    
    @Override
    void doEnhancedAction() {
        doAction();
        doAction();
        doAction();
    }
}
