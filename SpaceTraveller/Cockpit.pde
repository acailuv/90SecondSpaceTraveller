import ddf.minim.*;

public class Cockpit {
    protected int startX;
    protected int startY;
    protected Color theme[];
    private boolean musicPlayed = false;
    
    //sound
    public AudioPlayer player;
    public Minim minim;

    public final Color GREEN_THEME[] = {
        new Color(0, 200, 0, 50), //back panel
        new Color(0, 200, 0, 100), //window
        new Color(0, 200, 0, 255), //"background"
        new Color(0, 255, 0, 255) //"foreground"
    };
    
    private final Color BLUE_THEME[] = {
        new Color(0, 0, 200, 50), //back panel
        new Color(0, 0, 200, 100), //window
        new Color(0, 0, 200, 255), //"background"
        new Color(0, 0, 255, 255) //"foreground"
    };

    protected Color c;

    public Cockpit(int startX, int startY) {
        this.startX = startX;
        this.startY = startY;
    }
    
    public Cockpit(int startX, int startY, AudioPlayer player, Minim minim) {
        this.startX = startX;
        this.startY = startY;
        this.player = player;
        this.minim = minim;
        this.player = minim.loadFile("journey_bgm.mp3", 2048);
    }

    public void drawCockpit(Ship s) {
        if (!musicPlayed) {
            player.loop();
            musicPlayed = true;
        }
        
        //back panel
        Window backPanel = new Window(startX, startY, theme[0]);
        backPanel.drawWindow(width, 400, false);

        //ship panel
        int sp_StartX = startX+25, sp_StartY = startY+25;
        int sp_EndX = sp_StartX+125, sp_EndY = sp_StartY+125;
        Window shipPanel = new Window(sp_StartX, sp_StartY, theme[1]);
        shipPanel.drawWindow(sp_EndX, sp_EndY, false);
        PImage shipSprite = loadImage("ship.png");
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
        int padding = 15;
        fill(255);
        text("Current X: " + (int)s.positionX, npp_StartX + 5, npp_StartY + padding);
        text("Current Y: " + (int)s.positionY, npp_StartX + 5, npp_StartY + padding*2);

        //console panel
        int cp_StartX = sp_EndX+50, cp_StartY = sp_StartY;
        int cp_EndX = cp_StartX+200, cp_EndY = sp_EndY;
        Window consolePanel = new Window(cp_StartX, cp_StartY, theme[1]);
        consolePanel.drawWindow(cp_EndX, cp_EndY, false);

        //progress panel
        int pp_StartX = cp_StartX, pp_StartY = npp_StartY;
        int pp_EndX = cp_EndX, pp_EndY = npp_EndY;
        Window progressPanel = new Window(pp_StartX, pp_StartY, theme[1]);
        progressPanel.drawWindow(pp_EndX, pp_EndY, false);
        float progress = s.positionX/s.finishLine;
        if(progress > 1) progress = 1;
        int imageSize = 50;
        image(shipSprite, pp_StartX + imageSize/2 + (pp_EndX - imageSize)*progress, pp_StartY + pp_EndY/2);
        fill(255);
        text("0", pp_StartX, pp_StartY + pp_EndY/2 + imageSize);
        textAlign(RIGHT);
        text((int)s.finishLine, pp_StartX + pp_EndX, pp_StartY + pp_EndY/2 + imageSize);
        textAlign(LEFT);
        
        //fuel panel
        int fp_StartX = cp_EndX+225, fp_StartY = sp_StartY;
        int fp_EndX = fp_StartX-225-245, fp_EndY = sp_EndY;
        Window fuelPanel = new Window(fp_StartX, fp_StartY, theme[1]);
        fuelPanel.drawWindow(fp_EndX, fp_EndY, false);
        fill(120); // fuel bar color
        rect(fp_StartX, fp_StartY + fp_EndY, fp_EndX, -(fp_EndY)*(s.fuel/s.fuelCapacity));

        //engine panel
        int ep_StartX = fp_StartX, ep_StartY = npp_StartY;
        int ep_EndX = ep_StartX-225-245, ep_EndY = npp_EndY;
        Window enginePanel = new Window(ep_StartX, ep_StartY, theme[1]);
        enginePanel.drawWindow(ep_EndX, ep_EndY, false);
        
        fill(255); /// text color
        text("X Velocity: " + String.format("%.1f", s.velocityX), ep_StartX + 5, ep_StartY + padding); // uses the same padding as the one in start nearby planet panel
        text("Y Velocity: " + String.format("%.1f", s.velocityY), ep_StartX + 5, ep_StartY + padding*2);
        text("Ship Angle: " + String.format("%.1f", degrees(s.getAngle())), ep_StartX + 5, ep_StartY + padding*3);
        
    }

    public void changeTheme(Color newTheme[]) {
        this.theme = newTheme;
    }
}
