class Hud extends Layer {
    @Override
    protected void draw() {

        // Health
        noFill();
        stroke(235, 125, 125, 80);
        rectMode(CENTER);
        rect(width / 2, height - 50 * pixelFactor, width / 3, 20 * pixelFactor);
        noStroke();
        fill(255, 75, 75, 50);
        rect(width / 2, height - 50 * pixelFactor, (width / 3) * game.ship.health / game.ship.maxHealth, 20 * pixelFactor);
    }
}