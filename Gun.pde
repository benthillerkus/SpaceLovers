class Gun extends ShipComponent {
    
    @Override
    protected void draw() {
        imageMode(CORNER);
        if (doingAction.isNow() && random(0, 1) > 0.3) {
            pushMatrix();
            scale(random(0, 1) >= 0.5 ? 1 : -1, 1);
            rotate(random(-0.13, 0.13));
            image(images.effectMuzzleMedium1, -8, 16, 18, -18 * random(0.8, 1.2));
            popMatrix();
        }
        image(images.gun, -12, 8, 24, 24);
    }
    
    @Override
    void doAction() {
        if (frameCount % 3 == 0) {
            sounds.laser.play();
            game.stats.firedBullets++;
            game.bullets.shoot(absolutePosition(), parent.speed, parent.scale, absoluteAngle());
            parent.speed.sub(PVector.fromAngle(absoluteAngle() - HALF_PI).mult(0.075));
        }
    }
    
    @Override
    void doEnhancedAction() {}
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
        image(images.effectMuzzleTiny1, -1.5, -2, 3, 8);
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
