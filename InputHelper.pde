boolean mouseReleased = false;
boolean mouseClicked = false;

//https://docs.oracle.com/javase/7/docs/api/java/awt/event/KeyEvent.html#:~:text=a%20KeyEvent%20object.-,Method%20Summary,-Methods
void keyPressed() {
    input.pressedKeys.put(keyCode, key);
}

void keyReleased() {
    input.pressedKeys.remove(keyCode);
}

void mouseReleased() {
    mouseReleased = true;
    mouseClicked = false;
}

void mousePressed() {
    mouseReleased = false;
    mouseClicked = false;
}

void mouseClicked() {
    mouseClicked = true;
}

// Defers the key handling to be just before or just after upate(),
// depending on the order of the layer stack in your main layerManager
class InputHelper extends Layer {
    private Map<Integer, Character> pressedKeys = new HashMap<Integer, Character>(); // Does this have to be synchronized?

    public Iterable<Map.Entry<Integer, Character>> getPressedKeys() {
        return pressedKeys.entrySet();
    }

    @Override
    protected void update() {
        for (Map.Entry<Integer, Character> pressedKey : getPressedKeys()) {
            key = pressedKey.getValue();
            keyCode = pressedKey.getKey();
            layerManager.processInput();
        }
    }
}
