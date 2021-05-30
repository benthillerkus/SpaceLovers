// TODO: Turn into LayerManager for each part
class Ship extends GameObject {
    
    final int maxHealth = 500;
    final int maxPause = 4;
    int health;
    int pause;

    Gun gun;
    Shield shield;
    Thruster thruster;
    Event hit;

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
        size = 40;
        pause = maxPause;
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
        if (gun == null || shield == null || thruster == null || hit == null) {
            gun = new Gun();
            shield = new Shield();
            thruster = new Thruster();
            hit = new Event();
        } else {
            gun.reset();
            shield.reset();
            thruster.reset();
            hit.reset();
        }

        gun.parent = this;
        shield.parent = this;
        thruster.parent = this;
        gun.position = new PVector(0, -size - 30);
        shield.position = new PVector(0, -size);
        thruster.position = new PVector(0, -size);

        gun.turn(PI / 3);
        shield.turn(-PI / 3);
        thruster.turn(PI);
    }

    @Override
    protected void collision(GameObject enemy) {
        hit.setEvent();
        pause = maxPause;
        sounds.collisionSound.trigger();
        // TODO: Incorporate speed in damage calculation
        int damage = int(enemy.size);
        angularSpeed += random(-.01, .01);
        health -= damage;
        game.stats.tankedDamage += damage;
        // TODO: Hit reaction effects
    }
    
    @Override
    protected void update() {
        hit.process();
        pause = max(0, pause - 1);
        if (health < 0) {
            game.gameOver();
            return;
        } else if (!sounds.lowHealthMusic.isPlaying() && health < maxHealth * 0.15) {
            sounds.mainMusic.stop();
            sounds.lowHealthMusic.loop();
        }
        if (pause > 0) return;
        gun.process();
        shield.process();
        thruster.process();
        position.add(speed);
        speed.mult(0.992);
        angle += angularSpeed;
        angularSpeed /= 1.1;
        game.stats.renderedFrames++;
    }

    @Override
    protected void input() {
        if (inputType == InputType.Clicked) {
            switch(key) {
                case 'w':
                    game.player1.mode = game.player1.mode.next();
                    sounds.menuForward.play();
                    break;
                case 's':
                    game.player1.mode = game.player1.mode.previous();
                    sounds.menuBack.play();
                    break;
                case 'i':
                    game.player2.mode = game.player2.mode.next();
                    sounds.menuForward.play();
                    break;
                case 'k':
                    game.player2.mode = game.player2.mode.previous();
                    sounds.menuBack.play();
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
        if (hit.isNow()) tint(255, 0, 0);
        shield.render();
        gun.render();
        if (hit.isNow()) tint(255, 0, 0);
        thruster.render();
        if (hit.isNow()) tint(255, 0, 0);
        imageMode(CENTER);
        pushMatrix();
        // This prevents Processing from
        // trying to snap the image onto a discrete pixel grid
        rotate(0.001);
        // comment the line out and be marvelled by the jitter 🤮
        image(images.ship, 0, 0, size * 2, size * 2);
        noTint();
        popMatrix();
    }
}
