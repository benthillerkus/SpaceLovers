class GameOverScreen extends Layer {
    @Override
    protected void draw() {
        stroke(255);
        fill(255);
        textSize(50 * pixelFactor);

        text("Game Over", 0, 0);
    }
}
