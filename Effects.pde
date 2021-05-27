class EffectManager extends LayerManager<Effect> {
    int effectIndex;

    EffectManager() {
        layers = new ArrayList<Effect>(256);
        for (int i = 0; i < 256; i++) {
            layers.add(new Effect());
        }
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        effectIndex = 0;
    }

    void boom(PVector position) {
        Effect current = layers.get(effectIndex);
        current.position = position;
        current.animation.start();
        current.angle = random(0, TWO_PI);
        current.size = random(24, 42);
        effectIndex = (effectIndex + 1) % layers.size();
    }
}

class Effect extends GameObject {
    Animation animation;

    @Override
    protected void reset() {
        super.reset();
        hidden = true;
        if (animation == null) {
            animation = new Animation();
        } else {
            animation.reset();
        }
    }

    @Override
    protected void update() {
        animation.process();
        float progress = animation.getProgress();
        if (progress == 0) {
            hidden = true;
        } else {
            hidden = false;
            scale = progress;
        }
    }
    
    @Override
    protected void draw() {
        imageMode(CENTER);
        image(images.effectExplosion1, 0, 0, size, size);
    }
}