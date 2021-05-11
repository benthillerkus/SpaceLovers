enum GameState {
    Play, Pause, Lost, Won;
}

GameState gameState;
LayerManager<Layer> layerManager = new LayerManager<Layer>();
GameWorld gameWorld = new GameWorld();

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

int referenceWidth = 1000;
int referenceHeight = 800;

void setup() {
    size(1000, 800);
    surface.setResizable(true);
    initGame();
}

void initGame() {
    gameState = GameState.Play;
    layerManager.layers.clear();
    layerManager.layers.add(backdrop);
    gameWorld = new GameWorld();
    gameWorld.layers.add(new Ship());
    layerManager.layers.add(gameWorld);
    layerManager.layers.add(hud);
}

void draw() {
    layerManager.render();
}
