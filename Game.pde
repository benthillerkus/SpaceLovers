// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Play, Pause, Lost, Won; // TODO: StateMachine??
}

State gameState;

class Game extends LayerManager {
    GameWorld world = new GameWorld();
    Ship ship = new Ship();
    State state;
    
    void start() {
        world.layers.add(ship);
        state = State.Play;
    }
    
    @Override
    protected void update() {
        if (state == State.Play) world.update();
        super.update();
    }
    
    @Override
    protected void draw() {
        world.draw();
        super.draw();
    }
}
