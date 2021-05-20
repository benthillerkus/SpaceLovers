class Layer {
    private int lastProcessedFrame = -1;
    boolean frozen = false;
    boolean hidden = false;

    Layer() {}

    Layer(boolean frozen, boolean hidden) {
        this.frozen = frozen;
        this.hidden = hidden;
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
        if (!frozen) input();
    }

    final void process() {
        if (!frozen && frameCount != lastProcessedFrame) {
            update();
            lastProcessedFrame = frameCount;
        }
    }

    void render() {
        if (!hidden) draw();
    }
}

class LayerManager<L extends Layer> extends Layer {
    ArrayList<L> layers = new ArrayList<L>();

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
