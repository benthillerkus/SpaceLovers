class AsteroidField extends LayerManager<SpaceRock> {
    final HashMap<Integer, HashSet<Integer>> freedPositions = new HashMap<Integer, HashSet<Integer>>();
    final int tileSize = 128;

    AsteroidField() {
        layers = new ArrayList<SpaceRock>(48);
        for (int i = 0; i < 48; i++) {
            layers.add(new SpaceRock());
        }
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
    int x = 0;
    int y = 0;

    SpaceRock() {
        super();
        size = 35;
    }
    
    @Override
    protected void draw() {
        image(images.asteroidLarge, -25, -25, 50, 50);
    }

    @Override
    protected void collision(GameObject enemy) {
        if (game.asteroids.freedPositions.containsKey(x)) {
            game.asteroids.freedPositions.get(x).add(y);
        } else {
            game.asteroids.freedPositions.put(x, new HashSet<Integer>());
        }
        game.debris.spawn(position, enemy.speed);
        game.debris.spawn(position, enemy.speed);
        game.debris.spawn(position, enemy.speed);
        game.debris.spawn(position, enemy.speed);
        sounds.collisionSound.play();
        this.hidden = true;
        this.frozen = true;
    }
}

// For reference: BulletManager in Gun
class DebrisManager extends LayerManager<Debris> {
    int debrisIndex = 0;

    DebrisManager() {
        layers = new ArrayList<Debris>(128);
        for (int i = 0; i < 128; i++) {
            layers.add(new Debris());
        }
    }

    void spawn(PVector position, PVector speed) {
        Debris current = layers.get(debrisIndex);
        current.position = PVector.sub(position, speed);
        current.speed = speed.copy().add(PVector.random2D()).mult(-0.2);
        current.hidden = false;
        current.frozen = false;
        debrisIndex = (debrisIndex + 1) % layers.size();
    }
}

class Debris extends GameObject {

    Debris() {
        hidden = true;
        frozen = true;
        size = 16;
    }

    @Override
    void draw() {
        image(images.asteroidTiny1, -size / 2, - size / 2, size, size);
    }

    @Override
    void update() {
        position.add(speed);
    }

    @Override
    void collision(GameObject enemy) {
        if (!(enemy instanceof SpaceRock)) {
            this.hidden = true;
            this.frozen = true;
        }
    }
}
