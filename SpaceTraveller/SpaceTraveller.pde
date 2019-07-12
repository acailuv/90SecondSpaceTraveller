import ddf.minim.*;

//sound
public AudioPlayer player;
public Minim minim;

//scenes
public Cockpit cockpit;
public Shop shop;
public MainMenu main;

//conversations
public Conversation readyToAdventure;

//utilities
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);
public Ship s;
public PlanetHandler game;

void setup() {
    //inits
    frameRate(60);
    size(800, 600);

    //sound
    minim = new Minim(this);
    player = minim.loadFile("mainmenu_bgm.mp3", 2048);

    //cockpit
    cockpit = new Cockpit(0, 0);
    cockpit.changeTheme(cockpit.BLUE_THEME);

    //ship
    s = new Ship(100);
    s.credits = 200;

    //main menu
    main = new MainMenu();

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
    shop = new Shop(testCargo);

    //conversation test
    readyToAdventure = new Conversation();
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Welcome back! Ready to go on another adventure?"), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Yeah. Let's go."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Understood. Starting pre-flight checklist. Engine... ONLINE, Fuel System... ONLINE, Universal Positioning System... OPERATIONAL. Preparing to launch on your command."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Start the engine, please."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "The engine already started since we first talked."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Then why did you ask for my permission in the first place? -_-"), normalColor);
    game = new PlanetHandler();
}

void draw() {
    background(0, 0, 20);
    drawStars();
    if (main.active)
        main.drawMainMenu();
    else if (cockpit.active) {
        readyToAdventure.execute();
        if (game.gameStart == false) { // use this as a base to start the ship moving
            game.gameStart = true;
            game.generatePlanets();
            s.finishLine = game.finishLine;
        } else {
            // if the game is running, calculate ALL of the planet gravity forces acting on the ship
            System.out.println(game.universalGravity(s));
            //System.out.println(s.positionX + " " + s.positionY);
        }
        cockpit.drawCockpit(s);
    } else if (shop.active)
        shop.drawShop();
    
    //////// SCENE TRANSITION DEBUG
    //println("Main: " + main.active);
    //println("Cockpit: " + cockpit.active);
    //println("Shop: " + shop.active);
}
void keyPressed() {
    if (shop.active == false && s.fuel > 0) {
        if (key == 'w') s.bottomThruster();
        if (key == 's') s.topThruster();
        if (key == 'a') s.brakePulse();
        if (key == 'd') s.mainThruster();
    }
}
void stop() {
    player.close();
    minim.stop();
    super.stop();
}

private void drawStars() {
    for (int i=0; i<5; i++) {
        strokeWeight(1);
        stroke(0, 0, 20);
        fill(255);
        circle(random(0, 800), random(0, 600), random(1, 3));
    }
}
