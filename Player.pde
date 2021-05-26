enum PlayerMode {
    Gun("Gun", 0), Shield("Shield", 1), Thruster("Thruster", 2);
    
    final String name;
    final int ordinal;
    static int length = 3;
    
    PlayerMode(String name, int ordinal) {
        this.name = name;
        this.ordinal = ordinal;
    }

    static PlayerMode fromOrdinal(int ordinal) {
        switch(ordinal) {
            case 0: return PlayerMode.Gun;
            case 1: return PlayerMode.Shield;
            case 2: return PlayerMode.Thruster;
            default: return PlayerMode.Shield;
        }
    }

    PlayerMode previous() {
        return fromOrdinal((length + this.ordinal - 1) % length);
    }

    PlayerMode next() {
        return fromOrdinal((length + this.ordinal + 1) % length);
    }
}

class Player {
    final color playerColor;

    Player(color playerColor) {
        this.playerColor = playerColor;
    }

    PlayerMode mode = PlayerMode.Thruster;

    String current(){
        return mode.name();
    }
}
