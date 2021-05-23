// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Menu, Play, Pause, Lost, Won; // TODO: StateMachine??
}

// This kinda is a manually managed LayerManager,
// so make sure every event is passed on!
class Game extends LayerManager<Layer> {
    Camera camera = new Camera();
    GameWorld world = new GameWorld(camera);
    CollisionLayer collisions = new CollisionLayer(48, 256);
    AsteroidField asteroids = new AsteroidField();
    DebrisManager debris = new DebrisManager();
    BulletManager bullets = new BulletManager();
    Ship ship = new Ship();
    Hud hud  = new Hud();
    GameMenu menu = new GameMenu();
    State state;
    ArrayList<Mission> missions = new ArrayList<Mission>();

    Game() {
        noiseSeed(187);
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
        layers.add(hud);
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
        hud.frozen = false;
        hud.hidden = false;
        missions.clear();
        missions.add(new Mission());
        missions.add(new Mission());
        missions.add(new Mission());
    }

    void menu() {
        state = State.Menu;
        menu.hidden = false;
        menu.frozen = false;
        world.hidden = false;
        world.frozen = true;
        hud.hidden = true;
        hud.frozen = true;
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
