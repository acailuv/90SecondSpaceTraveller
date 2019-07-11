public TextWindow tw;
public Cockpit cockpit;
public Shop shop;
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);
public Ship s;

void setup() {
    size(800, 600);
    cockpit = new Cockpit(0, 0);
    cockpit.changeTheme(cockpit.GREEN_THEME);
    
    //dialog test
    tw = new TextWindow(new Window(0, 400), "Via AI", "Immense Gravitational Force has been detected. I suggest you to counteract the neighboring planet's gravitational force.");
    tw.window.changeColor(aiColor);
    
    //shop test
    int[] aa = {
        100, 200
    };
    Cargo[] testCargo = {
        new Cargo("Sugar", "Commodity of the commons.", aa)
    };
    shop = new Shop(testCargo);
}

void draw() {
    background(0, 0, 20);
    windowClickHandler();
    
    //draw windows
    //tw.drawWindow(0);
    //cockpit.drawCockpit();
    shop.drawShop();
}

void windowClickHandler() { //handle dialog box clicks
    if(tw.window.isHover() && mousePressed) {
        tw.destroy();
    }
}
