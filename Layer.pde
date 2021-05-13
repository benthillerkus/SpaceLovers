class Layer {
    private int lastProcessedFrame = -1;
    boolean freeze = false;
    boolean hide = false;

    Layer() {}

    Layer(boolean freeze, boolean hide) {
        this.freeze = freeze;
        this.hide = hide;
    }

    // Handle key input events here
    protected void input() {}

    // Runs once every frame before draw
    protected void update() {};

    // Put your drawing code here
    protected void draw() {};

    // === === === === === === === === === === ===
    // Only override the methods above ⬆
    // If you are calling one of these methods
    // you should call the version below ⬇
    // === === === === === === === === === === ===

    final void processInput() {
        if (!freeze) input();
    }

    final void process() {
        if (!freeze && frameCount != lastProcessedFrame) {
            update();
            lastProcessedFrame = frameCount;
        }
    }

    void render() {
        if (!hide) draw();
    }
}

class LayerManager<L extends Layer> extends Layer {
    final ArrayList<L> layers = new ArrayList<L>();

    @Override
    protected void input() {
        for (L layer : layers) {
            layer.processInput();
        }
    }

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
