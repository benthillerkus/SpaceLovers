class Gun extends ShipComponent {
    int heat;
    final int maxHeat = 255;

    @Override
    protected void reset() {
        super.reset();
        heat = 0;
    }

    @Override
    protected void update() {
        super.update();
        heat = min(max(0, heat - 3), int(maxHeat * 1.2));
    }
    
    @Override
    protected void draw() {
        imageMode(CORNER);
        if (doingAction.isNow() && heat <= 255 && random(0, 1) > 0.3) {
            pushMatrix();
            scale(random(0, 1) >= 0.5 ? 1 : -1, 1);
            rotate(random(-0.13, 0.13));
            image(images.effectMuzzleMedium1, -8, 16, 18, -18 * random(0.8, 1.2));
            popMatrix();
        }
        tint(255, max(255 - heat, 0), max(255 - heat, 0));
        image(images.gun,
            -12 + ((random(-1, 1) * (float(heat) / float(maxHeat)))),
            8 + ((random(-1, 1) * (float(heat) / float(maxHeat)))),
            24, 24);
        noTint();
    }
    
    @Override
    void doAction() {
        if (heat <= maxHeat && frameCount % 3 == 0) {
            sounds.laser.play();
            game.stats.firedBullets++;
            game.bullets.shoot(absolutePosition(), parent.speed, parent.scale, absoluteAngle(), true);
            parent.speed.sub(PVector.fromAngle(absoluteAngle() - HALF_PI).mult(0.075));
        }
        heat += 5;
    }
    
    @Override
    void doEnhancedAction() {
        if (frameCount % 9 == 0) {
            game.stats.firedBullets++;
            game.bullets.shoot(absolutePosition(), parent.speed, parent.scale, absoluteAngle(), false);
            parent.speed.sub(PVector.fromAngle(absoluteAngle() - HALF_PI).mult(0.250));
        }
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

    void shoot(PVector position, PVector speed, float scale, float angle, boolean small) {
        Bullet current = layers.get(bulletIndex);
        current.position = position;
        current.speed = speed.copy();
        current.speed.add(PVector.fromAngle(angle - PI / 2).mult(5.0));
        current.angle = angle;
        current.scale = scale;
        current.hidden = false;
        current.frozen = false;
        current.small = small;
        if (small) current.size = 0; else current.size = 8;
        bulletIndex = (bulletIndex + 1) % layers.size();
    }
}

class Bullet extends GameObject {
    boolean small;

    @Override
    protected void reset() {
        super.reset();
        hidden = true;
        frozen = true;
        small = true;
        size = 0;
    }

    @Override
    void draw() {
        if (small) {
            image(images.effectMuzzleTiny1, -1.5, -2, 3, 8);
        } else {
            image(images.effectProjectileTiny, -size, -size, size * 2, size * 2);
        }
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
