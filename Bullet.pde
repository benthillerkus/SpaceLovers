class Bullet {

    PVector pos, speed;
    
    Bullet(PVector pos, PVector speed) {
        this.pos = pos;
        this.speed = speed;
    }
    
    void render() {
        strokeWeight(3);
        stroke(255,255,0);
        point(pos.x, pos.y);
        strokeWeight(1);
    }
    
    void update() {
        if (pos.x <= 0 || pos.x >= width ||
            pos.y <= 0 || pos.y >= height) {
                // TODO: Kill
        }
    }
}