class Hud extends Layer {
    @Override
    protected void draw() {

        // Health
        noFill();
        stroke(235, 125, 125, 80);
        rectMode(CENTER);
        rect(width / 2, height - 70 * pixelFactor, width / 3, 20 * pixelFactor);
        noStroke();
        fill(255, 75, 75, 50);
        rect(width / 2, height - 70 * pixelFactor, (width / 3) * game.ship.health / game.ship.maxHealth, 20 * pixelFactor);

        // Speed
        fill(255);
        textSize(50 * pixelFactor);
        textAlign(CENTER, BOTTOM);
        text(int(game.ship.speed.mag() * 60), width * 0.82, height - 45 * pixelFactor);
        textSize(20 * pixelFactor);
        text("m/s", width * 0.85, height - 35 * pixelFactor);
    }
}