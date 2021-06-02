class Shield extends ShipComponent {
    final float minSize = 28;
    final float maxSize = 86;

    @Override
    protected void reset() {
        super.reset();
        size = minSize;
    }

    @Override
    protected void collision(GameObject enemy) {
        if (enemy instanceof Debris) {
            game.stats.caughtDebris++;
        }
    }

    @Override
    protected void update() {
        super.update();
        size = max(minSize, size * 0.985);
    }

    @Override
    protected void draw() {
        strokeWeight(1.3 * pixelFactor);
        stroke(125, 175, 225, 60);
        fill(125, 175, 225, doingAction.isNow() ? (8 * sin(frameCount * 0.2)) + 60 : 30);
        float startArc = lerp(-PI * 0.96, -PI * 1.1, smoothstep(minSize, maxSize, size));
        float stopArc = lerp(-PI + PI * 0.96, PI * 0.1, smoothstep(minSize, maxSize, size));
        arc(0, 0, size - 1, size - 1, startArc, stopArc, PIE);
        float pulseSpeed = doingAction.isNow() ? 48 : 96;
        float fac = (float(frameCount) % pulseSpeed / pulseSpeed) * size - 1;
        noStroke();
        arc(0, 0, fac, fac, startArc, stopArc, PIE);
        imageMode(CORNER);
        image(images.shield, -minSize, -14, 56, 30);
    }

    @Override
    void doAction() {
        size += 0.5;
    }
    
    @Override
    void doEnhancedAction() {
        size = maxSize;
    }
}
