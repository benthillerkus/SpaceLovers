class AsteroidField extends GameObject {
    Collection<SpaceRock> asteroids = new ArrayList<SpaceRock>();
    // TODO: Use some datastructure that lets me index & search by coordinates
    
    AsteroidField() {
        for (int i = 0; i < 25; i++) {
            asteroids.add(new SpaceRock(PVector.random2D().mult(random(100, 1500)), 1.0, random(0.2, 1.2)));
        }
    }

    @Override
    protected void draw() {
        for (SpaceRock rock : asteroids) {
            rock.render();
        }
    }
    
    @Override
    protected void update() {
        // TODO: Actual spawning etc
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
