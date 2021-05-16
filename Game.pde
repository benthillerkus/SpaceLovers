// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Menu, Play, Pause, Lost, Won; // TODO: StateMachine??
}

State gameState;

// This kinda is a manually managed LayerManager,
// so make sure every event is passed on!
class Game extends Layer {
    Camera camera = new Camera();
    GameWorld world = new GameWorld(camera);
    AsteroidField asteroids = new AsteroidField();
    BulletManager bullets = new BulletManager();
    Ship ship = new Ship();
    State state = State.Menu;

    void start() {
        noiseSeed(187);
        world.layers.add(asteroids);
        world.layers.add(bullets);
        world.layers.add(ship);
        world.layers.add(camera);
        state = State.Play;
        noCursor();
    }
    
    @Override
    protected void input() {
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
