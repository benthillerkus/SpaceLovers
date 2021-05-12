class Shield  {
    float theta;
    float distance;
    float orbitspeed;
    
    Shield() {
        distance = 100;
        theta = 0;
        orbitspeed = .09;
    }
    
    //läst das schild nach links bei a oder rechts bei d drehen 
    void moveAroundOrbit() {
        if (keyPressed && key == 'a')
           theta += - orbitspeed;
        else if(keyPressed && key == 'd')
           theta += orbitspeed;
        else
           theta += 0;
        
        theta %= TWO_PI; 
        
    }
    
    void render() {
        //translate(ship.pos.x, ship.pos.y); ?? i need ship.pos

        pushMatrix();
        rotate(theta);
        //verschiebung sodass sich das schild ums schiff dreht
        translate(distance, 0);
        stroke(0);
        fill(175);
        ellipse(0,0, 30, 30);
        popMatrix();
        moveAroundOrbit();
    }
}