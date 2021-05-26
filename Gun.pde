class Gun extends GameObject {
    float orbitspeed;

    @Override
    protected void reset() {
        super.reset();
        orbitspeed = .09;
    }

    @Override
    protected void draw() {
        image(images.gun, -8 , 2, 16, 16);
    }

    void shoot() {
        //sounds.laser.play();
        game.stats.firedBullets++;
        game.bullets.shoot(absolutePosition(), parent.speed, parent.scale, absoluteAngle());
    }

    void input() {
        if (key == 'a' || key == 'j'){
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

class BulletManager extends LayerManager<Bullet> {
    int bulletIndex;

    BulletManager() {
        layers = new ArrayList<Bullet>(256);
        for (int i = 0; i < 256; i++) {
            layers.add(new Bullet());
        }
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        bulletIndex = 0;
    }

    void shoot(PVector position, PVector speed, float scale, float angle) {
        Bullet current = layers.get(bulletIndex);
        current.position = position;
        current.speed = speed.copy();
        current.speed.add(PVector.fromAngle(angle - PI / 2).mult(4.0));
        current.angle = angle;
        current.scale = scale;
        current.hidden = false;
        current.frozen = false;
        bulletIndex = (bulletIndex + 1) % layers.size();
    }
}

class Bullet extends GameObject {

    @Override
    protected void reset() {
        super.reset();
        hidden = true;
        frozen = true;
        size = 0;
    }

    @Override
    void draw() {
        image(images.effectProjectileTiny, -2, -2, 4, 4);
    }

    @Override
    void update() {
        position.add(speed);
    }

    @Override
    void collision(GameObject enemy) {
        this.hidden = true;
        this.frozen = true;
    }
}
