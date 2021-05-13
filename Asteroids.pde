import java.util.*;
import java.awt.event.KeyEvent;

LayerManager<Layer> layerManager = new LayerManager<Layer>();

Game game;

int referenceWidth = 1000;
int referenceHeight = 800;

void setup() {
    size(1000, 800);
    surface.setResizable(true);
    
    game = new Game();
    
    layerManager.layers.add(input);
    layerManager.layers.add(game);
    layerManager.layers.add(hud);
    
    game.start();
}

void draw() {
    layerManager.process();
    background(0);
    layerManager.render();
}

Layer hud = new Layer() {
    @Override
    protected void draw() {
        textAlign(RIGHT);
        textSize(15);
        text(frameRate, width - 15, 25);
        text(frameCount, width - 15, 25 + 15 + 5);

        textAlign(LEFT);
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<Integer, Character> k : input.getPressedKeys()) {
            sb.append(KeyEvent.getKeyText(k.getKey())).append("  ");
        }
        text(sb.toString(), 15, 25);
    }
};

InputHelper input = new InputHelper();
