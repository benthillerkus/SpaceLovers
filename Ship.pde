class Ship extends GameObject {
    boolean boost = false;
    Gun gun = new Gun(this);

    Ship() {
        gun.position = new PVector(0, -24);
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
    }

    @Override
    protected void input() {
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
    
    //Dreieck mit Ausrichtung
    @Override
    protected void draw() {
        noStroke();
        triangle( -10, 10, 0, -20, 10, 10);
        gun.render();
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
