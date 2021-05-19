import processing.sound.*;

public class ImageAssets {
    PImage asteroidLarge;
    PImage ship, gun, thruster, shieldInactive, shieldActive;
    PImage effectProjectileTiny;
    PImage background;

    ImageAssets(PApplet parent) {
        asteroidLarge = loadImage("data/Art/Asteroid-Large.png");

        ship = loadImage("data/Art/Ship.png");
        gun = loadImage("data/Art/Gun.png");
        thruster = loadImage("data/Art/Thruster.png");
        //shieldInactive = loadImage("data/Art/Shield-Active.png");
        //shieldActive = loadImage("data/Art/Shield-Inactive.png");
        shiel = loadImage("data/Art/Shield.png");

        effectProjectileTiny = loadImage("data/Art/Effect-Projectile-Tiny.png");

        this.background = loadImage("data/Art/Background.png");
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
