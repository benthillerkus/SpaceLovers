class AsteroidField extends LayerManager<SpaceRock> {
    final HashMap<Integer, HashSet<Integer>> freedPositions = new HashMap<Integer, HashSet<Integer>>();
    final int tileSize = 128;

    AsteroidField() {
        layers = new ArrayList<SpaceRock>(72);
        for (int i = 0; i < 72; i++) {
            layers.add(new SpaceRock());
        }
    }
    
    @Override
    protected void update() {
        int index = 0;
        SpaceRock current;
        PVector upperLeft = PVector.sub(game.world.camera.position, new PVector(width / 2, height / 2));
        for (int x = int(upperLeft.x - upperLeft.x % tileSize) - tileSize * 2; x < int(upperLeft.x + width) + tileSize * 2; x += tileSize) {
            for (int y = int(upperLeft.y - upperLeft.y % tileSize) - tileSize * 2; y < int(upperLeft.y + height) + tileSize * 2; y += tileSize) {
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
    }
    
    SpaceRock(PVector position, float angle, float scale) {
        super(position, angle, scale);
    }
    
    @Override
    protected void draw() {
        image(images.asteroidLarge, -25, -25, 50, 50);
    }
    
    @Override
    protected void update() {
        PVector dir = PVector.sub(game.ship.position, this.position);
        if (dir.mag() < (this.scale * 50)) {
            if (game.asteroids.freedPositions.containsKey(x)) {
                game.asteroids.freedPositions.get(x).add(y);
            } else {
                game.asteroids.freedPositions.put(x, new HashSet<Integer>());
            }
            this.hidden = true;
            this.frozen = true;
        }
    }
}
