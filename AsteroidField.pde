class AsteroidField extends GameObject {
    Collection<SpaceRock> asteroids = new ArrayList<SpaceRock>();
    
    AsteroidField() {
        for (int i = 0; i < 25; i++) {
            asteroids.add(new SpaceRock(PVector.random2D().mult(500), 1.0, 1.0));
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
        strokeWeight(1);
        ellipse(0, 0, 10, 10);
    }
}
