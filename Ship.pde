class Ship extends FlyingThing {
    float angle = 0; // ergänze Ausrichtung des Schiffs
    
    Ship(PVector pos, PVector speed) {
        super(pos, speed);
    }
    
    //Überschreibe Zeichenmethode:
    //Dreieck mit Ausrichtung
    void render() {
        pushMatrix();
        
        translate(pos.x, pos.y);
        rotate(angle);
        stroke(255);
        triangle( - 10, 10, 0, - 20, 10, 10);
        
        popMatrix();
    }
    
    Bullet fire() {
        PVector sp = new PVector(0, - 4); // Geschwindigkeit 4
        sp.rotate(angle);
        Bullet b = new Bullet(pos.get(), sp);
        return b;
    }
    
    //Schub geben in Richtung des Schiffs (angle)
    //der Parameter "amount" gibt die Größe des Schubs an
    void thrustForward(float amount) {
        PVector thrust = new PVector(0, - amount); // pointing up
        thrust.rotate(angle);
        speed.add(thrust);
    }
    
    boolean checkCollision(Asteroid ast) {
        return pos.dist(ast.pos) < (ast.size / 2 + 20);
    }
}
