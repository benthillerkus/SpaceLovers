class GameWorld extends LayerManager<GameObject> {
    Camera camera;
    
    GameWorld(Camera camera) {
        this.camera = camera;
    }
    
    public void register(GameObject gameObject) {
        layers.add(gameObject);
        gameObject.world = this;
    }
    
    @Override
    protected void draw() {
        pushMatrix();
        translate(width / 2, height / 2);
        scale(sqrt(float((width * height)) / (referenceWidth * referenceHeight)));
        translate( -camera.position.x, -camera.position.y);
        rotate(camera.angle);
        scale(camera.scale);
        super.draw();
        popMatrix();
    }
    
    // TODO: This should act as a camera and draw the layers it holds according to their positions or so idk
}