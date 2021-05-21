class Shield extends GameObject {
    float orbitspeed;

    Shield(GameObject parent) {
        super(parent);
    }

    @Override
    protected void reset() {
        super.reset();
        orbitspeed = .09;
        size = 40;
    }

    @Override
    protected void draw() {
        image(images.shield, -23 , 4 , 46, 20);
    }

    void input() {
        if (key == 'r'){
            angle += - orbitspeed;
            position.rotate(-orbitspeed);
        }
        else if (key == 't'){
            angle += orbitspeed;
            position.rotate(orbitspeed);
        }
        angle %= TWO_PI; 
    }
}