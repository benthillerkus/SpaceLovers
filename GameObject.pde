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

    // FIXME: Incorporate scale?
    PVector absolutePosition() {
        if (parent == null) {
            return position;
        } else {
            PVector offset = position.copy();
            offset.rotate(parent.angle);
            offset.add(parent.absolutePosition());
            return offset;
        }
    }

    float absoluteAngle() {
        return parent == null ? angle : parent.absoluteAngle() + angle;
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
        this();
        this.parent = parent;
    }

    GameObject(PVector position, float angle, float scale) {
        this();
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