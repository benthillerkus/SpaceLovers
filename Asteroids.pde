import java.util.*;
import java.awt.event.KeyEvent;

Game game;
LayerManager<Layer> layerManager = new LayerManager<Layer>();
SoundAssets sounds;
FontAssets fonts;
ImageAssets images;

void setup() {
    size(1000, 800, P2D);
    // surface.setResizable(true);
    smooth(2);
    
    // https://stackoverflow.com/a/20552347/5964129
    // fullScreen(P2D);
    // frameRate(1000);
    // PJOGL pgl = (PJOGL)beginPGL();
    // pgl.gl.setSwapInterval(1);
    // endPGL();
    
    sounds = new SoundAssets(this);
    images = new ImageAssets(this);
    fonts = new FontAssets();

    game = new Game();
    
    layerManager.layers.add(input);
    layerManager.layers.add(backdrop);
    layerManager.layers.add(game);
    layerManager.layers.add(overlay);
}

final int referenceWidth = 1000;
final int referenceHeight = 800;
float pixelFactor = 1.0;

void draw() {
    pixelFactor = sqrt(float((width * height)) / (referenceWidth * referenceHeight));
    layerManager.process();
    layerManager.render();
}

Layer backdrop = new Layer() {
    @Override
    protected void draw() {
        imageMode(CORNER);
        for (int x = 0; x < width; x += images.background.width) {
            for (int y = 0; y < height; y += images.background.height) {
                image(images.background, x, y);
            }
        }
    }
};

Layer overlay = new Layer() {
    int size;

    @Override
    protected void update() {
        size = int(10 * (pixelFactor * 0.5 + 0.5)); // Scale more conservatively
    }
    
    @Override
    protected void draw() {
        textAlign(RIGHT);
        textFont(fonts.pixel);
        textSize(size);
        fill(255);
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
