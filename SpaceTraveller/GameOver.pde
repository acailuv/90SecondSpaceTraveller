public class GameOver {

    private final PFont TITLE_FONT = createFont("Consolas Bold", 42);

    private boolean musicPlayed = false;
    private int destinationY = height/2; //Y coordinate where the text will stop moving
    private int currentY = height;
    private Conversation epilogue;
    private boolean convFlag = true;
    private boolean active = false;

    public GameOver() {
        bgmChannel.close();
        minim.stop();
        
        epilogue = new Conversation();
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "", "Your ship crashed and you have been drifting through endless space for more than 4 hours."), normalColor, 1);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "So, this is it, huh?"), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI (Bodysuit)", "WARNING: Remaining oxygen level: 3.75%. Oxygen will be fully depleted in: 3 minutes."), dangerColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "Via, I'm scared."), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI (Bodysuit)", "High stress level detected, would you want me to inject you with a dose of dopamine?"), dangerColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "You", "Actually, give me a dose of that thing that usually makes me sleep easier at night."), normalColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI (Bodysuit)", "Understood. Have a pleasant dream, master."), dangerColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "", "Three minutes later. You have fallen asleep."), normalColor, 1);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI (Bodysuit)", "WARNING: Oxygen level critical."), dangerColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "Via AI (Bodysuit)", "WARNING: Suit battery power critical."), dangerColor);
        epilogue.insertDialogue(new TextWindow(new Window(0, 400), "", "Your bodysuit's battery power has been depleted. The soft light on your helmet flickers for a moment and finally dies. You endlessly drift through space, at least it was a peaceful demise."), normalColor, 1);
    }

    public void drawGameOver() {
        if (!musicPlayed) {
            bgmChannel = minim.loadFile("gameover_bgm.mp3");
            bgmChannel.setGain(-15);
            bgmChannel.play();
            musicPlayed = true;
        }

        textFont(TITLE_FONT);
        textAlign(CENTER, CENTER);
        text("GAME OVER", width/2, currentY);

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
        bgmChannel = minim.loadFile("gameover_bgm.mp3", 2048);
    }
    
    private void destroy() {
        textAlign(LEFT);
        bgmChannel.close();
        minim.stop();
        resetLevel();
        this.active = false;
    }
}
