class Hud extends Layer {
    @Override
    protected void draw() {
        int headingSize = int(25 * pixelFactor);
        int missionSize = int(16 * pixelFactor);
        int marginLeft = int(25 * pixelFactor);
        int marginTop = int(50 * pixelFactor);
        textSize(headingSize);
        text("Missions", marginLeft, marginTop);

        textSize(missionSize);
        for (int i = 0; i < game.missions.size(); i++) {
            text(game.missions.get(i).toString(), marginLeft, marginTop + headingSize + (5 + missionSize) * i);
        }
    }
}