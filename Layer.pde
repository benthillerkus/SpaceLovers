abstract class Layer {
    final PGraphics canvas;
    // The last frame that has been rendered
    private int frame = -1;
    // Has this frame already been rendered?
    private boolean rendered = false;
    // Has this frame ever been rendered?
    private boolean renderedOnce = false;
    
    Layer(int width, int height) {
        canvas = createGraphics(width, height);
    }
    
    abstract protected void draw();

    protected void processLogic() {};

    protected boolean needsRerendering() {
        return true;
    };
    
    final PGraphics render() {
        if (frameCount != this.frame) rendered = false;
        if (rendered) return canvas;
        processLogic();
        if (needsRerendering() || !renderedOnce) {
            canvas.beginDraw();
            draw();
            canvas.endDraw();
        }
        rendered = true;
        renderedOnce = true;
        return canvas;
    }
}

class LayerManager extends Layer {
    final ArrayList<Layer> layers;
    
    LayerManager(int width, int height) {
        super(width, height);
        layers = new ArrayList<Layer>();
    }

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
