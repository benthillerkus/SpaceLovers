class Stats {
    int catchedDebris;
    int firedBullets;
    int renderedFrames;

    Stats() {
        reset();
    }

    void reset() {
        catchedDebris = 0;
        firedBullets = 0;
        renderedFrames = 0;
    }
}