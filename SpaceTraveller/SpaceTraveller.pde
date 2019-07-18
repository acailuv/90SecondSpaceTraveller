import ddf.minim.*;

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
    readyToAdventure.insertDialogue(new TextWindow(new Window(0, 400), "Via AI", "Press [A] to activate your brake pulse. Use this to decelerate when needed."), aiColor);
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
