public Window window = new Window(0, 400);
public TextWindow tw;
public Color normalColor = new Color(100, 100, 100, 100);
public Color dangerColor = new Color(255, 100, 100, 100);
public Color aiColor = new Color(100, 100, 255, 100);

void setup() {
    size(800, 600);
    tw = new TextWindow(window, "Via AI", "Immense Gravitational Force has been detected. I suggest you to counteract the auiusbdcnkahsdbcjske.");
}

void draw() {
    background(0);
    windowClickHandler();
    window.changeColor(aiColor);
    tw.drawWindow();
}

void windowClickHandler() {
    if(window.isHover() && mousePressed) {
        tw.destroy();
    }
}
