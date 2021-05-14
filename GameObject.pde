class GameObject extends Layer {
    PVector position = new PVector(0, 0);
    float angle = 0.0;
    float scale = 1.0;
    
    GameObject() {
        super();
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
}