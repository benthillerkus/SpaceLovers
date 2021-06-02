enum PlayerMode {
    Gun("Gun", 0), Shield("Shield", 1), Thruster("Thruster", 2);
    
    final String name;
    final int ordinal;
    static int length = 3;
    
    private PlayerMode(String name, int ordinal) {
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

abstract class Player {
    color playerColor;
    PlayerMode mode = PlayerMode.Thruster;
    abstract PImage getIcon();
    abstract PImage getIcon(PlayerMode mode);
}

class BluePlayer extends Player {
    BluePlayer() {
        this.playerColor = color(165, 150, 255);
    }

    PImage getIcon() {
        return getIcon(mode);
    }

    PImage getIcon(PlayerMode mode) {
        switch(mode) {
            case Gun: return images.iconGunBlue;
            case Thruster: return images.iconControlBlue;
            case Shield: return images.iconShieldBlue;
        }
        return null;
    }
}

class RedPlayer extends Player {
    RedPlayer() {
        this.playerColor = color(255, 125, 125);
    }

    PImage getIcon() {
        return getIcon(mode);
    }

    PImage getIcon(PlayerMode mode) {
        switch(mode) {
            case Gun: return images.iconGunRed;
            case Thruster: return images.iconControlRed;
            case Shield: return images.iconShieldRed;
        }
        return null;
    }
}
