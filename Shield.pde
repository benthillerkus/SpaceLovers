class Shield extends GameObject {
    float orbitspeed;

    Shield(GameObject parent) {
        this.parent = parent;
        orbitspeed = .09;

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
        else if(key == 't'){
           angle += orbitspeed;
            position.rotate(orbitspeed);
        }
        angle %= TWO_PI; 
        
    }
}