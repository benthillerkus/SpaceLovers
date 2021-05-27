// Game code goes in here
// This is supposed to be opinionated / non-generic

enum State {
    Menu, Play, Pause; // TODO: StateMachine??
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
    MissionManager missions = new MissionManager();
    Stats stats = new Stats();
    State state;
    Player player1 = new RedPlayer();
    Player player2 = new BluePlayer();

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
        collisions.b.add(ship.thruster);

        layers.add(world);
        layers.add(missions);
        layers.add(hud);
        layers.add(menu);

        menu();
    }
    
    void start() {
        world.reset();
        missions.reset();
        stats.reset();
        state = State.Play;
        menu.hidden = true;
        menu.frozen = true;
        missions.hidden = false;
        missions.frozen = false;
        world.frozen = false;
        world.hidden = false;
        hud.frozen = false;
        hud.hidden = false;
        missions.generate();
        missions.generate();
        missions.generate();
        sounds.menuMachinery.stop();
        if(!sounds.mainMusic.isPlaying()) sounds.mainMusic.loop();
    }

    void menu() {
        state = State.Menu;
        menu.hidden = false;
        menu.frozen = false;
        world.hidden = false;
        world.frozen = true;
        missions.hidden = true;
        missions.frozen = true;
        hud.hidden = true;
        hud.frozen = true;
        if(!sounds.menuMachinery.isPlaying()) sounds.menuMachinery.loop();
    }

    void gameOver() {
        state = State.Menu;
        if(sounds.mainMusic.isPlaying()) sounds.mainMusic.stop();
        if(sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.stop();
        if(sounds.thrusterLow.isPlaying()) sounds.thrusterLow.stop();
        if(sounds.lowHealthMusic.isPlaying()) sounds.lowHealthMusic.stop();
        menu.gameOver();
        menu.hidden = false;
        menu.frozen = false;
        world.hidden = false;
        world.frozen = true;
        missions.hidden = true;
        missions.frozen = true;
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
