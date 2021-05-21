class GameObject extends Layer {
    PVector position;
    PVector speed;
    float angle;
    float scale;
    float size; // Used for collision
    GameObject parent;
    
    GameObject() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        position = new PVector(0, 0);
        speed = new PVector(0, 0);
        angle = 0.0;
        scale = 1.0;
        size = 1.0;
    }

    GameObject(GameObject parent) {
        this.parent = parent;
    }

    GameObject(PVector position, float angle, float scale) {
        this.position = position;
        this.angle = angle;
        this.scale = scale;
    }
    
    void turn(float radians) {
        angle = (angle + radians) % TWO_PI;
    }
    
    @Override
    void render() {
        if (hidden) return;
        pushMatrix();
        translate(position.x, position.y);
        rotate(angle);
        scale(scale);
        super.render();
        popMatrix();
    }
    
    protected void collision(GameObject enemy) {}
}