class Stats {
    int caughtDebris;
    int firedBullets;
    // For calculating mission length (minutes)
    // Currently being incremented in ship
    int renderedFrames;
    int completedMissions;
    int tankedDamage;

    Stats() {
        reset();
    }

    void reset() {
        caughtDebris = 0;
        firedBullets = 0;
        renderedFrames = 0;
        completedMissions = 0;
        tankedDamage = 0;
    }
}