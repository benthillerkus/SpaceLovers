import processing.sound.*;

public class ImageAssets {
    ImageAssets(PApplet parent) {

    }
}

public class SoundAssets {
    SoundFile thrusterHigh, thrusterLow;

    SoundAssets(PApplet parent) {
        // TODO: In theory loading could be deferred
        thrusterHigh = new SoundFile(parent, "data/GameplaySound/thrusterHigh.mp3");
        thrusterHigh.amp(0.6 * 1.5);
        thrusterLow = new SoundFile(parent, "data/GameplaySound/thrusterLow.mp3");
        thrusterLow.amp(0.6 * 1.5);
    }
}
