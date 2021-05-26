// TODO: Turn into LayerManager for each part
class Ship extends GameObject {
    boolean boost;
    Gun gun;
    Shield shield;
    Thruster thruster;
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
                case 'q':
                    game.player1.mode = game.player1.mode.next();
                    break;
                case 'e':
                    game.player1.mode = game.player1.mode.previous();
                    break;
                case 'u':
                    game.player2.mode = game.player1.mode.next();
                    break;
                case 'o':
                    game.player2.mode = game.player1.mode.previous();
                    break;
            }
        }
        else if (inputType == InputType.Pressed) {
           //Players not have same mode
            if(game.player2.current() != game.player1.current()){
            // Debug : thruster turns with shield or gun when one player has thruster active, input is related 
            switch(game.player1.current()) {
                case("Gun"):
                    gun.processInput();
                    if(key == ' '){
                    gun.shoot();
                    speed.sub(PVector.fromAngle(gun.absoluteAngle() - PI / 2).mult(0.025));}
                    break;
                case("Shield"):
                    shield.processInput();
                    break;
                case("Thruster"):
                    thruster.processInput();
                    if(key == 'w')
                        thrustForward(0.1);
                    else if(key == 's')
                        thrustForward(-0.1);
                    break;                    
            }
             switch(game.player2.current()) {
                case("Gun"):
                    gun.processInput();
                    if(key == ' '){
                    gun.shoot();
                    speed.sub(PVector.fromAngle(gun.absoluteAngle() - PI / 2).mult(0.025));}
                    break;
                case("Shield"):
                    shield.processInput();
                    break;
                case("Thruster"):
                    thruster.processInput();
                    if(key == 'i')
                        thrustForward(0.1);
                    else if(key == 'k')
                        thrustForward(-0.1);
                    break;                  
            }
            }
            //Players have the same mode, powerups could be implemented
            else if(game.player2.current() == game.player1.current()){
                switch(game.player1.current()) {
                case("Gun"):
                    gun.processInput();
                    if(key == ' '){
                    gun.shoot();
                    speed.sub(PVector.fromAngle(gun.absoluteAngle() - PI / 2).mult(0.025));}
                    // TODO: bullets bigger? add secound gun?
                    break;
                case("Shield"):
                    shield.processInput();
                    // TODO: make shield wider
                    break;
                case("Thruster"):
                    thruster.processInput();
                    if(key == 'w')
                        thrustForward(0.1);
                    else if(key == 's')
                        thrustForward(-0.1);   
                    break;                    
            }
             switch(game.player2.current()) {
                case("Gun"):
                    gun.processInput();
                    if(key == ' '){
                    gun.shoot();
                    speed.sub(PVector.fromAngle(gun.absoluteAngle() - PI / 2).mult(0.025));}
                    break;
                case("Shield"):
                    shield.processInput();
                    break;
                case("Thruster"):
                    thruster.processInput();
                    if(key == 'i')
                        thrustForward(0.1);
                    else if(key == 'k')
                        thrustForward(-0.1);
                    break;   
            }
         
        }
    }
    }
    
    
    //Schiff
    @Override
    protected void draw() {
        gun.render();
        shield.render();
        thruster.render();
        image(images.ship , -40 , -40 , 80, 80);
    }
    
    //Schub geben in Richtung des Schiffs (angle)
    //der Parameter "amount" gibt die Größe des Schubs an
    void thrustForward(float amount) {
        PVector thrust = new PVector(0, -amount); // pointing up
        thrust.rotate(thruster.absoluteAngle());
        speed.add(thrust);
        // TODO: Terminal Velocity
    }
}
