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

        float titleSize = 75 * pixelFactor;
        float subtitleSize = 50 * pixelFactor;
        float statSize = 25 * pixelFactor;

        textFont(fonts.display);
        textSize(titleSize);
        float offsetY = height / 4;

        textAlign(CENTER);
        text("Game Over", width / 2, offsetY);
        offsetY += titleSize;

        textFont(fonts.body);
        textSize(subtitleSize);
        String subtitle = "";
        switch (game.missions.state) {
            case NotDone:
                fill(255, 200, 200);
                subtitle = "You Lost!";
                break;
            case Done:
                fill(200, 200, 255);
                subtitle = "You completed your objectives, but didn't exfiltrate";
                break;
            case Finished:
                fill(200, 255, 200);
                subtitle = "You Won";
        }
        text(subtitle, width / 2, offsetY);
        offsetY += subtitleSize + 35 * pixelFactor;

        fill(255);
        textSize(statSize);

        int playedSeconds = game.stats.renderedFrames / 60;
        int playedMinutes = playedSeconds / 60;
        playedSeconds %= 60;

        String[] statTrack = {
            String.format("Completed Missions: %d", game.stats.completedMissions),
            String.format("Caught Debris: %d", game.stats.caughtDebris),
            String.format("Fired Bullets: %d", game.stats.firedBullets),
            String.format("Time: %d:%02d", playedMinutes, playedSeconds),
            String.format("Tanked Damage: %d", game.stats.tankedDamage)
        };

        for (String stat : statTrack) {
            text(stat, width / 2, offsetY);
            offsetY += statSize + 15 * pixelFactor;
        }
    }
}
