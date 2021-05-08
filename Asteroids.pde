LayerManager manager;

void settings() {
    fullScreen();
}

void setup() {
    manager = new LayerManager();
    manager.layers.add(new Layer() {
        color c = color(int(random(255)), int(random(255)), int(random(255)), 100);

        protected void processLogic() {
            if (mousePressed) {
                c = color(int(random(255)), int(random(255)), int(random(255)), 100);
            }
        }

        protected void draw() {
            stroke(0);
            fill(c);
            rect(50, 50, 150, 150);
        }
    });
    manager.layers.add(new Layer() {
        protected void draw() {
            noStroke();
            fill(21, 145, 180);
            rect(frameCount, 20, 250, 150);
            fill(120, 145, 40);
            rect(frameCount, 60, 50, 100);
        }
    });
}

void draw() {
    background(255);
    manager.render();
}
