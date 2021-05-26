class Hud extends Layer {
    @Override
    protected void draw() {
        pushMatrix(); // Offset Status Bar
        translate(0, -20 * pixelFactor);

        // Health
        noFill();
        stroke(125, 235, 125, 80);
        strokeWeight(1 * pixelFactor);
        rectMode(CENTER);
        rect(width / 2, height - 70 * pixelFactor, width / 2.75, 20 * pixelFactor, 25 * pixelFactor);
        noStroke();
        fill(75, 255, 75, 50);
        rect(width / 2, height - 70 * pixelFactor, (width / 2.75) * game.ship.health / game.ship.maxHealth, 20 * pixelFactor, 25 * pixelFactor);

        // Speed
        fill(255);
        textFont(fonts.display);
        textSize(50 * pixelFactor);
        textAlign(CENTER, BOTTOM);
        text(int(game.ship.speed.mag() * 60), width * 0.88, height - 48 * pixelFactor);
        textSize(20 * pixelFactor);
        text("m/s", width * 0.92, height - 38 * pixelFactor);

        // Position
        pushMatrix(); // Move Minimap
        translate(width * 0.14, height - 85 * pixelFactor);
        stroke(255);
        strokeWeight(1 * pixelFactor);
        noFill();
        ellipseMode(RADIUS);
        float mapSize = 55 * pixelFactor;
        ellipse(0, 0, mapSize, mapSize);
        strokeWeight(8 * pixelFactor);
        stroke(255);
        PVector shipDrawPoint = game.ship.position.copy().div(175).limit(mapSize);
        point(shipDrawPoint.x, shipDrawPoint.y);

        for (Layer layer : game.missions.overlay.layers) {
            if (layer instanceof Beacon) {
                if (layer.hidden) continue;
                Beacon beacon = (Beacon) layer;
                shipDrawPoint = beacon.position.copy().div(175).limit(mapSize);
                stroke(beacon.missionColor);
                point(shipDrawPoint.x, shipDrawPoint.y);
            }
        }
        popMatrix(); // Move Minimap
        popMatrix(); // Offset Status Bar

        // Modes
        Player[] players = {game.player1, game.player2};
        float smallIconSize = 45 * pixelFactor;
        for (int i = 0; i < 2; i++) {
            float offsetX = width * (i == 0 ? 0.06 : 0.94);
            float offsetXoffset = pixelFactor * 8 * (i == 0 ? 1 : -1);
            imageMode(CENTER);
            image(players[i].getIcon(players[i].mode), offsetX, height / 2, 60 * pixelFactor, 60 * pixelFactor);
            tint(255, 80);
            image(players[i].getIcon(players[i].mode.next()), offsetX + offsetXoffset, height * 0.59, smallIconSize, smallIconSize);
            image(players[i].getIcon(players[i].mode.previous()), offsetX + offsetXoffset, height * 0.41, smallIconSize, smallIconSize);
            noTint();
        }
    }
}
