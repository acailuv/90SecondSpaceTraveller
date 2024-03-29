import ddf.minim.*;

public class Cockpit {
    protected int startX;
    protected int startY;
    protected Color theme[];
    protected boolean active = false;
    protected int lostZone = 1000;
    protected int speedWarning = 40;

    private final PFont MAIN_FONT = createFont("Consolas", 16);
    private final PFont NAME_FONT = createFont("Consolas Bold", 20);

    private boolean musicPlayed = false;
    private boolean sePlayed = false;
    private Conversation weHaveArrived;
    private boolean convInProgress = false;

    private String goUp, goDown, lostSectorUp, lostSectorDown;
    private TextWindow warningWindow;

    public final Color GREEN_THEME[] = {
        new Color(0, 200, 0, 50), //back panel
        new Color(0, 200, 0, 100), //window
        new Color(0, 200, 0, 255), //"background"
        new Color(0, 255, 0, 255) //"foreground"
    };

    public final Color BLUE_THEME[] = {
        new Color(0, 0, 200, 50), //back panel
        new Color(0, 0, 200, 100), //window
        new Color(0, 0, 200, 255), //"background"
        new Color(0, 0, 255, 255) //"foreground"
    };

    public final Color RED_THEME[] = {
        new Color(200, 0, 0, 50), //back panel
        new Color(200, 0, 0, 100), //window
        new Color(200, 0, 0, 255), //"background"
        new Color(255, 0, 0, 255) //"foreground"
    };

    protected Color c;

