// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Menu, Play, Pause, Lost, Won; // TODO: StateMachine??
}

// This kinda is a manually managed LayerManager,
// so make sure every event is passed on!
class Game extends LayerManager<Layer> {
    Camera camera;
    GameWorld world;
    CollisionLayer collisions;
    AsteroidField asteroids;
    DebrisManager debris;
    BulletManager bullets;
    Ship ship;
    GameMenu menu;
    State state;

    Game() {
        camera = new Camera();
        world = new GameWorld(camera);
        collisions = new CollisionLayer(48, 256);
        asteroids = new AsteroidField();
        debris = new DebrisManager();
        bullets = new BulletManager();
        ship = new Ship();
        menu = new GameMenu();

        noiseSeed(187);
        world.layers.clear();
        world.layers.add(asteroids);
        world.layers.add(collisions);
        world.layers.add(debris);
        world.layers.add(bullets);
        world.layers.add(ship);
        // world.layers.add(debugUpperLeft);
        world.layers.add(camera);

        collisions.a = (ArrayList<GameObject>) (ArrayList<?>) debris.layers.clone();
        for (SpaceRock asteroid : asteroids.layers) {
            collisions.a.add(asteroid);
        }
        collisions.b = (ArrayList<GameObject>) (ArrayList<?>) bullets.layers.clone();
        collisions.b.add(ship);
        collisions.b.add(ship.shield);

        layers.add(world);
        layers.add(menu);

        menu();
    }
    
    void start() {
        world.reset();
        state = State.Play;
        menu.hidden = true;
        menu.frozen = true;
        world.frozen = false;
        world.hidden = false;
    }

    void menu() {
        state = State.Menu;
        menu.hidden = false;
        menu.frozen = false;
        world.hidden = false;
        world.frozen = true;
    }
    
    GameObject debugUpperLeft = new GameObject() {
        @Override
        protected void update() {
            // position = PVector.sub(game.world.camera.position, new PVector(width / 2, height / 2).div(pixelFactor));
            position = game.ship.shield.absolutePosition();
        }
    
        @Override
        protected void draw() {
            stroke(255, 211, 45);
            strokeWeight(game.ship.shield.size * 2);
            point(0, 0);
        }
    };
}
