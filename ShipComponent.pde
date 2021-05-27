abstract class ShipComponent extends GameObject {
    float orbitSpeed;
    int numCommands;

    @Override
    protected void reset() {
        super.reset();
        orbitSpeed = .015;
        numCommands = 0;
    }

    @Override
    protected void update() {
        if (numCommands == 1) {
            doAction();
        } else if (numCommands == 2) {
            doEnhancedAction();
        }
        numCommands = 0;
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

    void action() {
        numCommands++;
    }

    abstract void doAction();
    abstract void doEnhancedAction();
}