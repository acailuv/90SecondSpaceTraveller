public class WinScreen {

    private final PFont TITLE_FONT = createFont("Consolas Bold", 42);

    private boolean musicPlayed = false;
    private int destinationY = height/2; //Y coordinate where the text will stop moving
    private int currentY = height;
    private Conversation epilogue;
    private boolean convFlag = true;
    private boolean active = false;

    public WinScreen() {
        bgmChannel.close();
        minim.stop();

        epilogue = new Conversation();
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "", "You have successfully gathered 100,000 Space Credits. Congratulations."), normalColor, 1);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "Hahahaha, it feels amazing to be the richest person in the gala-"), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "", "Your spaceship is bumped by another enormous spacecraft."), dangerColor, 1);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Master, I sense the prensence of Million Maximillion, the richest person in the universe."), aiColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "Is he the one that bumped my spacecraft?"), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Yes, it seems so."), aiColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "Darn rich people, thinking they could do whatever they want."), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "So, what do you want to do next?"), aiColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "I feel the urge to be the richest person in the whole universe after what just happened!"), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Oh, dear. Here we go again."), aiColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "", "You babble for hours on end talking about how you could be the next richest person in the whole universe. Fueled by dedication, you seek your next adventure. The End."), normalColor, 1);
    }

    public void drawWinScreen() {
        if (cockpit.active)
            cockpit.destroy();
        if (shop.active)
            shop.destroy();

        if (!musicPlayed) {
            bgmChannel = minim.loadFile("win_bgm.mp3");
            bgmChannel.setGain(-10);
            bgmChannel.play();
            musicPlayed = true;
        }

        textFont(TITLE_FONT);
        textAlign(CENTER, CENTER);
        text("YOU WIN!", width/2, currentY);

        if (currentY >= destinationY) {   
            currentY--;
        } else {
            if (convFlag) {
                convFlag = epilogue.executeReturn();
            } else {
                generateMenuButtons();
            }
        }
    }

    private void generateMenuButtons() {
        //back panel
        Window backPanel = new Window(width/2-150, 2*height/3);
        backPanel.drawWindow(300, 150, true);

        //play button
        Button playButton = new Button(width/2-125, 2*height/3+25, 250, 45, new Color(0, 255, 0, 255));
        playButton.font = createFont("Consolas Bold", 24);
        playButton.drawButton("Main Menu", width/2, 2*height/3+25+23);
        if (playButton.isClicked()) {
            this.destroy();
            main.create();
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

    public void create() {
        this.active = true;
        bgmChannel = minim.loadFile("win_bgm.mp3", 2048);
    }

    private void destroy() {
        textAlign(LEFT);
        bgmChannel.close();
        minim.stop();
        resetLevel();
        s.credits = 0;
        this.convFlag = false;
        this.active = false;
    }
}
