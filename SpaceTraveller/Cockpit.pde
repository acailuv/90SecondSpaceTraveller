public class Cockpit {
    protected int startX;
    protected int startY;
    protected Color theme[];

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

    public void drawCockpit() {
        //back panel
        Window backPanel = new Window(startX, startY, theme[0]);
        backPanel.drawWindow(width, 400, false);

        //ship panel
        int sp_StartX = startX+25, sp_StartY = startY+25;
        int sp_EndX = sp_StartX+125, sp_EndY = sp_StartY+125;
        Window shipPanel = new Window(sp_StartX, sp_StartY, theme[1]);
        shipPanel.drawWindow(sp_EndX, sp_EndY, false);

        //nearby planet panel
        int npp_StartX = sp_StartX, npp_StartY = sp_EndY+75;
        int npp_EndX = sp_EndX, npp_EndY = npp_StartX+125;
        Window nearbyPlanetPanel = new Window(npp_StartX, npp_StartY, theme[1]);
        nearbyPlanetPanel.drawWindow(npp_EndX, npp_EndY, false);

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

        //fuel panel
        int fp_StartX = cp_EndX+225, fp_StartY = sp_StartY;
        int fp_EndX = fp_StartX-225-245, fp_EndY = sp_EndY;
        Window fuelPanel = new Window(fp_StartX, fp_StartY, theme[1]);
        fuelPanel.drawWindow(fp_EndX, fp_EndY, false);

        //engine panel
        int ep_StartX = fp_StartX, ep_StartY = npp_StartY;
        int ep_EndX = ep_StartX-225-245, ep_EndY = npp_EndY;
        Window enginePanel = new Window(ep_StartX, ep_StartY, theme[1]);
        enginePanel.drawWindow(ep_EndX, ep_EndY, false);
    }

    public void changeTheme(Color newTheme[]) {
        this.theme = newTheme;
    }
}
