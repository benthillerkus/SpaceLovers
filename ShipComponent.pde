abstract class ShipComponent extends GameObject {
    float orbitSpeed;
    int numCommands;
    Event doingAction;

    @Override
    protected void reset() {
        super.reset();
        if (doingAction == null) {
            doingAction = new Event();
        } else {
            doingAction.reset();
        }
        size = 15;
        orbitSpeed = .02;
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
        doingAction.process();
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
        doingAction.setEvent();
    }

    abstract void doAction();
    abstract void doEnhancedAction();
}