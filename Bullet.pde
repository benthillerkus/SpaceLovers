class Bullet extends FlyingThing {
    
    Bullet(PVector pos, PVector speed) {
        super(pos, speed);
    }
    
    voidrender() {
        strokeWeight(3);
        stroke(255,255,0);
        point(pos.x, pos.y);
        strokeWeight(1);
    }
    
    voidupdate() {
        if (pos.x <= 0 || pos.x >= width ||
           pos.y <= 0 || pos.y >= height) {
            alive = false;
        }
        super.update();
    }
}