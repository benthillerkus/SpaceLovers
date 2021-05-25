// TODO: Turn into LayerManager for each part
class Ship extends GameObject {
    boolean boost;
    Gun gun;
    Shield shield;
    int health;
    final int maxHealth = 500;

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
        if (gun == null || shield == null) {
            gun = new Gun();
            shield = new Shield();
        } else {
            gun.reset();
            shield.reset();
        }

        gun.parent = this;
        shield.parent = this;
        gun.position = new PVector(0, -40);
        shield.position = new PVector(0, -40);
    }

    @Override
    protected void collision(GameObject enemy) {
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
        game.stats.renderedFrames++;
    }

    @Override
    protected void input() {
        gun.processInput();
        shield.processInput();
        switch(key) {
            case 'w':
            case 's':
                thrustForward((key == 'w' ? 1 : -1) * 0.3);
                boost = true;
                break;
            case 'a':
            case 'd':
                turn((key == 'd' ? 1 : -1) * 0.05);
                break;
            case ' ':
                gun.shoot();
                speed.sub(PVector.fromAngle(gun.absoluteAngle() - PI / 2).mult(0.025));
        }
    }
    
    //Schiff
    @Override
    protected void draw() {
        gun.render();
        shield.render();
        image(images.thruster , -8, -40 , 16, 16);
        image(images.ship , -30 , -30 , 60, 60);
    }
    
    //Schub geben in Richtung des Schiffs (angle)
    //der Parameter "amount" gibt die Größe des Schubs an
    void thrustForward(float amount) {
        PVector thrust = new PVector(0, -amount); // pointing up
        thrust.rotate(angle);
        speed.add(thrust);
        // TODO: Terminal Velocity
    }
}
