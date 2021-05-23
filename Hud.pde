class Hud extends Layer {
    @Override
    protected void draw() {
        textSize(25 * pixelFactor);
        text("Missions", 25 / pixelFactor, 50 / pixelFactor);
    }
}