// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Menu, Play, Pause, Lost, Won; // TODO: StateMachine??
}

State gameState;

// This kinda is a manually managed LayerManager,
// so make sure every event is passed on!
class Game extends Layer {
    GameWorld world = new GameWorld();
    Ship ship = new Ship();
    State state = State.Menu;

    void start() {
        world.register(ship);
        state = State.Play;
        noCursor();
    }
    
    @Override
    void input() {
        world.processInput();
    }

    @Override
    protected void update() {
        if (state == State.Play) world.update();
    }
    
    @Override
    protected void draw() {
        world.draw();
    }
}
