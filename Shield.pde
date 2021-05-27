class Shield extends ShipComponent {
    @Override
    protected void reset() {
        super.reset();
        size = 28;
    }

    @Override
    protected void collision(GameObject enemy) {
        if (enemy instanceof Debris) {
            game.stats.caughtDebris++;
        }
    }

    @Override
    protected void draw() {
        strokeWeight(1.3 * pixelFactor);
        stroke(125, 175, 225, 60);
        fill(125, 175, 225, 30);
        arc(0, 0, size, size, -PI, 0, PIE);
        float fac = (float(frameCount) % 96 / 96) * size;
        noStroke();
        arc(0, 0, fac, fac, -PI, 0, PIE);
        imageMode(CORNER);
        image(images.shield, -28, -14, 56, 30);
    }

    @Override
    void doAction() {}
    
    @Override
    void doEnhancedAction() {}
}
