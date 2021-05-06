import processing.sound.*;
SoundFile sound;

void setup() {
    sound = new SoundFile(this, "/assets/SANIC.mp3");
    sound.play();
}

void draw() {}
