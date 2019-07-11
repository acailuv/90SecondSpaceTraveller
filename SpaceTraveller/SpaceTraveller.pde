public TextWindow tw;
public Cockpit cockpit;
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);

void setup() {
    size(800, 600);
    cockpit = new Cockpit(0, 0);
    cockpit.changeTheme(cockpit.GREEN_THEME);
    
    //dialog test
    tw = new TextWindow(new Window(0, 400), "Via AI", "Immense Gravitational Force has been detected. I suggest you to counteract the neighboring planet's gravitational force.");
    tw.window.changeColor(aiColor);
}

void draw() {
    background(0, 0, 20);
    windowClickHandler();
    
    //draw windows
    tw.drawWindow();
    cockpit.drawCockpit();
}

void windowClickHandler() { //handle dialog box clicks
    if(tw.window.isHover() && mousePressed) {
        tw.destroy();
    }
}
