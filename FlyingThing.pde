abstract class FlyingThing {
    PVector pos;
    PVector speed;
    boolean alive = true;
    
    FlyingThing(PVector pos, PVector speed) {
        
        // Vektoren kopieren mit get()
        this.pos = pos.get();
        this.speed = speed.get();
    }
    
    //Berechne neue Position
    void update()  {
        pos.add(speed);
        if (pos.x > width) {
            pos.x = 0;
        }
        if (pos.y > height) {
            pos.y = 0;
        }
        if (pos.x < 0) {
            pos.x = width;
        }
        if (pos.y < 0) {
            pos.y = height;
        }
    }
    
    //Zeichne Objekt
    //(muss von Unterklasse implementiert werden)
    abstract void render();
}