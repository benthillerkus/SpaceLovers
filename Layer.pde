abstract class Layer {
    // Don't touch this 😫
    // Especially calling .beingDraw() and .endDraw() will fuck shit up
    final protected PGraphics canvas;
    // The last frame that has been rendered
    private int frame = -1;
    // Has this frame already been rendered?
    private boolean renderedThisFrame = false;
    // Has the canvas ever been rendered?
    private boolean renderedOnce = false;
    
    Layer(int width, int height) {
        canvas = createGraphics(width, height);
    }
    
    // Put your drawing code here
    abstract protected void draw();

    // Runs once every frame
    // Use the opportunity to figure out if rerendering is needed
    protected void processLogic() {};

    // Only relevant to the default implementation of needsRerendering()
    boolean rerenderPlease = true;

    // Return false to skip rendering & return the existing canvas in render()
    // Try to keep the logic here simple and offload calculation into processLogic()
    protected boolean needsRerendering() {
        return rerenderPlease;
    };
    
    final PGraphics render() {
        if (frameCount != this.frame) renderedThisFrame = false;
        if (renderedThisFrame) return canvas;
        // ⬆ make sure that everything below ⬆
        // ⬇ is only being run once a frame. ⬇
        processLogic();
        if (needsRerendering() || !renderedOnce) {
            canvas.beginDraw();
            draw();
            canvas.endDraw();
            renderedOnce = true;
        }
        renderedThisFrame = true;
        return canvas;
    }
}

class LayerManager extends Layer {
    final ArrayList<Layer> layers;
    
    LayerManager(int width, int height) {
        super(width, height);
        layers = new ArrayList<Layer>();
    }

    // idk if this is actually worth it 🤔
    protected boolean needsRerendering() {
        for (Layer layer : layers) {
            if (layer.needsRerendering()) return true;
        }
        return false;
    }
    
    protected void draw() {
        for (Layer layer : layers) {
            canvas.beginDraw();
            image(layer.render(), 0, 0);
            canvas.endDraw();
        }
    }
}
