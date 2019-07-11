public TextWindow tw;
public Cockpit cockpit;
public Shop shop;
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);
public Ship s;
public Conversation readyToAdventure;

void setup() {
    frameRate(60);
    size(800, 600);
    cockpit = new Cockpit(0, 0);
    cockpit.changeTheme(cockpit.GREEN_THEME);
    
    //ship
    s = new Ship(100, cockpit);
    s.credits = 200;

    //dialog test
    tw = new TextWindow(new Window(0, 400), "Via AI", "Welcome back! Ready to go on another adventure?");
    tw.window.changeColor(aiColor);
    
    //conversation test
    readyToAdventure = new Conversation();
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Welcome back! Ready to go on another adventure?"));
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Yeah. Let's go."));
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Understood. I'll assist you along the way."));

    //shop test
    int[] aa = {
        100, 200
    };
    Cargo[] testCargo = {
        new Cargo("Sugar", "Commodity of the commons.", aa),
        new Cargo("Fusion Cell", "Standard Interplanetary AA Battery.", aa),
        new Cargo("Space Cat", "\"Shhh, let's keep this between us.\"", aa),
        new Cargo("Mystery Goo", "It's White. And sticky too. Hmm..", aa)
    };
    shop = new Shop(testCargo, s);
}

void draw() {
    background(0, 0, 20);
    starsEffect();
    //draw windows
    if (shop.active) {
        shop.drawShop();
    } else {
        s.cockpit.drawCockpit();
        readyToAdventure.execute();
    }
}

void starsEffect() {
    fill(255);
    point(random(0, 800), random(0,600));
    delay(10);
}
