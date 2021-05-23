class AsteroidField extends LayerManager<SpaceRock> {
    final HashMap<Integer, HashSet<Integer>> freedPositions = new HashMap<Integer, HashSet<Integer>>();
    final int tileSize = 128;

    AsteroidField() {
        layers = new ArrayList<SpaceRock>(48);
        for (int i = 0; i < 48; i++) {
            layers.add(new SpaceRock());
        }
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        freedPositions.clear();
    }
    
    @Override
    protected void update() {
        int index = 0;
        SpaceRock current;
        PVector upperLeft = PVector.sub(game.world.camera.position, new PVector(width / 2, height / 2).div(pixelFactor));
        for (int x = int(upperLeft.x - upperLeft.x % tileSize) - tileSize * 2; x < int(upperLeft.x + width / pixelFactor) + tileSize * 2; x += tileSize) {
            for (int y = int(upperLeft.y - upperLeft.y % tileSize) - tileSize * 2; y < int(upperLeft.y + height / pixelFactor) + tileSize * 2; y += tileSize) {
                if (freedPositions.containsKey(x) && freedPositions.get(x).contains(y)) continue;
                float likelihood = noise(512 + x * 0.05, -1024 + y * 0.05);
                if (likelihood < 0.6) continue;
                float offsetX = noise(256 + x * 0.125, y * 0.25, -30.0) * tileSize * 2;
                float offsetY = noise(x * 0.125, y * 0.125, 50.0) * tileSize * 2;
                current = layers.get(index);
                current.position.x = x + offsetX;
                current.position.y = y + offsetY;
                current.x = x;
                current.y = y;
                current.angle = offsetX;
                current.scale = pow(likelihood, 4) * 4; // TODO: Find a better formula
                current.hidden = false;
                current.frozen = false;
                index++;
            }
        }
        for (; index < layers.size(); index++) {
            current = layers.get(index);
            current.hidden = true;
            current.frozen = true;
        }
        super.update();
    }
    
    @Override
    protected void draw() {
        super.draw();
    }
}

class SpaceRock extends GameObject {
    int x, y;

    @Override
    protected void reset() {
        super.reset();
        hidden = true;
        frozen = true;
        x = 0;
        y = 0;
        size = 25;
    }
    
    @Override
    protected void draw() {
        image(images.asteroidLarge, -size, -size, size * 2, size * 2);
    }

    @Override
    protected void collision(GameObject enemy) {
        if (game.asteroids.freedPositions.containsKey(x)) {
            game.asteroids.freedPositions.get(x).add(y);
        } else {
            game.asteroids.freedPositions.put(x, new HashSet<Integer>());
        }
        for (int i = 0; i < 5; i++) {
            game.debris.spawn(PVector.random2D().mult(size).add(position), enemy.speed);
        }
        reset();
    }
}

// For reference: BulletManager in Gun
class DebrisManager extends LayerManager<Debris> {
    int debrisIndex;

    DebrisManager() {
        layers = new ArrayList<Debris>(128);
        for (int i = 0; i < 128; i++) {
            layers.add(new Debris());
        }
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        debrisIndex = 0;
    }

    void spawn(PVector position, PVector speed) {
        Debris current = layers.get(debrisIndex);
        current.position = PVector.sub(position, speed);
        current.speed = speed.copy().add(PVector.random2D().mult(2)).mult(-0.1);
        current.hidden = false;
        current.frozen = false;
        current.size *= random(0.5, 1.8);
        // FIXME: Why tf is this not working?
        current.angle = random(TWO_PI);
        current.angularSpeed = random(-0.1, 0.1);
        debrisIndex = (debrisIndex + 1) % layers.size();
    }
}

class Debris extends GameObject {

    @Override
    protected void reset() {
        super.reset();
        hidden = true;
        frozen = true;
        size = 16;
    }

    @Override
    void draw() {
        image(images.asteroidTiny1, -size / 2, -size / 2, size, size);
    }

    @Override
    void update() {
        position.add(speed);
        angle += angularSpeed;
        angle %= angle;
    }

    @Override
    void collision(GameObject enemy) {
        if (!(enemy instanceof SpaceRock)) {
            reset();
        }
    }
}
