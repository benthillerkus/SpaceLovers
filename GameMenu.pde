enum GameMenuPage {
    Main,
    Options,
    Credits,
    GameOver;
}

Button backButton = new Button() {
    @Override
    protected void reset() {
        super.reset();
        label = "Back";
        boxHeight = 45;
        boxWidth = 75;
        padding = 20;
        y = 0.9;
    }

    @Override
    protected void onClick() {
        sounds.menuBack.play();
        game.menu.mainmenu();
    }
};

class GameMenu extends LayerManager<Layer> {
    GameMenuPage currentPage;
    MainPage main = new MainPage();
    OptionsPage options = new OptionsPage();
    CreditsPage credits = new CreditsPage();
    GameOverScreen gameOver = new GameOverScreen();

    GameMenu() {
        super();
        layers.add(main);
        layers.add(options);
        layers.add(credits);
        layers.add(gameOver);
        reset();
    }

    @Override
    protected void reset() {
        super.reset();
        mainmenu();
    }

    void mainmenu() {
        currentPage = GameMenuPage.Main;
        hideAll();
        freezeAll();
        main.hidden = false;
        main.frozen = false;
    }

    void options() {
        currentPage = GameMenuPage.Options;
        hideAll();
        freezeAll();
        options.hidden = false;
        options.frozen = false;
    }

    void credits() {
        currentPage = GameMenuPage.Credits;
        hideAll();
        freezeAll();
        credits.hidden = false;
        credits.frozen = false;
    }
}

class MainPage extends LayerManager<Layer> {

    Button optionsButton = new Button() {
        @Override
        protected void reset() {
            super.reset();
            label = "Options";
            x = 0.25;
            y = 0.8;
        }

        @Override
        protected void onClick() {
            sounds.menuForward.play();
            game.menu.options();
        }
    };

    Button creditsButton = new Button() {
        @Override
        protected void reset() {
            super.reset();
            label = "Credits";
            x = 0.75;
            y = 0.8;
        }

        @Override
        protected void onClick() {
            sounds.menuForward.play();
            game.menu.credits();
        }
    };

    Button playButton = new Button() {
        @Override
        protected void reset() {
            super.reset();
            label = "";
            boxHeight = 200;
            boxWidth = 200;
            roundCorners = 9999;
            textOnly = false;
            padding = 0;
            buttonColor = color(246, 136, 240);
        }

        @Override
        protected void onClick() {
            sounds.menuForward.play();
            game.start();
        }
    };

    MainPage() {
        super();
        layers.add(optionsButton);
        layers.add(creditsButton);
        layers.add(playButton);
        reset();
    }

    @Override
    protected void draw() {
        super.draw();

        fill(255);
        //Asteroids
        textAlign(CENTER, TOP);
        textSize(80*pixelFactor);
        text("ASTEROIDS", width/2, height*0.1);
    }
}

class OptionsPage extends LayerManager<Layer> {

    OptionsPage() {
        super();
        layers.add(backButton);
        reset();
    }

    @Override
    protected void draw() {
        super.draw();
        stroke(255);
        fill(255);

        //Here be Dragons
        textAlign(CENTER);
        textSize(50*pixelFactor);
        text("Here be Dragons", width/2, height/2);
    }
}

class CreditsPage extends LayerManager<Layer> {

    CreditsPage() {
        super();
        layers.add(backButton);
        reset();
    }

    @Override
    protected void draw() {
        super.draw();
        stroke(255);
        fill(255);

        textSize(35 * pixelFactor);
        textAlign(CENTER);
        //Bent Hillerkus
        text("Bent Hillerkus", width / 2, height * 0.5);
        
        //Joshua Lasse Einhoff
        text("Joshua Lasse Einhoff", width / 2, height * 0.55);
        
        //Kevin Kader
        text("Kevin Kader", width / 2, height * 0.45);
        
        //Natalie Ruth Turek
        text("Natalie Ruth Turek", width / 2, height * 0.4);
    }
}
