import processing.sound.*;
SoundFile sound;

void setup() {
    sound = new SoundFile(this, "/data/SANIC.mp3");
    sound.play();
}

void draw() {
    println("Hallo Welt geht das jetzt?");
}
