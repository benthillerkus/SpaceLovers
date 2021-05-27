class Animation extends Layer {
    int startFrame;
    int animationLength;

    Animation() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        startFrame = -1;
        animationLength = 6;
    }

    void start() {
        startFrame = frameCount;
    }

    float getProgress() {
        if (startFrame == -1) return 0;
        float progress = float(frameCount - startFrame) / animationLength;
        if (progress >= 1) reset();
        return progress;
    }
}