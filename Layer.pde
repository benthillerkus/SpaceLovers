abstract class Layer {
    private int lastProcessedFrame = -1;
    boolean freeze = false;
    boolean hide = false;

    Layer() {}

    Layer(boolean freeze, boolean hide) {
        this.freeze = freeze;
        this.hide = hide;
    }

    // Runs once every frame before draw
    protected void update() {};

    final void process() {
        if (!freeze && frameCount != lastProcessedFrame) {
            update();
            lastProcessedFrame = frameCount;
        }
    }

    // Put your drawing code here
    abstract protected void draw();

    final void render() {
        if (!hide) draw();
    }
}

class LayerManager<L extends Layer> extends Layer {
    final ArrayList<L> layers = new ArrayList<L>();

    @Override
    protected void update() {
        for (L layer : layers) {
            layer.process();
        }
    }
    
    @Override
    protected void draw() {
        for (L layer : layers) {
            layer.render();
        }
    }
}
