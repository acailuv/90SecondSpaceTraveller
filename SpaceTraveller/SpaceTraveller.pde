import ddf.minim.*;

// save
import java.io.Serializable;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

//sound
public AudioPlayer bgmChannel;
public AudioPlayer seChannel; //se = Sound Effect
public Minim minim;

//scenes
public Cockpit cockpit;
public Shop shop;
public MainMenu main;
public GameOver gameOver;
public WinScreen win;

//conversations
public Conversation readyToAdventure;

//utilities
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);
public Ship s;
public PlanetHandler game;
private boolean tutorial = true;

/////// CREDITS
// - Eric Skiff (https://ericskiff.com/music/)
// - Patrick de Arteaga (patrickdearteaga.com)

void setup() {
    //inits
    frameRate(60);
    size(800, 600);

    //sound
    minim = new Minim(this);
    bgmChannel = minim.loadFile("mainmenu_bgm.mp3", 2048);
    seChannel = minim.loadFile("click.mp3", 2048);

    //cockpit
    cockpit = new Cockpit(0, 0);
    cockpit.changeTheme(cockpit.BLUE_THEME);

    //ship
    s = new Ship(100);
    s.credits = 500;
    // prevent nullpointerexception when saving with an empty inventory
    s.inventory.put("Sugar", 0);
    s.inventory.put("Fusion Cell", 0);
    s.inventory.put("Space Cat", 0);
    s.inventory.put("Mystery Goo", 0);

    //main menu
    main = new MainMenu();

    //game over
    gameOver = new GameOver();

    //win
    win = new WinScreen();

    //shop test
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

    //conversation test
    readyToAdventure = new Conversation();
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Welcome back! Ready to go on another adventure?"), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Yeah. Let's go."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Understood. Starting pre-flight checklist. Engine... ONLINE, Fuel System... ONLINE, Universal Positioning System... OPERATIONAL. Preparing to launch on your command."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Start the engine, please."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "", "The engine starts."), normalColor, 1);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Before we venture forth I have to remind you, as a pilot, how to operate this spacecraft."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "*sigh* Can I skip this already?"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Press [A] to activate your brake pulse. Use this to decelerate instantly when needed."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Press [D] to throttle your back thruster. Use this to accelerate your X-axis velocity. Cranking up the speed will take you to your destination more quickly. However, be careful of the planets that inhabit the cosmos."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Press [W] and [S] to activate your bottom thruster and top thruster respectively. Use this to adjust your angle to dodge planets."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "I sure wish there is a window in this ship..."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "As old saying goes: \"You cannot always have the good things in life.\". Besides, I was told that making a window requires a ton of work. So my creator, which is also the creator of this ship, decided to scrap that idea."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "How convenient... =.="), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Thank you."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "That was a sarcastic statement, Via."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Sorry, I could not understand."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Well, I thought AI technology at this age is flawless. Nevermind that, without windows in this ship, I think I'm gonna crash sooner or later."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Do not worry, I shall assist you in navigating through the universe. I will call out a warning everytime there is a planet nearby."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Also, be wary of the [Lost Sector]."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "What's a [Lost Sector]? How come you never mention this to me before?"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "If you have gone too much upwards or too much downwards, you will enter the [Lost Sector]. It is a very deadly place, so I advise to to remain in your path when travelling across the galaxy."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "As usual, I will warn you when the [Lost Sector] is close as well."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "As you already know, when I warn you about something, There is a display on the lower left that shows you the detail of the oncoming danger. Be sure to check that often."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Also, I would like to remind you again about the [Time and Space Anomaly] do you still remember that term?"), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Ah, isn't it about how time and space become anomalous when I venture in wild space for more than [90 Seconds]?"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Exactly. The anomaly of this time and space will shred your ship into pieces and swallow you into another dimension."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Well, that's nice. I bet the anomaly starts as the result of enviromental damage that is caused by the rich..."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "I want to take part in that as well! Sounds fun destroying the universe. That's why-"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI + You", "\"-I want to be the richest traveller alive.\""), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "No offense, master. but I truly think your motivation is malformed."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Alright! Let's reach for the richest traveller in the galaxy!"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Master doesn't seem to listen to me."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Via, how many [Space Credits] left to be the richest person in the galaxy?"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Hmmm... Let's see here. You current have [500 Cr.] That means you are [99,500 Credits] away to be the richest traveller in this galaxy. Note that it's nothing compared to the richest person in the whole universe."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "I know, I know. Everyone has to start somewhere."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "One last thing. In a touch of a button, you can save your progress by pressing [K]"), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Woah, that's cool. That means I can savescum-"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "I'm sorry, I can't seem to activate this feature with the thruster and navigation system online."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Shucks, that means I can only save at an [Interplanetry Station]."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Also, you can only load your game at the [Main Menu]."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Hmm.. is there a reason behind this oddly specific conditions?"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Some space travellers manipulated the save and load system. They had become the richest person in the whole universe in just 3 trips-"), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Wow, that's cool. Please let me maipulate that feature too."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "However, the way save and load feature works involves the use of Time and Space manipulation. Not only it uses a ton of power, it is also NOT environment friendly."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "Ah, that means if You let me use the feature whenever I want, The [Time and Space Anomaly] can instantly occur."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "That's right. That is why, for your own safety, my creator forbids the use of this feature mid-flight."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "But why can I only load my progress at the [Main Menu]?"), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Since the [Main Menu] is in a very distant place from the [Time and Space Anomaly], you can safely use the loading feature (which uses the most power out of the two dangerous features) safely."), aiColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "You", "I see, well then it's high time we get going."), normalColor);
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "", "[Objective] Obtain 100,000 Space Credits (Cr.)"), normalColor, 1);

    game = new PlanetHandler();
}

