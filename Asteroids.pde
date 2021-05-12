import processing.sound.*;
//erstellen verschiedenster Soundvaraiblen
SoundFile laserSound, thruster, asteroidHit, winSound, loseSound;
enum GameState {
    Play, Pause, Lost, Won;
}

final int numAsteroids = 5;

GameState state = GameState.Play;

ArrayList<FlyingThing> things = new ArrayList<FlyingThing>();
Ship ship;
boolean keyLeft, keyRight, keyUp, keyDown;

// Jetzt die Funktionen:

void setup() {
    size(1000, 800);
    initGame();
    laserSound = new SoundFile(this, "data/GameplaySound/bang.mp3");
    asteroidHit = new SoundFile(this, "data/GameplaySound/asteroidHit.mp3");
    asteroidHit.amp(0.5);
    winSound = new SoundFile(this, "data/GameplaySound/win.mp3");
    winSound.amp(0.2);
    loseSound = new SoundFile(this, "data/GameplaySound/lose.mp3");
    loseSound.amp(0.2);
}

void initGame() {
    ship = new Ship(new PVector(width / 2, height / 2),
        new PVector());
    things.add(ship);
    
    // generate asteroids
    for (int i = 0; i < numAsteroids; i++) {
        things.add(new Asteroid());
    }
    
    state = GameState.Play;
}

void draw() {
    background(0);
    noFill();
    stroke(255);
    
    for (FlyingThing thing : things) {
        if (thing.alive) {
            thing.update();
            thing.render();
        }
    }
    switch(state) {
        case Play:
        for (FlyingThing thing : things) {
            thing.update();
            thing.render();
        }
        checkKeys();
        checkCollision();
        checkWon();
        break;
        
        case Pause:
        for (FlyingThing thing : things) {
            thing.render();
        }
        break;
        
        case Lost:
        textAlign(CENTER);
        textSize(40);
        text("GAME OVER!\n(press enter)", width / 2, height / 2);
        things.clear();
        break;
        
        case Won:
        textAlign(CENTER);
        textSize(40);
        text("YOU WON!\n(press enter)", width / 2, height / 2);
        things.clear();
        break;
    }
    
}

void checkKeys() {
    if (keyLeft) ship.angle -= radians(2);
    if (keyRight) ship.angle += radians(2);
    if (keyUp) ship.thrustForward(.05);
    if (keyDown) ship.thrustForward(-.05);
    
}


void keyPressed() {
    switch(keyCode) {
        case UP:
        keyUp = true;
        break;
        case DOWN:
        keyDown = true;
        break;
        case LEFT:
        keyLeft = true;
        break;
        case RIGHT:
        keyRight = true;
        break;
    }
    if (state == GameState.Play || state == GameState.Pause) {
        if (key == 'p') state = state == GameState.Play ? GameState.Pause : GameState.Play;
    }
    if (keyCode == ENTER) {
        if (state == GameState.Lost || state == GameState.Won) initGame();
    }
    
    if (state == GameState.Play && key == ' ') {
        laserSound.play();
        Bullet b = ship.fire();
        things.add(b);
        if (things.size() > 10) {
            collectGarbage();
        }
        
    } 
}

void keyReleased() {
    switch(keyCode) {
        case UP:
        keyUp = false;
        break;
        case DOWN:
        keyDown = false;
        break;
        case LEFT:
        keyLeft = false;
        break;
        case RIGHT:
        keyRight = false;
        break;
    }
}

void checkCollision() {
    boolean coll = false;
    for (FlyingThing thing : things) {
        if (thing instanceof Asteroid) {
            if (ship.checkCollision((Asteroid)thing)) {
                coll = true;
            }
        }
        
        if (thing instanceof Bullet) {
            
            // prüfe alle Asteroiden
            for (FlyingThing thing2 : things) {
                if (thing2.alive && thing2 instanceof Asteroid) {
                    Bullet b = (Bullet)thing;
                    Asteroid a = (Asteroid)thing2;
                    
                    // bei Kollision denAsteroiden auf tot schalten
                    if (b.pos.dist(a.pos) < a.size / 2) {
                        a.alive = false;
                        asteroidHit.play();
                    }
                }
            }
        }
    }
    if (coll) {
        state = GameState.Lost;
        loseSound.play();
    }
}

void checkWon() {
    boolean Won = true;
    
    // sobald ich einen lebenden Asteroiden finde,
    // bin ich noch nicht fertig
    for (FlyingThing thing : things) {
        if (thing instanceof Asteroid && thing.alive) {
            Won = false;
            return;
        }
    }
    if (Won) {
        state = GameState.Won;
        winSound.play();
    }
}

void collectGarbage() {
    ArrayList<FlyingThing> newThings =
    new ArrayList<FlyingThing>();
    for (FlyingThing thing : things) {
        if (thing.alive) {
            newThings.add(thing);
        }
    }
    things = newThings;
}
