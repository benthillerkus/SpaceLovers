abstract class ShipComponent extends GameObject {
    float orbitSpeed;

    @Override
    protected void reset() {
        super.reset();
        orbitSpeed = .015;
    }

    void turnLeft() {
        turn(-orbitSpeed);
    }

    void turnRight() {
        turn(orbitSpeed);
    }

    @Override
    void turn(float radians) {
        super.turn(radians);
        position.rotate(radians);
    }

    abstract void action();
    abstract void enhancedAction();
}