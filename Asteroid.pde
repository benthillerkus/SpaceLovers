class Asteroid extends FlyingThing {

float size;

Asteroid() {

// Übergebe Konstruktor der Oberklasse zufällige
// Position und Geschwindigkeit
super(new PVector(random(0,width), random(0,height)),
new PVector(random(-1,1), random(-1,1)));

size = random(10,30);
}

void render() {
stroke(255);
ellipse(pos.x, pos.y, size, size);
}
}