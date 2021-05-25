class Layer {
    private int lastProcessedFrame;
    boolean frozen;
    boolean hidden;

    Layer() {
        // I just wanna call reset here
        // Fuck Java 😍
        lastProcessedFrame = -1;
        frozen = false;
        hidden = false;
    }

    Layer(boolean frozen, boolean hidden) {
        lastProcessedFrame = -1;
        this.frozen = frozen;
        this.hidden = hidden;
    }

    // Handle key input events here
    protected void input() {}

    // Runs once every frame before draw
    protected void update() {};

    // Put your drawing code here
    protected void draw() {};

    protected void reset() {
        lastProcessedFrame = -1;
        frozen = false;
        hidden = false;
    }

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

    @Override
    public String toString() {
        return this.getClass().getName();
    }
}

class LayerManager<L extends Layer> extends Layer {
    ArrayList<L> layers = new ArrayList<L>();

    void hideAll() {
        for (L layer : layers) {
            layer.hidden = true;
        }
    }

    void freezeAll() {
        for (L layer : layers) {
            layer.frozen = true;
        }
    }
    
    @Override
    protected void reset() {
        super.reset();
        for (L layer : layers) {
            layer.reset();
        }
    }
    
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
