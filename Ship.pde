class Ship {
    
    float angle = 0; // ergänze Ausrichtung des Schiffs
    
    PVector position = new PVector(0,0);
    PVector speed = new PVector(0,0);
    
    Ship() {
    }
    
    //Überschreibe Zeichenmethode:
    //Dreieck mit Ausrichtung
    void draw() {
        pushMatrix();
        
        translate(position.x, position.y);
        rotate(angle);
        stroke(255);
        triangle( - 10, 10, 0, - 20, 10, 10);
        
        popMatrix();
    }
    
    void fire() {
    }
    
    //Schub geben in Richtung des Schiffs (angle)
    //der Parameter "amount" gibt die Größe des Schubs an
    void thrustForward(float amount) {
        PVector thrust = new PVector(0, - amount); // pointing up
        thrust.rotate(angle);
        speed.add(thrust);
    }
}

