class Bullet extends GameObject {

    @Override
    void draw() {
        strokeWeight(3);
        stroke(255,255,0);
        point(0, 0);
        strokeWeight(1);
    }
}
