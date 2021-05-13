class Ship extends GameObject {
    float angle = 0; // ergänze Ausrichtung des Schiffs
    PVector speed = new PVector(0,0);
    
    @Override
    protected void update() {
        if (keyPressed) {
            switch(key) {
                case 'w':
                case 's':
                    thrustForward((key == 'w' ? 1 : -1) * 0.3);
                    break;
                case 'a':
                case 'd':
                    angle = (angle + (key == 'd' ? 1 : -1) * .03) % TWO_PI;
            }
        }
        position = position.add(speed);
    }
    
    //Dreieck mit Ausrichtung
    @Override
    protected void draw() {
        pushMatrix();
        rotate(angle);
        stroke(255);
        triangle( -10, 10, 0, -20, 10, 10);
        popMatrix();
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