    public Cockpit(int startX, int startY) {
        this.startX = startX;
        this.startY = startY;
        weHaveArrived = new Conversation();
        weHaveArrived.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "We have arrived at an Interplanetary Station. I would kindly suggest you to resupply and buy some cargo as a source of income at out next destination."), aiColor);
        weHaveArrived.insertDialogue(new TextWindow(new Window(0, 400), "You", "Alright, see you soon, Via."), normalColor);
        weHaveArrived.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "I shall wait for you here."), aiColor);
        bgmChannel = minim.loadFile("journey_bgm.mp3", 2048);

        goUp = "Gravitational Force Detected! Suggestion: [Pull up]!";
        goDown = "It seems that an obstacle is nearby! [Go Down]!";
        lostSectorUp = "[Lost Sector] imminent! [Pull up]!";
        lostSectorDown = "Master, it seems that we are approaching [Lost Sector]. [Go Down]!";
        warningWindow = new TextWindow(new Window(0, 400), "Via AI", "", dangerColor);
    }

    public void drawCockpit(Ship s) {
        textFont(MAIN_FONT);
        String verdict = game.universalGravity(s);
        if (verdict == "Collision" || (millis()-s.startTime)/1000 > 90 || s.positionY > lostZone || s.positionY < -lostZone) {
            s.fuel = s.fuelCapacity;
            this.destroy();
            if (verdict == "Collision")
                gameOver.create("Collided with a planet.");
            else if ((millis()-s.startTime)/1000 > 90)
                gameOver.create("Time's up!");
            else if (s.positionY > lostZone || s.positionY < -lostZone)
                gameOver.create("Swallowed by [Lost Sector].");
            return;
        }

        if (!musicPlayed) {
            bgmChannel.setGain(-15);
            bgmChannel.loop();
            musicPlayed = true;
        }

        int padding = 15;
        //text("FPS: " + frameRate, 5, 15);
        //back panel
        Window backPanel = new Window(startX, startY, theme[0]);
        backPanel.drawWindow(width, 400, false);

        //ship panel
        int sp_StartX = startX+25, sp_StartY = startY+25;
        int sp_EndX = sp_StartX+125, sp_EndY = sp_StartY+125;
        Window shipPanel = new Window(sp_StartX, sp_StartY, theme[1]);
        shipPanel.drawWindow(sp_EndX, sp_EndY, false);
        PImage shipSprite = loadImage("ship.png");
        fill(0, 255, 0);
        textFont(NAME_FONT);
        text("[GYROSCOPE]", sp_StartX + 5, sp_StartY - 6);
        textFont(MAIN_FONT);
        fill(255);
        text("Ship Angle: " + String.format("%.1f", degrees(s.getAngle())), sp_StartX + 5, sp_StartY + padding);
        text("Current X: " + (int)s.positionX, sp_StartX + 5, sp_StartY + sp_EndY - 5 - padding);
        text("Current Y: " + (int)s.positionY, sp_StartX + 5, sp_StartY + sp_EndY - 5);
        imageMode(CENTER);
        translate(sp_StartX + sp_EndX/2, sp_StartY + sp_EndY/2);
        rotate(-s.getAngle());
        image(shipSprite, 0, 0);
        rotate(s.getAngle());
        translate(-sp_StartX - sp_EndX/2, -sp_StartY - sp_EndY/2);

        //nearby planet panel
        int npp_StartX = sp_StartX, npp_StartY = sp_EndY+75;
        int npp_EndX = sp_EndX, npp_EndY = npp_StartX+125;
        Window nearbyPlanetPanel = new Window(npp_StartX, npp_StartY, theme[1]);
        nearbyPlanetPanel.drawWindow(npp_EndX, npp_EndY, false);
        fill(255);
        if (verdict == "Go up" || verdict == "Go down") {
            if (!sePlayed) seChannel = minim.loadFile("alert.mp3", 512); 
            sePlayed = true; 
            seChannel.play();
            if (verdict == "Go up") {
                drawWarningWindow(goUp);
            } else if (verdict == "Go down") {
                drawWarningWindow(goDown);
            } else if (s.positionY < -lostZone+200) {
                drawWarningWindow(lostSectorUp);
            } else if (s.positionY > lostZone-200) {
                drawWarningWindow(lostSectorDown);
            } else {
                sePlayed = false;
            }
            Planet near = game.getNearestPlanet(s);
            //float force = s.mass * near.mass / s.distanceFromPlanet(near);
            fill(255, 0, 0);
            textFont(NAME_FONT);
            text("[DANGER!]", npp_StartX, npp_StartY-8);
            textFont(MAIN_FONT);
            fill(255);
            text("Nearby: " + near.planetName, npp_StartX, npp_StartY + padding);
            text("Impact: " + (int)(sqrt(s.distanceFromPlanet(near)) - near.radius), npp_StartX, npp_StartY + padding*2);
            text("Planet Size: " + (int)near.radius, npp_StartX, npp_StartY + padding*4);
            text("Planet Location:", npp_StartX, npp_StartY + padding*5);
            text(" X(" + (int)near.positionX + ") Y(" + (int)near.positionY + ")", npp_StartX, npp_StartY + padding*6);
            text("Safe height:", npp_StartX, npp_StartY + padding*7);
            text(" " + (int)max((near.positionY - near.radius), (near.positionY + near.radius)) + " or " + (int)min((near.positionY - near.radius), (near.positionY + near.radius)), npp_StartX, npp_StartY + padding*8);
            text("[" + verdict + "]", npp_StartX, npp_StartY + padding*9 + 7);
        } else {
            if (s.positionY < -lostZone+200) {
                if (!sePlayed) seChannel = minim.loadFile("alert.mp3", 512); 
                sePlayed = true; 
                seChannel.play();
                drawWarningWindow(lostSectorUp);
            } else if (s.positionY > lostZone-200) {
                if (!sePlayed) seChannel = minim.loadFile("alert.mp3", 512); 
                sePlayed = true; 
                seChannel.play();
                drawWarningWindow(lostSectorDown);
            } else {
                sePlayed = false;
            }
        }
        warningWindow.create();
        //console panel
        int cp_StartX = sp_EndX+50, cp_StartY = sp_StartY;
        int cp_EndX = cp_StartX+200, cp_EndY = sp_EndY;
        Window consolePanel = new Window(cp_StartX, cp_StartY, theme[1]);
        consolePanel.drawWindow(cp_EndX, cp_EndY, false);
        fill(0, 255, 0);
        textFont(NAME_FONT);
        text("[INDICATORS]", cp_StartX, cp_StartY - 6);
        textFont(MAIN_FONT);
        fill(255, 0, 0);
        if (s.velocityX > speedWarning) {
            text("  > TOO FAST!", cp_StartX, cp_StartY + padding);
        }
        if (s.velocityY > speedWarning) {
            text("  > TOO FAST UPWARDS!", cp_StartX, cp_StartY + padding*2);
        } else if (s.velocityY < -speedWarning) {
            text("  > TOO FAST DOWNWARDS!", cp_StartX, cp_StartY + padding*2);
        }
        if (verdict == "Go up" || verdict == "Go down") text("  > [ROGUE PLANET] NEARBY!", cp_StartX, cp_StartY + padding*3);
        if (s.positionY < -lostZone+200 || s.positionY > lostZone-200) text("  > [LOST SECTOR] NEARBY!", cp_StartX, cp_StartY + padding*4);
        fill(255, 175, 0);
        if (key == 'w' && keyPressed) text("  > BOTTOM THRUSTER ACTIVE. Going UP...", cp_StartX, cp_StartY + padding*5);
        if (key == 's' && keyPressed) text("  > TOP THRUSTER ACTIVE. Going DOWN...", cp_StartX, cp_StartY + padding*6);
        if (key == 'a' && keyPressed) text("  > BRAKE PULSE ACTIVE. Slowing down...", cp_StartX, cp_StartY + padding*7);
        if (key == 'd' && keyPressed) text("  > MAIN THRUSTER ACTIVE. Going FORWARD...", cp_StartX, cp_StartY + padding*8);

        //progress panel
        int pp_StartX = cp_StartX, pp_StartY = npp_StartY;
        int pp_EndX = cp_EndX, pp_EndY = npp_EndY;
        Window progressPanel = new Window(pp_StartX, pp_StartY, theme[1]);
        progressPanel.drawWindow(pp_EndX, pp_EndY, false);
        float progress = s.positionX/s.finishLine;
        float shipHeight = s.positionY/lostZone;
        if (progress > 1) progress = 1;
        int imageSize = 50;
        fill(0, 255, 0);
        textFont(NAME_FONT);
        text("[NAVIGATION]", pp_StartX, pp_StartY-8);
        textFont(MAIN_FONT);
        fill(255);
        text("Time Left: " + (90-(millis()-s.startTime)/1000), pp_StartX, pp_StartY + padding);
        image(shipSprite, pp_StartX + imageSize/2 + (pp_EndX - imageSize)*progress, pp_StartY + (pp_EndY/2) - (pp_EndY/2 - imageSize/2)*shipHeight);

        //fuel panel
        int fp_StartX = cp_EndX+225, fp_StartY = sp_StartY;
        int fp_EndX = fp_StartX-225-245, fp_EndY = sp_EndY;
        Window fuelPanel = new Window(fp_StartX, fp_StartY, theme[1]);
        fuelPanel.drawWindow(fp_EndX, fp_EndY, false);
        fill(0, 255, 0, 200); // fuel bar color
        if (s.fuel <= 0.2*s.fuelCapacity) fill(255, 0, 0, 200);
        rect(fp_StartX, fp_StartY + fp_EndY, fp_EndX, -(fp_EndY)*(s.fuel/s.fuelCapacity));
        textAlign(CENTER, CENTER);
        textFont(NAME_FONT);
        fill(255);
        text("[FUEL]", fp_StartX+fp_EndX/2, fp_StartY+fp_EndY/2);
        textFont(MAIN_FONT);
        if (s.fuel <= 0.2*s.fuelCapacity) {
            fill(255, 0, 0);
            text("CRITICAL!", fp_StartX+fp_EndX/2, fp_StartY+fp_EndY/2+24);
        }
        textAlign(LEFT);

        //engine panel
        int ep_StartX = fp_StartX, ep_StartY = npp_StartY;
        int ep_EndX = ep_StartX-225-245, ep_EndY = npp_EndY;
        Window enginePanel = new Window(ep_StartX, ep_StartY, theme[1]);
        enginePanel.drawWindow(ep_EndX, ep_EndY, false);

        fill(0, 255, 0);
        textFont(NAME_FONT);
        text("[ENGINE]", ep_StartX + 5, ep_StartY-8);
        textFont(MAIN_FONT);
        fill(255);
        text("X Velocity: " + String.format("%.1f", s.velocityX), ep_StartX + 5, ep_StartY + padding*1); // uses the same padding as the one in start nearby planet panel
        text("Y Velocity: " + String.format("%.1f", s.velocityY), ep_StartX + 5, ep_StartY + padding*2);
        text("Eff: " + Float.toString((float)Math.floor(s.efficiency*100)) + "%", ep_StartX + 5, ep_StartY + padding*4);
        text("Fuel: " + Integer.toString((int)s.fuel) + " L", ep_StartX + 5, ep_StartY + padding*5);

        if (s.positionX >= s.finishLine) {
            convInProgress = true;
            s.positionX = s.finishLine;
        }

        if (convInProgress) {
            convInProgress = weHaveArrived.executeReturn();
            if (!convInProgress) {
                transferToShop();
            }
            s.positionX = s.finishLine;
            s.positionY = 0;
        }
    }

    public void destroy() {
        bgmChannel.close();
        minim.stop();
        this.musicPlayed = false;
        this.convInProgress = false;
        this.active = false;
    }

    public void create() {
        this.active = true;
        this.musicPlayed = false;
        bgmChannel = minim.loadFile("journey_bgm.mp3", 2048);
    }

    public void changeTheme(Color newTheme[]) {
        this.theme = newTheme;
    }

    private void transferToShop() {
        weHaveArrived.execute();
        int[] aa = {
            100, 1000
        };
        Cargo[] testCargo = {
            new Cargo("Sugar", "Commodity of the commons.", aa), 
            new Cargo("Fusion Cell", "Standard Interplanetary AA Battery.", aa), 
            new Cargo("Space Cat", "\"Shhh, let's keep this between us.\"", aa), 
            new Cargo("Mystery Goo", "It's White. And sticky too. Hmm..", aa)
        };
        shop = new Shop(testCargo);
        this.destroy();
        shop.create();
    }

    private void drawWarningWindow(String msg) {
        if (s.positionX < s.finishLine) {
            warningWindow.text = msg;
            warningWindow.drawWindow(0);
        }
    }
}
