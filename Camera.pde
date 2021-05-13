class Camera extends GameObject {

    Camera() {
        this.hidden = true;
    }

    @Override
    void update() {
        position = PVector.add(game.ship.position, PVector.mult(game.ship.speed, 12));
    }
}
