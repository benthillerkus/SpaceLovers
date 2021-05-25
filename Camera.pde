class Camera extends GameObject {

    @Override
    protected void reset() {
        super.reset();
        this.hidden = true;
    }

    @Override
    void update() {
        position = PVector.add(game.ship.position, PVector.mult(game.ship.speed, 12));
    }
}
