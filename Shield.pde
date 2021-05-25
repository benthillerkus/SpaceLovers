class Shield extends GameObject {
    float orbitspeed;

    @Override
    protected void reset() {
        super.reset();
        orbitspeed = .09;
        size = 20;
    }

    @Override
    protected void collision(GameObject enemy) {
        if (enemy instanceof  Debris) {
            game.stats.caughtDebris++;
        }
    }

    @Override
    protected void draw() {
        image(images.shield, -23, 4, 46, 20);
    }

    void input() {
        if (key == 'r'){
            angle -= orbitspeed;
            position.rotate(-orbitspeed);
        }
        else if (key == 't'){
            angle += orbitspeed;
            position.rotate(orbitspeed);
        }
        angle %= TWO_PI; 
    }
}