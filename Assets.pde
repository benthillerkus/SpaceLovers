import processing.sound.SoundFile;

public class ImageAssets {
    PImage asteroidLarge, asteroidTiny1;
    PImage ship, gun, thruster, shieldInactive, shieldActive, shield;
    PImage effectProjectileTiny, effectMuzzleMedium, effectMuzzleMedium1, effectMuzzleTiny1;
    PImage iconControlBlue, iconGunBlue, iconShieldBlue;
    PImage iconControlRed, iconGunRed, iconShieldRed;
    PImage background;

    ImageAssets(PApplet parent) {
        asteroidLarge = loadImage("data/Art/Asteroid-Large.png");
        asteroidTiny1 = loadImage("data/Art/Asteroid-Tiny-1.png");

        ship = loadImage("data/Art/Ship.png");
        gun = loadImage("data/Art/Gun.png");
        thruster = loadImage("data/Art/Thruster.png");
        shield = loadImage("data/Art/Shield.png");

        effectProjectileTiny = loadImage("data/Art/Effect-Projectile-Tiny.png");
        effectMuzzleMedium = loadImage("data/Art/Effect-Muzzle-Medium.png");
        effectMuzzleMedium1 = loadImage("data/Art/Effect-Muzzle-Medium-1.png");
        effectMuzzleTiny1 = loadImage("data/Art/Effect-Muzzle-Tiny-1.png");

        iconControlBlue = loadImage("data/Art/Icon-Control-Blue.png");
        iconGunBlue = loadImage("data/Art/Icon-Gun-Blue.png");
        iconShieldBlue = loadImage("data/Art/Icon-Shield-Blue.png");

        iconControlRed = loadImage("data/Art/Icon-Control-Red.png");
        iconGunRed = loadImage("data/Art/Icon-Gun-Red.png");
        iconShieldRed = loadImage("data/Art/Icon-Shield-Red.png");

        this.background = loadImage("data/Art/Background.png");
    }
}

public class FontAssets {
    PFont display = createFont("data/Fonts/Audiowide-Regular.ttf", 80);
    PFont pixel = createFont("data/Fonts/PressStart2P-Regular.ttf", 25);
    PFont body = createFont("data/Fonts/ProstoOne-Regular.ttf", 50);
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
        laser.amp(0.6);
        collisionSound = new SoundFile(parent, "data/GameplaySound/asteroidHit.mp3");
        collisionSound.amp(0.3);
        menuMachinery = new SoundFile(parent, "data/MenuSound/MachineryMenuSound.mp3");
        menuMachinery.amp(0.3);
        menuVolume = new processing.sound.Sound(parent);
    }
}
