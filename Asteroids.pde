import java.util.*;
import java.awt.event.KeyEvent;
import processing.sound.*;

SoundFile thrusterHigh, thrusterLow;
Game game;
LayerManager<Layer> layerManager = new LayerManager<Layer>();

void setup() {
    size(1000, 800);
    surface.setResizable(true);
    
    // https://stackoverflow.com/a/20552347/5964129
    // fullScreen(P2D);
    // frameRate(1000);
    // PJOGL pgl = (PJOGL)beginPGL();
    // pgl.gl.setSwapInterval(1);
    // endPGL();

    thrusterHigh = new SoundFile(this, "data/GameplaySound/thrusterHigh.mp3");
    thrusterHigh.amp(0.6 * 1.5);
    thrusterLow = new SoundFile(this, "data/GameplaySound/thrusterLow.mp3");
    thrusterLow.amp(0.6 * 1.5);

    game = new Game();
    
    layerManager.layers.add(input);
    layerManager.layers.add(game);
    layerManager.layers.add(hud);
    
    game.start();
}

final int referenceWidth = 1000;
final int referenceHeight = 800;
float pixelFactor = 1.0;

void draw() {
    pixelFactor = sqrt(float((width * height)) / (referenceWidth * referenceHeight));
    layerManager.process();
    background(0);
    layerManager.render();
}

Layer hud = new Layer() {
    int size = 15;

    @Override
    protected void update() {
        size = int(15 * (pixelFactor * 0.5 + 0.5)); // Scale more conservatively
    }
    
    @Override
    protected void draw() {
        textAlign(RIGHT);
        textSize(size);
        text(frameRate, width - size, 25);
        text(frameCount, width - size, 25 + size + 5);
        
        textAlign(LEFT);
        StringBuilder sb = new StringBuilder();
        for (Map.Entry < Integer, Character > k : input.getPressedKeys()) {
            sb.append(KeyEvent.getKeyText(k.getKey())).append("  ");
        }
        text(sb.toString(), size, 25);
        
        text(String.format("%06d | %06d",
            int(game.ship.position.x), int(game.ship.position.y)),
            size, height - size);
    }
};

InputHelper input = new InputHelper();
