class Hud extends Layer {
    @Override
    protected void draw() {
        pushMatrix();
        translate(0, -30 * pixelFactor);

        // Health
        noFill();
        stroke(235, 125, 125, 80);
        strokeWeight(1 * pixelFactor);
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

        // Position
        pushMatrix();
        translate(width * 0.15, height - 70 * pixelFactor);
        stroke(255);
        strokeWeight(1 * pixelFactor);
        noFill();
        ellipseMode(RADIUS);
        float mapSize = 55 * pixelFactor;
        ellipse(0, 0, mapSize, mapSize);
        strokeWeight(8 * pixelFactor);
        stroke(215, 145, 200);
        PVector shipDrawPoint = game.ship.position.copy().div(175).limit(mapSize);
        point(shipDrawPoint.x, shipDrawPoint.y);
        popMatrix();

        popMatrix();
    }
}