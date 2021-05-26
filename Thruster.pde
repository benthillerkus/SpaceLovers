class Thruster extends ShipComponent {
    @Override
    protected void draw() {
        image(images.thruster, -12, 70, 24, 24);
    }

    @Override
    void action() {
        PVector thrust = new PVector(0, -0.1); // pointing up
        thrust.rotate(absoluteAngle());
        parent.speed.add(thrust);
        // TODO: Terminal Velocity
    }
    
    @Override
    void enhancedAction() {}
}
