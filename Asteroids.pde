import java.util.*;

LayerManager<Layer> layerManager = new LayerManager<Layer>();

Game game;

int referenceWidth = 1000;
int referenceHeight = 800;

void setup() {
    size(1000, 800);
    surface.setResizable(true);
    
    game = new Game();
    
    layerManager.layers.add(game);
    layerManager.layers.add(hud);
    
    game.start();
}

void draw() {
    layerManager.update();
    background(0);
    layerManager.render();
}

Layer hud = new Layer() {
    @Override
    protected void draw() {
        textAlign(LEFT);
        textSize(15);
        text(frameRate, width - 70, 25);
    }
};

Set<String> pressedKeys = new HashSet<String>(); // Does this have to be synchronized?

//https://docs.oracle.com/javase/7/docs/api/java/awt/event/KeyEvent.html#:~:text=a%20KeyEvent%20object.-,Method%20Summary,-Methods
void keyPressed() {
    pressedKeys.add(java.awt.event.KeyEvent.getKeyText(keyCode));
}

void keyReleased() {
    pressedKeys.remove(java.awt.event.KeyEvent.getKeyText(keyCode));
}
