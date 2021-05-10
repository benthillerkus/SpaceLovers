enum GameState {
    Play, Pause, Lost, Won;
}

LayerManager layerManager;
Layer hud = new Layer() {
    @Override
    protected void draw() {
        textAlign(LEFT);
        textSize(15);
        text(frameRate, width - 70, 25);
    }
};
Layer backdrop = new Layer(true, false) {
    @Override
    protected void draw() {
        background(0);
    }
};
GameState gameState;

void setup() {
    size(1000, 800);

    layerManager = new LayerManager();
    layerManager.layers.add(backdrop);
    layerManager.layers.add(hud);

    initGame();
}

void initGame() {
    gameState = GameState.Play;
}

void draw() {
    layerManager.render();
}
