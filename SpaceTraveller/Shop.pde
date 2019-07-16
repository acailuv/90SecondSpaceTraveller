public class Shop {
    private final PFont MAIN_FONT = createFont("Consolas", 16);
    private final PFont NAME_FONT = createFont("Consolas Bold", 24);
    private final int NAME_FONT_PADDING = 24;
    private final int MAIN_FONT_PADDING = 16;
    private final int[] SHOP_NAME_LENGTH_RANGE = {4, 8};
    protected boolean active = false;
    private boolean musicPlayed = false;

    protected String shopName;
    protected int upgrade_EfficiencyPrice, upgrade_FuelCapPrice, upgrade_PassiveIncomePrice, upgrade_RefuelPrice;

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
        this.shopName = rnd.generatePlanetName((int)random(SHOP_NAME_LENGTH_RANGE[0], SHOP_NAME_LENGTH_RANGE[1])) + " Interplanetary Station";
        updateUpgradePrice();
        bgmChannel = minim.loadFile("shop_bgm.mp3", 2048);
        s.credits += s.passiveIncome;
    }

    public void drawShop() {
        if (s.fuel < 0) {
            s.fuel = 0;
        }
        if (active) {
            if (!musicPlayed) {
                bgmChannel.setGain(-15);
                bgmChannel.loop();
                musicPlayed = true;
            }
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
            int offset = 80;
            drawUpgradePanel("Engine Efficiency", upgrade_EfficiencyPrice, wp_StartX+25, wp_StartY+40);
            drawUpgradePanel("Fuel Tank Capacity", upgrade_FuelCapPrice, wp_StartX+25, wp_StartY+offset+40);
            offset += 80;
            drawUpgradePanel("Passive Income", upgrade_PassiveIncomePrice, wp_StartX+25, wp_StartY+offset+40);
            offset += 80;
            drawUpgradePanel("Refuel", upgrade_RefuelPrice, wp_StartX+25, wp_StartY+offset+40);


            //info panel
            int ip_StartX = wp_StartX, ip_StartY = wp_EndY+58;
            int ip_EndX = width-(width/2-25)-75, ip_EndY = width/3-110;
            Window infoPanel = new Window(ip_StartX, ip_StartY, shopTheme[1]);
            infoPanel.drawWindow(ip_EndX, ip_EndY, true);
            fill(0, 255, 0);
            textFont(NAME_FONT);
            text("[Funds]", ip_StartX+15, ip_StartY+25);
            textFont(MAIN_FONT);
            text("Cr. " + Integer.toString(s.credits), ip_StartX+15, ip_StartY+25+NAME_FONT_PADDING);
            fill(255);
            textFont(NAME_FONT);
            text("[Your Ship]", ip_StartX+ip_EndX/2-35, ip_StartY+25);
            textFont(MAIN_FONT);
            text("Efficiency: " + Float.toString((float)Math.floor(s.efficiency*100)) + "%", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING);
            text("Fuel Capacity: " + Float.toString(s.fuelCapacity) + " L", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING+MAIN_FONT_PADDING);
            text("Passive Income: " + Integer.toString(s.passiveIncome) + " Cr.", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING+2*MAIN_FONT_PADDING);
            text("Current Fuel: " + Float.toString(s.fuel) + " L", ip_StartX+ip_EndX/2-35, ip_StartY+25+NAME_FONT_PADDING+3*MAIN_FONT_PADDING);

            //leave button
            Button leave = new Button(ip_StartX+15, ip_StartY+25+NAME_FONT_PADDING+4*MAIN_FONT_PADDING, width-(width/2-25)-110, 35, new Color(255, 0, 0, 150));
            leave.drawButton("Leave");
            if (leave.isClicked()) {
                s.positionX = 0;
                s.positionY = 0;
                s.velocityX = 10;
                s.velocityY = 0;
                resetLevel();
                this.destroy();
                cockpit.create();
                delay(100);
            }
        }
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
        if (s.inventory.get(cargo.name) != null) {
            text("Cr. " + cargo.finalPrice + "     In Inventory(" + Integer.toString(s.inventory.get(cargo.name)) + ")", startX+NAME_FONT_PADDING/3, startY+2*NAME_FONT_PADDING+MAIN_FONT_PADDING);
        } else {
            text("Cr. " + cargo.finalPrice + "     In Inventory(0)", startX+NAME_FONT_PADDING/3, startY+2*NAME_FONT_PADDING+MAIN_FONT_PADDING);
        }

        //buy button
        Button buy;
        if (s.credits >= cargo.finalPrice) {
            buy = new Button(startX+NAME_FONT_PADDING/3, startY+3*NAME_FONT_PADDING+MAIN_FONT_PADDING-15, 325/2-25/2, 30, new Color(0, 255, 0, 200));
        } else {
            buy = new Button(startX+NAME_FONT_PADDING/3, startY+3*NAME_FONT_PADDING+MAIN_FONT_PADDING-15, 325/2-25/2, 30, new Color(50, 50, 50, 200));
        }
        buy.drawButton("Buy", new Color(0));

        //sell button
        Button sell = new Button(startX+NAME_FONT_PADDING/3+(325/2-25/2)+25/2, startY+3*NAME_FONT_PADDING+MAIN_FONT_PADDING-15, 325/2-25/2, 30, new Color(255, 0, 0, 200));
        sell.drawButton("Sell", new Color(0));

        //handles clicks
        //buy button
        if (buy.isClicked()) {
            if (s.credits >= cargo.finalPrice) {
                s.credits -= cargo.finalPrice;
                if (s.inventory.get(cargo.name) != null) {
                    s.inventory.put(cargo.name, s.inventory.get(cargo.name)+1);
                } else {
                    s.inventory.put(cargo.name, 1);
                }

                //debug print ship's inventory
                //for (String i : s.inventory.keySet()) {
                //    println("Cargo: " + i + "; Amount: " + Integer.toString(s.inventory.get(i)));
                //}
            }
            delay(100);
        }

        //sell button
        if (sell.isClicked()) {
            if (s.inventory.get(cargo.name) != null && s.inventory.get(cargo.name) > 0) {
                s.inventory.put(cargo.name, s.inventory.get(cargo.name)-1);
                s.credits += cargo.finalPrice;
            } else if (s.inventory.get(cargo.name) == null || s.inventory.get(cargo.name) == 0) {
                //do nothing
            }

            //debug print ship's inventory
            //for (String i : s.inventory.keySet()) {
            //    println("Cargo: " + i + "; Amount: " + Integer.toString(s.inventory.get(i)));
            //}
            delay(100);
        }
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

        //upgrade button
        Button upgrade;
        if (s.credits >= price) {
            upgrade = new Button(startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING+MAIN_FONT_PADDING+5, 285, 20, new Color(0, 255, 0, 200));
            if (upgradeName.equals("Refuel") && s.fuel >= s.fuelCapacity) {
                upgrade = new Button(startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING+MAIN_FONT_PADDING+5, 285, 20, new Color(50, 50, 50, 200));
            }
        } else {
            upgrade = new Button(startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING+MAIN_FONT_PADDING+5, 285, 20, new Color(50, 50, 50, 200));
            if (upgradeName.equals("Refuel") && s.credits >= 7) {
                upgrade = new Button(startX+NAME_FONT_PADDING/3, startY+NAME_FONT_PADDING+MAIN_FONT_PADDING+5, 285, 20, new Color(0, 255, 0, 200));
            }
        }
        if (upgradeName.equals("Refuel")) {
            if (s.credits >= price) {
                upgrade.drawButton("Refuel!", new Color(0));
            } else if (s.credits >= 7) {
                upgrade.drawButton("Partial Refuel!", new Color(0));
            } else {
                upgrade.drawButton("Can't Refuel!", new Color(0));
            }
        } else {
            upgrade.drawButton("Upgrade!", new Color(0));
        }

        if (upgrade.isClicked()) {
            switch(upgradeName) {
            case "Engine Efficiency":
                if (s.efficiencyLvl < 10 && s.credits >= price) {
                    s.efficiency += 0.1;
                    s.efficiencyLvl++;
                    s.credits -= price;
                }
                break;
            case "Fuel Tank Capacity":
                if (s.fuelCapLvl < 10 && s.credits >= price) {
                    s.fuelCapacity += s.fuelCapacity;
                    s.fuelCapLvl++;
                    s.credits -= price;
                }
                break;
            case "Passive Income":
                if (s.passiveIncomeLvl < 10 && s.credits >= price) {
                    s.passiveIncome += s.passiveIncome;
                    s.passiveIncomeLvl++;
                    s.credits -= price;
                }
                break;
            case "Refuel":
                if (s.fuel < s.fuelCapacity) {
                    if (s.credits >= price) {
                        s.fuel = s.fuelCapacity;
                        s.credits -= price;
                    } else if (s.credits >= 7) {
                        int amountOfFuelRestored = s.credits/7;
                        s.fuel += amountOfFuelRestored;
                        s.credits -= amountOfFuelRestored*7;
                    }
                }
                break;
            }
            updateUpgradePrice();
            delay(100);
        }
    }

    private void updateUpgradePrice() {
        upgrade_EfficiencyPrice = (int)Math.pow(10, s.efficiencyLvl);
        upgrade_FuelCapPrice = (int)Math.pow(10, s.fuelCapLvl);
        upgrade_PassiveIncomePrice = (int)Math.pow(10, s.passiveIncomeLvl);
        upgrade_RefuelPrice = (int)(7* (s.fuelCapacity - s.fuel));
    }

    public void destroy() {
        bgmChannel.close();
        minim.stop();
        musicPlayed = false;
        this.active = false;
    }

    public void create() {
        this.active = true;
        bgmChannel = minim.loadFile("shop_bgm.mp3", 2048);
    }
}
