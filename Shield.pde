class Shield extends ShipComponent {
    @Override
    protected void reset() {
        super.reset();
        size = 20;
    }

    @Override
    protected void collision(GameObject enemy) {
        if (enemy instanceof  Debris) {
            game.stats.caughtDebris++;
        }
    }

    @Override
    protected void draw() {
        imageMode(CORNER);
        image(images.shield, -28, -8, 56, 30);
    }

    @Override
    void action() {}
    
    @Override
    void enhancedAction() {}
}
