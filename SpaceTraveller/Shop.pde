public class Shop {
    private final PFont MAIN_FONT = createFont("Consolas", 16);
    private final PFont NAME_FONT = createFont("Consolas Bold", 24);
    private final int NAME_FONT_PADDING = 24;
    private final int MAIN_FONT_PADDING = 16;
    private final int[] SHOP_NAME_LENGTH_RANGE = {4, 8};

    protected String shopName;
    protected int credits;
    protected float currentEfficiency, currentFuelTank, currentMaxPower, currentFuel;

    private final Color shopTheme[] = {
        new Color(0, 0, 200, 50), //back panel
        new Color(0, 0, 200, 100), //window
        new Color(0, 0, 200, 255), //"background"
        new Color(0, 0, 255, 255) //"foreground"
    };

    Cargo[] cargo;

    public Shop(Cargo[] cargo) {
        StringRandomizer rnd = new StringRandomizer();
        this.cargo = cargo;
        for (Cargo c : cargo) {
            c.finalPrice = (int)random(c.price[0], c.price[1]);
        }
        this.shopName = rnd.generatePlanetName((int)random(SHOP_NAME_LENGTH_RANGE[0], SHOP_NAME_LENGTH_RANGE[1])) + " Planetary Station";
    }

    public Shop(Cargo[] cargo, float currentEfficiency, float currentFuelTank, float currentMaxPower, float currentFuel) {
        this(cargo);
        this.currentEfficiency = currentEfficiency;
        this.currentFuelTank = currentFuelTank;
        this.currentMaxPower = currentMaxPower;
        this.currentFuel = currentFuel;
    }

    public void drawShop() {
        //back panel and shop name
        Window backPanel = new Window(0, 0, shopTheme[0]);
        backPanel.drawWindow(width, height, false);
        fill(255);
        textFont(NAME_FONT);
        text("<" + this.shopName + ">", 25, 25); 

        //cargo panel
        int cp_StartX = 25, cp_StartY = 35;
        int cp_EndX = width/2-25, cp_EndY = height-50;
        Window cargoPanel = new Window(cp_StartX, cp_StartY, shopTheme[1]);
        cargoPanel.drawWindow(cp_EndX, cp_EndY, true);
        fill(255);
        textFont(MAIN_FONT);
        text("<Marketplace>", cp_StartX+25, cp_StartY+25);
        for (int i=0; i<cargo.length; i++) {
            Cargo c = cargo[i];
            drawCargoPanel(c, cp_StartX+25, cp_StartY+(i*120)+40);
        }

        //workshop panel
        int wp_StartX = cp_EndX+50, wp_StartY = cp_StartY;
        int wp_EndX = width-(width/2-25)-75, wp_EndY = 2*height/3-30;
        Window workshopPanel = new Window(wp_StartX, wp_StartY, shopTheme[1]);
        workshopPanel.drawWindow(wp_EndX, wp_EndY, true);
        fill(255);
        textFont(MAIN_FONT);
        text("<Workshop: Upgrades & Fuel>", wp_StartX+25, wp_StartY+25);
        //text("[+] Engine Efficiency", wp_StartX+25, wp_StartY+50);
        int offset = 80;
        drawUpgradePanel("Engine Efficiency", 100, wp_StartX+25, wp_StartY+40);
        drawUpgradePanel("Fuel Tank Capacity", 100, wp_StartX+25, wp_StartY+offset+40);
        offset += 80;
        drawUpgradePanel("Engine Max Power", 100, wp_StartX+25, wp_StartY+offset+40);
        offset += 80;
        drawUpgradePanel("Refuel", 100, wp_StartX+25, wp_StartY+offset+40);


        //info panel
        int ip_StartX = wp_StartX, ip_StartY = wp_EndY+58;
        int ip_EndX = width-(width/2-25)-75, ip_EndY = width/3-110;
        Window infoPanel = new Window(ip_StartX, ip_StartY, shopTheme[1]);
        infoPanel.drawWindow(ip_EndX, ip_EndY, true);
        fill(0, 255, 0);
        textFont(NAME_FONT);
        text("[Funds]", ip_StartX+15, ip_StartY+25);
        textFont(MAIN_FONT);
        text("Cr. " + Integer.toString(credits), ip_StartX+15, ip_StartY+25+NAME_FONT_PADDING);
        fill(255);
        textFont(NAME_FONT);
        text("[Your Ship]", ip_StartX+ip_EndX/2-35, ip_StartY+25);
        textFont(MAIN_FONT);
        text("Efficiency: " + Float.toString(currentEfficiency*100) + "%", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING);
        text("Fuel Capacity: " + Float.toString(currentFuelTank) + " L", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING+MAIN_FONT_PADDING);
        text("Max Power: " + Float.toString(currentMaxPower) + " F", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING+2*MAIN_FONT_PADDING);
        text("Current Fuel: " + Float.toString(currentFuel) + " L", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING+3*MAIN_FONT_PADDING);
    }

    private void drawCargoPanel(Cargo cargo, int startX, int startY) {
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

    private void drawUpgradePanel(String upgradeName, int price, int startX, int startY) {
        Window upgradePanel = new Window(startX, startY, shopTheme[2]);
        upgradePanel.drawWindow(300, 70, false);

        fill(255);
        textFont(MAIN_FONT);
        text("[+] " + upgradeName, startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING);

        fill(0, 255, 0);
        textFont(MAIN_FONT);
        text("Cr. " + price, startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING+MAIN_FONT_PADDING);
    }
}
