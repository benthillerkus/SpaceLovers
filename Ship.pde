class Ship extends GameObject {
    boolean boost = false;
    Gun gun = new Gun(this);
    Shield shield = new Shield(this);

    Ship() {
        gun.position = new PVector(0, -40);
        shield.position = new PVector(0, -40);
    }
    
    @Override
    protected void update() {
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
                speed.sub(PVector.fromAngle(angle - PI / 2).mult(0.025));
        }
    }
    
    //Schiff
    @Override
    protected void draw() {
        noStroke();
        gun.render();
        shield.render();
        image( images.thruster , -8, -40 , 16, 16);
        image( images.ship , -30 , -30 , 60, 60 );
        
    }
    
    void fire() {}
    
    //Schub geben in Richtung des Schiffs (angle)
    //der Parameter "amount" gibt die Größe des Schubs an
    void thrustForward(float amount) {
        PVector thrust = new PVector(0, -amount); // pointing up
        thrust.rotate(angle);
        speed.add(thrust);
        // TODO: Terminal Velocity
    }
}
