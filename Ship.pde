class Ship extends GameObject {
    PVector speed = new PVector(0,0);
    boolean boost = false;
    
    @Override
    protected void update() {
        position.add(speed);
        speed.mult(0.99);
        if (!boost) {
            if (!thrusterHigh.isPlaying()) thrusterHigh.loop();
            if (thrusterLow.isPlaying()) thrusterLow.pause();
        } else {
            if (!thrusterLow.isPlaying()) thrusterLow.loop();
            if (thrusterHigh.isPlaying()) thrusterHigh.pause();
        }
        boost = false;
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
                turn((key == 'd' ? 1 : -1) * 0.03);
        }
    }
    
    //Dreieck mit Ausrichtung
    @Override
    protected void draw() {
        stroke(255);
        triangle( -10, 10, 0, -20, 10, 10);
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
