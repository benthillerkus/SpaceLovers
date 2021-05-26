// TODO: Turn into LayerManager for each part
class Ship extends GameObject {
    boolean boost;
    Gun gun;
    Shield shield;
    Thruster thruster;
    int health;
    final int maxHealth = 500;

    private ShipComponent getComponent(PlayerMode mode) {
        switch(mode) {
            case Gun: return gun;
            case Shield: return shield;
            case Thruster: return thruster;
        }
        return null; // Was letzte exhaustive enum matching smh smh
    }

    @Override
    protected void reset() {
        super.reset();
        size = 24;
        boost = false;
        health = maxHealth;

        // Initialization of components
        // this is necessary, because
        // 1. We cannot create new Objects on reset,
        // as this would break exisiting pointers (Lists)
        // 2. Initializing in the constructor
        // or on the field would be later than this
        // which would cause null pointers here
        // 3. Initializing inside of game would be
        // possible, but annoying, as we'd have to
        // pass in the pointer to parent later
        if (gun == null || shield == null || thruster == null) {
            gun = new Gun();
            shield = new Shield();
            thruster = new Thruster();
        } else {
            gun.reset();
            shield.reset();
            thruster.reset();
        }

        gun.parent = this;
        shield.parent = this;
        thruster.parent = this;
        gun.position = new PVector(0, -40);
        shield.position = new PVector(0, -40);
        thruster.position = new PVector(0, -40);
    }

    @Override
    protected void collision(GameObject enemy) {
        sounds.collisionSound.play();
        // TODO: Incorporate speed in damage calculation
        int damage = int(enemy.size);

        health -= damage;
        game.stats.tankedDamage += damage;
        // TODO: Hit reaction effects
    }
    
    @Override
    protected void update() {
        if (health < 0) {
            game.gameOver();
            return;
        }
        position.add(speed);
        speed.mult(0.99);
        if (!boost) {
            if (!sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.loop();
            if (sounds.thrusterLow.isPlaying()) sounds.thrusterLow.pause();
        } else {
            if (!sounds.thrusterLow.isPlaying()) sounds.thrusterLow.loop();
            if (sounds.thrusterHigh.isPlaying()) sounds.thrusterHigh.pause();
        }
        boost = false;
        gun.process();
        shield.process();
        thruster.process();
        game.stats.renderedFrames++;
    }

    @Override
    protected void input() {
        if (inputType == InputType.Clicked) {
            switch(key) {
                case 'w':
                    game.player1.mode = game.player1.mode.next();
                    break;
                case 's':
                    game.player1.mode = game.player1.mode.previous();
                    break;
                case 'i':
                    game.player2.mode = game.player2.mode.next();
                    break;
                case 'k':
                    game.player2.mode = game.player2.mode.previous();
                    break;
            }
        } else if (inputType == InputType.Pressed) {
            switch (key) {
                case 'a':
                    getComponent(game.player1.mode).turnLeft();
                    break;
                case 'd':
                    getComponent(game.player1.mode).turnRight();
                    break;
                case 'j':
                    getComponent(game.player2.mode).turnLeft();
                    break;
                case 'l':
                    getComponent(game.player2.mode).turnRight();
                    break;
                case ' ':
                    getComponent(game.player1.mode).action();
                    break;
                case '.':
                    getComponent(game.player2.mode).action();
                    break;
            }
        }
    }
    
    //Schiff
    @Override
    protected void draw() {
        gun.render();
        shield.render();
        thruster.render();
        imageMode(CORNER);
        image(images.ship , -40.0, -40.0, 80.0, 80.0);
    }
}
