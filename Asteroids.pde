LayerManager manager;

void settings() {
    fullScreen();
}

void setup() {
    println("My name Jeff");
    manager = new LayerManager(width, height);
    manager.layers.add(new Layer(width, height) {
        protected void draw() {
            clear();
            noStroke();
            fill(21, 145, 180, 60);
            rect(frameCount, 20, 250, 150);
            fill(120, 145, 40, 30);
            rect(frameCount, 60, 50, 50);
        }
    });
    manager.layers.add(new Layer(width, height) {
        protected void draw() {
            stroke(0);
            fill(int(random(255)), int(random(255)), int(random(255)), 100);
            rect(50, 50, 150, 150);
        }

        protected boolean needsRerendering() {
            return mousePressed;
        }
    });
}

void draw() {
    background(255);
    image(manager.render(), 0, 0);
}
