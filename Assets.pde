import processing.sound.SoundFile;

public class ImageAssets {
    PImage asteroidLarge;
    PImage ship, gun, thruster, shieldInactive, shieldActive, shield;
    PImage effectProjectileTiny, asteroidTiny1;
    PImage background;

    ImageAssets(PApplet parent) {
        asteroidLarge = loadImage("data/Art/Asteroid-Large.png");

        ship = loadImage("data/Art/Ship.png");
        gun = loadImage("data/Art/Gun.png");
        thruster = loadImage("data/Art/Thruster.png");
        shield = loadImage("data/Art/Shield.png");

        effectProjectileTiny = loadImage("data/Art/Effect-Projectile-Tiny.png");
        asteroidTiny1 = loadImage("data/Art/Asteroid-Tiny-1.png");

        this.background = loadImage("data/Art/Background.png");
    }
}

public class SoundAssets {
    SoundFile thrusterHigh, thrusterLow, menuForward, menuBack, laser, collisionSound, menuMachinery;
    float vol = 1;
    processing.sound.Sound menuVolume;

    SoundAssets(PApplet parent) {
        // TODO: In theory loading could be deferred
        thrusterHigh = new SoundFile(parent, "data/GameplaySound/thrusterHigh.mp3");
        thrusterHigh.amp(0.6 * 1.5);
        thrusterLow = new SoundFile(parent, "data/GameplaySound/thrusterLow.mp3");
        thrusterLow.amp(0.6 * 1.5);
        menuForward = new SoundFile(parent, "data/MenuSound/MenuForwardTines.mp3");
        menuBack = new SoundFile(parent, "data/MenuSound/MenuBackTines.mp3");
        laser = new SoundFile(parent, "data/GameplaySound/bang.mp3");
        collisionSound = new SoundFile(parent, "data/GameplaySound/asteroidHit.mp3");
        collisionSound.amp(0.3);
        menuMachinery = new SoundFile(parent, "data/MenuSound/MachineryMenuSound.mp3");
        menuMachinery.amp(0.3);
        menuVolume = new processing.sound.Sound(parent);
    }
}
