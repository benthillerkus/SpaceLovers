class Camera extends GameObject {
    Camera() {
        this.hidden = true;
    }

    @Override
    void update() {
        position = game.ship.position; // BUG: WHY THE ACTUAL FUCK IS THIS NOT WORKING?????? 👿
    }
}
