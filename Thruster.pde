class Thruster extends GameObject {
    float orbitspeed;

    @Override
    protected void reset() {
        super.reset();
        orbitspeed = .015;
    }

    @Override
    protected void draw() {
        image(images.thruster , -12, 70 , 24, 24);
    }

    @Override
    protected void input() {
        if(key == 'a' || key == 'j'){
            angle -= orbitspeed;
            position.rotate(-orbitspeed);
        }
        else if(key == 'd' || key == 'l'){
            angle += orbitspeed;
            position.rotate(orbitspeed);
        }    
        angle %= TWO_PI; 
        
    }

}