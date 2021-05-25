class GameOverScreen extends LayerManager<Layer> {

    GameOverScreen() {
        super();
        layers.add(backButton);
        reset();
    }

    @Override
    protected void draw() {
        super.draw();
        stroke(255);
        fill(255);
        textSize(50 * pixelFactor);

        text("Game Over", width / 2, height / 2);
    }
}
