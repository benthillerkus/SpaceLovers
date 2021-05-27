class Thruster extends ShipComponent {
    Event boost;

    @Override
    protected void reset() {
        super.reset();
        if (boost == null) {
            boost = new Event();
        } else {
            boost.reset();
        }
    }

    @Override
    protected void update() {
        super.update();
        if (boost.isNow()) {
            if (!sounds.thrusterLow.isPlaying()) sounds.thrusterLow.loop();
            if (sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.pause();
        } else {
            if (!sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.loop();
            if (sounds.thrusterLow.isPlaying()) sounds.thrusterLow.pause();
        }
        boost.process();
    }

    @Override
    protected void draw() {
        imageMode(CORNER);
        image(images.thruster, -12, 6, 24, -24);
        if (boost.isNow()) {
            scale((random(0, 1) >= 0.5 ? 1 : -1), 1);
            image(images.effectMuzzleMedium, -8 * random(0.95, 1.05), -40 * random(0.95, 1.05), 16 * random(0.95, 1.05), 36 * random(0.9, 1.1));
        }
    }

    @Override
    void doAction() {
        PVector thrust = new PVector(0, 0.1); // pointing up
        thrust.rotate(absoluteAngle());
        parent.speed.add(thrust);
        boost.setEvent();
        // TODO: Terminal Velocity
    }
    
    @Override
    void doEnhancedAction() {
        doAction();
        doAction();
        doAction();
    }
}
