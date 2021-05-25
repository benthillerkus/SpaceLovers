
//https://docs.oracle.com/javase/7/docs/api/java/awt/event/KeyEvent.html#:~:text=a%20KeyEvent%20object.-,Method%20Summary,-Methods
void keyPressed() {
    input.pressedKeys.put(keyCode, key);
    input.releasedKeys.remove(keyCode);
}

void keyReleased() {
    input.pressedKeys.remove(keyCode);
    input.releasedKeys.put(keyCode, key);
}

enum InputType {
    Pressed, Clicked;
}

InputType inputType;

// Defers the key handling to be just before or just after upate(),
// depending on the order of the layer stack in your main layerManager
class InputHelper extends Layer {
    private Map<Integer, Character> pressedKeys = new HashMap<Integer, Character>(); // FIXME: Does this have to be synchronized?
    private Map<Integer, Character> releasedKeys = new HashMap<Integer, Character>();

    public Iterable<Map.Entry<Integer, Character>> getPressedKeys() {
        return pressedKeys.entrySet();
    }

    public Iterable<Map.Entry<Integer, Character>> getReleasedKeys() {
        return releasedKeys.entrySet();
    }

    @Override
    protected void update() {
        for (Map.Entry<Integer, Character> pressedKey : getPressedKeys()) {
            key = pressedKey.getValue();
            keyCode = pressedKey.getKey();
            inputType = InputType.Pressed;
            layerManager.processInput();
        }
        for (Map.Entry<Integer, Character> releasedKey : getReleasedKeys()) {
            key = releasedKey.getValue();
            keyCode = releasedKey.getKey();
            inputType = InputType.Clicked;
            layerManager.processInput();
        }
        releasedKeys.clear();
    }
}
