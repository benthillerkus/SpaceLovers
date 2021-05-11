class Camera {
    PVector position = new PVector(0, 0);
    float angle = 0.0;
    float zoom = 1.0;

    void turn(float degrees) {
        angle = (angle + degrees) % 360;
    }
}

class GameWorld extends LayerManager<GameObject> {
    Camera camera = new Camera();

    @Override
    protected void draw() {
        pushMatrix();
        translate(width / 2, height / 2);
        translate(camera.position.x, camera.position.y);
        rotate(camera.angle);
        scale(camera.zoom);
        super.draw();
        popMatrix();
    }

    // TODO: This should act as a camera and draw the layers it holds according to their positions or so idk
}