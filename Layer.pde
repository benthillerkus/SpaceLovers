abstract class Layer {    
    // Runs once every frame before draw
    protected void processLogic() {};

    // Put your drawing code here
    abstract protected void draw();

    final void render() {
        processLogic();
        draw();
    }
}

class LayerManager extends Layer {
    final ArrayList<Layer> layers;
    
    LayerManager() {
        layers = new ArrayList<Layer>();
    }
    
    protected void draw() {
        for (Layer layer : layers) {
            layer.render();
        }
    }
}
