import ddf.minim.*;

public class MainMenu {
    private final PFont TITLE_FONT = createFont("Consolas Bold", 42);
    
    private boolean musicPlayed = false;
    private boolean active = true;

    public MainMenu() {
        player.close();
        minim.stop();
    }

    public void drawMainMenu() {
        if (active) {
            if (!musicPlayed) {
                player = minim.loadFile("mainmenu_bgm.mp3", 2048);
                player.loop();
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
        backPanel.drawWindow(300, 150, true);

        //play button
        Button playButton = new Button(width/2-125, 2*height/3+25, 250, 45, new Color(0, 255, 0, 255));
        playButton.font = createFont("Consolas Bold", 24);
        playButton.drawButton("Play", width/2, 2*height/3+25+23);
        if (playButton.isClicked()) {
            this.destroy();
            cockpit.create();
            delay(100);
        }


        //exit button
        Button exitButton = new Button(width/2-125, 2*height/3+25+45+10, 250, 45, new Color(175, 0, 0, 255));
        exitButton.font = createFont("Consolas Bold", 24);
        exitButton.drawButton("Exit", width/2, 2*height/3+25+45+23+10);
        if (exitButton.isClicked()) {
            exit();
            delay(100);
        }
    }

    private void destroy() {
        textAlign(LEFT);
        player.close();
        minim.stop();
        this.active = false;
    }
}