void draw() {
    background(0, 0, 20);
    drawStars();

    //////// ACTUAL GAME FLOW
    if (s.credits >= 100000)
        win.drawWinScreen();
    if (gameOver.active)
        gameOver.drawGameOver();
    else if (main.active)
        main.drawMainMenu();
    else if (cockpit.active) {
        if (tutorial) {
            tutorial = readyToAdventure.executeReturn();
        } else {
            if (game.gameStart == false) { // use this as a base to start the ship moving
                game.gameStart = true;
                game.generatePlanets();
                s.finishLine = game.finishLine;
                s.startTime = millis();
            } else {
                // if the game is running, calculate ALL of the planet gravity forces acting on the ship
                System.out.println(game.universalGravity(s));
                //System.out.println(s.positionX + " " + s.positionY);
            }
            cockpit.drawCockpit(s);
        }
    } else if (shop.active)
        shop.drawShop();

    //////// SHOP DEBUG
    //shop.active = true;
    //shop.drawShop();

    /////// COCKPIT DEBUG
    //cockpit.drawCockpit(s);

    /////// MAIN MENU DEBUG
    //main.drawMainMenu();

    /////// GAME OVER DEBUG
    //if (main.active)
    //    main.drawMainMenu();
    //else
    //    gameOver.drawGameOver();

    /////// WIN DEBUG
    //if (main.active)
    //    main.drawMainMenu();
    //else
    //    win.drawWinScreen();

    //////// SCENE TRANSITION DEBUG
    //println("Main: " + main.active);
    //println("Cockpit: " + cockpit.active);
    //println("Shop: " + shop.active);
    //println("Game Over: " + gameOver.active);
}

void keyPressed() {
    if (shop.active == false && s.fuel > 0) {
        if (key == 'w') s.bottomThruster();
        if (key == 's') s.topThruster();
        if (key == 'a') s.brakePulse();
        if (key == 'd') s.mainThruster();
    }
    if (key == 'l' && main.active) selectInput("Select a file", "loadGame");
    if (key == 'k' && shop.active) selectOutput("Save to", "saveGame");
    if (key == 'g') s.positionX = 22000; // debug
}

public void loadGame(File f) {
    String[] loadData = loadStrings(f);
    s.efficiencyLvl = Integer.parseInt(loadData[0]);
    s.passiveIncomeLvl = Integer.parseInt(loadData[1]);
    s.fuelCapLvl = Integer.parseInt(loadData[2]);
    s.fuel = Float.parseFloat(loadData[3]);
    s.credits = Integer.parseInt(loadData[4]);
    s.inventory.put("Sugar", Integer.parseInt(loadData[5]));
    s.inventory.put("Fusion Cell", Integer.parseInt(loadData[6]));
    s.inventory.put("Space Cat", Integer.parseInt(loadData[7]));
    s.inventory.put("Mystery Goo", Integer.parseInt(loadData[8]));
    s.efficiency = s.efficiencyLvl*0.1;
    s.passiveIncome = (int)(100*pow(2, s.passiveIncomeLvl-1));
    s.fuelCapacity = (int)(100*pow(2, s.fuelCapLvl-1));
    this.tutorial = Boolean.parseBoolean(loadData[9]);
    main.destroy();
    cockpit.create();
}

public void saveGame(File f) {
    String[] saveData = new String[10];
    saveData[0] = Integer.toString(s.efficiencyLvl);
    saveData[1] = Integer.toString(s.passiveIncomeLvl);
    saveData[2] = Integer.toString(s.fuelCapLvl);
    saveData[3] = Float.toString(s.fuel);
    saveData[4] = Integer.toString(s.credits);
    saveData[5] = Integer.toString(s.inventory.get("Sugar"));
    saveData[6] = Integer.toString(s.inventory.get("Fusion Cell"));
    saveData[7] = Integer.toString(s.inventory.get("Space Cat"));
    saveData[8] = Integer.toString(s.inventory.get("Mystery Goo"));
    saveData[9] = Boolean.toString(this.tutorial);
    saveStrings(f, saveData);
}

void stop() {
    bgmChannel.close();
    seChannel.close();
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

public void resetLevel() {
    s.positionX = 0;
    s.positionY = 0;
    s.velocityX = 10;
    s.velocityY = 0;
    s.startTime = millis();
    game.generatePlanets();
}
