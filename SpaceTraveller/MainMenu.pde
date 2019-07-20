import ddf.minim.*;

public class MainMenu {
    private final PFont TITLE_FONT = createFont("Consolas Bold", 42);

    private boolean musicPlayed = false;
    private boolean active = true;
    private boolean tutorial = false;

    public MainMenu() {
        bgmChannel.close();
        minim.stop();
    }

    public void drawMainMenu() {
        if (this.tutorial) {
            textAlign(LEFT);
            this.tutorial = readyToAdventure.executeReturn();
            if (!this.tutorial) readyToAdventure.resetConversation(); textAlign(CENTER, CENTER);
        } else if (active) {
            if (!musicPlayed) {
                bgmChannel = minim.loadFile("mainmenu_bgm.mp3", 2048);
                bgmChannel.setGain(-15);
                bgmChannel.loop();
                musicPlayed = true;
            }

            textFont(TITLE_FONT);
            textAlign(CENTER, CENTER);
            text("<90 Second Space Traveller>", width/2, height/4);
            generateMenuButtons();
        }
    }

    private void generateMenuButtons() {
        //back panel
        Window backPanel = new Window(width/2-150, 2*height/3);
        backPanel.drawWindow(300, 195, true);

        //play button
        Button playButton = new Button(width/2-125, 2*height/3+25, 250, 45, new Color(0, 255, 0, 255));
        playButton.font = createFont("Consolas Bold", 24);
        playButton.drawButton("Play", width/2, 2*height/3+25+23);
        if (playButton.isClicked()) {
            s = new Ship(100);
            s.finishLine = game.finishLine;
            resetLevel();
            this.destroy();
            cockpit.create();
            delay(100);
        }

        //load button
        Button tutorialButton = new Button(width/2-125, 2*height/3+25+45+5, 250, 45, new Color(0, 0, 255, 255));
        tutorialButton.font = createFont("Consolas Bold", 24);
        tutorialButton.drawButton("Tutorial", width/2, 2*height/3+25+23+45+5);
        if (tutorialButton.isClicked()) {
            this.tutorial = true;
            delay(100);
        }

        //exit button
        Button exitButton = new Button(width/2-125, 2*height/3+25+90+10, 250, 45, new Color(175, 0, 0, 255));
        exitButton.font = createFont("Consolas Bold", 24);
        exitButton.drawButton("Exit", width/2, 2*height/3+25+90+23+5);
        if (exitButton.isClicked()) {
            exit();
            delay(100);
        }
    }

    private void destroy() {
        textAlign(LEFT);
        bgmChannel.close();
        minim.stop();
        this.musicPlayed = false;
        this.active = false;
    }

    public void create() {
        this.active = true;
        bgmChannel = minim.loadFile("mainmenu_bgm.mp3", 2048);
    }
}
