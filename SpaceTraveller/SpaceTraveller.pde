import ddf.minim.*;

//sound
public AudioPlayer player;
public Minim minim;

public TextWindow tw;
public Cockpit cockpit;
public Shop shop;
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);
public Ship s;
public Conversation readyToAdventure;
public PlanetHandler game;

void setup() {
    frameRate(60);
    size(800, 600);
    
    //sound
    minim = new Minim(this);
    player = minim.loadFile("journey_bgm.mp3", 2048);
    
    //cockpit
    cockpit = new Cockpit(0, 0, player, minim);
    cockpit.changeTheme(cockpit.GREEN_THEME);

    //ship
    s = new Ship(100, cockpit);
    s.credits = 200;

    //dialog test
    tw = new TextWindow(new Window(0, 400), "Via AI", "Welcome back! Ready to go on another adventure?");
    tw.window.changeColor(aiColor);

    //conversation test
    readyToAdventure = new Conversation();
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Welcome back! Ready to go on another adventure?"), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Yeah. Let's go."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Understood. Starting pre-flight checklist. Engine... ONLINE, Fuel System... ONLINE, Universal Positioning System... OPERATIONAL. Preparing to launch on your command."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Permission Granted."), normalColor);

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
    shop = new Shop(testCargo, s, player, minim);
    game = new PlanetHandler();
}

void draw() {
    background(0, 0, 20);
    //draw windows
    if (shop.active) {
        shop.drawShop();
    } else {
        s.cockpit.drawCockpit(s);
        readyToAdventure.execute();
        if(game.gameStart == false) { // use this as a base to start the ship moving
          game.gameStart = true;
          game.generatePlanets();
          s.finishLine = game.finishLine;
        } else {
          // if the game is running, calculate ALL of the planet gravity forces acting on the ship
          game.universalGravity(s);
          //System.out.println(s.positionX + " " + s.positionY);
        }
    }
}
void keyPressed() {
  if(shop.active == false && s.fuel > 0) {
    if(key == 'w') s.bottomThruster();
    if(key == 's') s.topThruster();
    if(key == 'a') s.brakePulse();
    if(key == 'd') s.mainThruster();
  }
}
void stop() {
    player.close();
    minim.stop();
    super.stop();
}
