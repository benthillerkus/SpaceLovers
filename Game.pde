// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Menu, Play, Pause, Lost, Won; // TODO: StateMachine??
}

State gameState;

class Game extends Layer {
    GameWorld world = new GameWorld();
    Ship ship = new Ship();
    State state = State.Menu;
    
    void start() {
        world.layers.add(ship);
        state = State.Play;
        noCursor();
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
