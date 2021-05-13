abstract class GameObject extends Layer {
    PVector position = new PVector(0, 0);
    
    @Override
    void render() {
        pushMatrix();
        translate(position.x, position.y);
        super.render();
        popMatrix();
    }
}