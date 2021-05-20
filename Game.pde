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
    CollisionLayer collisions = new CollisionLayer(48, 256);
    AsteroidField asteroids = new AsteroidField();
    BulletManager bullets = new BulletManager();
    Ship ship = new Ship();
    GameMenu menu = new GameMenu();
    State state = State.Menu;
    
    void start() {
        noiseSeed(187);
        world.layers.add(asteroids);
        world.layers.add(collisions);
        world.layers.add(bullets);
        world.layers.add(ship);
        world.layers.add(camera);

        collisions.a = (ArrayList<GameObject>) (ArrayList<?>) asteroids.layers;
        collisions.b = (ArrayList<GameObject>) (ArrayList<?>) bullets.layers.clone();
        collisions.b.add(ship);

        // world.layers.add(debugUpperLeft);
    }
    
    @Override
    protected void input() {
        if(state == State.Play) world.processInput();
        if(state == State.Menu) menu.processInput();
    }
    
    @Override
    protected void update() {
        if (state == State.Play) world.update();
        if (state == State.Menu) menu.process();
    }
    
    @Override
    protected void draw() {
      world.draw();
      if(state == State.Menu)menu.render();
       
        
    }

    GameObject debugUpperLeft = new GameObject() {
        @Override
        protected void update() {
            position = PVector.sub(game.world.camera.position, new PVector(width / 2, height / 2).div(pixelFactor));
        }
    
        @Override
        protected void draw() {
            stroke(255, 211, 45);
            strokeWeight(12);
            point(0, 0);
        }
    };
}
