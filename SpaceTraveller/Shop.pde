public class Shop {
    private final PFont MAIN_FONT = createFont("Consolas", 16);
    private final PFont NAME_FONT = createFont("Consolas Bold", 24);
    private final int NAME_FONT_PADDING = 24;
    private final int MAIN_FONT_PADDING = 16;
    
    private final Color shopTheme[] = {
        new Color(0, 0, 200, 50), //back panel
        new Color(0, 0, 200, 100), //window
        new Color(0, 0, 200, 255), //"background"
        new Color(0, 0, 255, 255) //"foreground"
    };
    
    Cargo[] cargo;
    
    public Shop(Cargo[] cargo) {
        this.cargo = cargo;
        for(Cargo c: cargo) {
            c.finalPrice = (int)random(c.price[0], c.price[1]);
        }
    }
    
    public void drawShop() {
        //back panel
        Window backPanel = new Window(0, 0, shopTheme[0]);
        backPanel.drawWindow(width, height, false);
        
        //cargo panel
        int cp_StartX = 25, cp_StartY = 25;
        int cp_EndX = width/2-25, cp_EndY = height-50;
        Window cargoPanel = new Window(cp_StartX, cp_StartY, shopTheme[1]);
        cargoPanel.drawWindow(cp_EndX, cp_EndY, true);
        for(Cargo c: cargo) {
            drawCargoPanel(c, cp_StartX+25, cp_StartY+25);
        }
        
        //workshop panel
        int wp_StartX = cp_EndX+50, wp_StartY = cp_StartY;
        int wp_EndX = width-(width/2-25)-75, wp_EndY = 2*height/3-50;
        Window workshopPanel = new Window(wp_StartX, wp_StartY, shopTheme[1]);
        workshopPanel.drawWindow(wp_EndX, wp_EndY, true);
        
        //info panel
        int ip_StartX = wp_StartX, ip_StartY = wp_EndY+50;
        int ip_EndX = width-(width/2-25)-75, ip_EndY = width/3-90;
        Window infoPanel = new Window(ip_StartX, ip_StartY, shopTheme[1]);
        infoPanel.drawWindow(ip_EndX, ip_EndY, true);
    }
    
    public void drawCargoPanel(Cargo cargo, int startX, int startY) {
        Window cargoPanel = new Window(startX, startY, shopTheme[2]);
        cargoPanel.drawWindow(325, 100, false);
        
        fill(255);
        textFont(NAME_FONT);
        text(cargo.name, startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING);
        
        textFont(MAIN_FONT);
        text(cargo.desc, startX+NAME_FONT_PADDING/3, startY+2*NAME_FONT_PADDING);
        
        fill(0, 255, 0);
        text("Cr. " + cargo.finalPrice, startX+NAME_FONT_PADDING/3, startY+2*NAME_FONT_PADDING+MAIN_FONT_PADDING);
    }
    
}
