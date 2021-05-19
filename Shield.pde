class Shield extends GameObject {
    float orbitspeed;

    Shield(GameObject parent) {
        this.parent = parent;
        orbitspeed = .09;

    }

    @Override
    protected void draw() {
        image(images.shield, -15 , 0, 40, 20);
    }

    void input() {
        if (key == 'r'){
           angle += - orbitspeed;
           position.rotate(-orbitspeed);
        }
        else if(key == 'z'){
           angle += orbitspeed;
            position.rotate(orbitspeed);
        }
        angle %= TWO_PI; 
        
    }
}