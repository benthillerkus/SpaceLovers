class AsteroidField extends GameObject {
    ArrayList<SpaceRock> visibleAsteroids = new ArrayList<SpaceRock>(64);
    // TODO: Use some datastructure that lets me index & search by coordinates

    final int tileSize = 128;
    
    AsteroidField() {
        // for (int i = 0; i < 25; i++) {
        //     asteroids.add(new SpaceRock(PVector.random2D().mult(random(100, 1500)), 1.0, random(0.2, 1.2)));
        // }
        for (int i = 0; i < 64; i++) {
            visibleAsteroids.add(new SpaceRock());
        }
    }

    @Override
    protected void draw() {
        for (SpaceRock rock : visibleAsteroids) {
            rock.render();
        }
    }
    
    @Override
    protected void update() {
        // TODO: Actual spawning etc
        int index = 0;
        SpaceRock current;
        PVector upperLeft = PVector.sub(this.world.camera.position, new PVector(width / 2, height / 2));
        for (int x = int(upperLeft.x - upperLeft.x % tileSize) - tileSize; x < int(upperLeft.x + width) + tileSize; x += tileSize) {
            for (int y = int(upperLeft.y - upperLeft.y % tileSize) - tileSize; y < int(upperLeft.y + height) + tileSize; y += tileSize) {
                float likelihood = noise(512 + x * 0.05, -1024 + y * 0.05);
                if (likelihood < 0.6) continue;
                float offsetx = noise(256+ x * 0.125, y * 0.25, -30.0) * tileSize;
                float offsety = noise(x * 0.125, y * 0.125, 50.0) * tileSize;
                current = visibleAsteroids.get(index);
                current.position.x = x + offsetx;
                current.position.y = y + offsety;
                current.scale = pow(likelihood, 4) * 3; // TODO: Find a better formula
                current.hidden = false;
                index++;
            }
        }
        for (; index < visibleAsteroids.size(); index++) {
            current = visibleAsteroids.get(index);
            current.hidden = true;
            current.frozen = true;
        }
    }
}

class SpaceRock extends GameObject {
    SpaceRock() {
        super();
    }
    
    SpaceRock(PVector position, float angle, float scale) {
        super(position, angle, scale);
    }
    
    @Override
    protected void draw() {
        stroke(255);
        noFill();
        strokeWeight(1);
        ellipse(0, 0, 50, 50);
    }
}
