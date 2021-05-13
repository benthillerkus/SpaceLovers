class GameObject extends Layer {
    PVector position = new PVector(0, 0);
    float angle = 0.0;
    float scale = 1.0;

    GameWorld world;

    GameObject() {
        super();
    }

    GameObject(GameWorld world) {
        this.world = world;
    }

    void turn(float radians) {
        angle = (angle + radians) % TWO_PI;
    }
    
    @Override
    void render() {
        pushMatrix();
        translate(position.x, position.y);
        rotate(angle);
        scale(scale);
        super.render();
        popMatrix();
    }
}