class Button extends Layer {
    String label;
    float boxWidth;
    float boxHeight;
    PVector position;
    color buttonColor;
    float actualWidth;
    float padding;
    boolean roundCorners;
    boolean textOnly;
    float x;
    float y;

    Button() {
        super();
        reset();
    }

    @Override
    protected void reset() {
        label = "No Text";
        boxWidth = 200;
        boxHeight = 75;
        padding = 35;
        x = 0.5;
        y = 0.5;
        position = new PVector(width / 2, height / 2);
        buttonColor = color(255);
        actualWidth = boxWidth * pixelFactor;
        roundCorners = false;
        textOnly = false;
    }

    @Override
    protected void draw() {
        fill(buttonColor);
        textAlign(CENTER);
        textSize((boxHeight - padding) * pixelFactor);
        text(label, position.x, position.y);
        actualWidth = max(boxWidth * pixelFactor, textWidth(label)) + padding;
        
        if (textOnly) return;

        stroke(buttonColor);
        strokeWeight(1.5 * pixelFactor);
        if (!isMouseOver()) {
            noFill();
        } else {
            fill(buttonColor, 30);
        }
        rectMode(CENTER); 
        rect(position.x,
            position.y - (boxHeight - padding) / 3 * pixelFactor,
            actualWidth,
            boxHeight * pixelFactor,
            roundCorners ? 999 : 0);
    }

    boolean isMouseOver() {
        return mouseX > position.x - actualWidth / 2 &&
            mouseX < position.x + actualWidth / 2 &&
            mouseY > position.y - (boxHeight * pixelFactor) / 2 &&
            mouseY < position.y + (boxHeight * pixelFactor) / 2;
    }

    @Override
    protected void update() {
        position.x = width * x;
        position.y = height * y;
        if (mousePressed && isMouseOver()) {
            onClick();
        }
    }

    protected void onClick() {
        println("Glaub an deine Träume");
    };
}
