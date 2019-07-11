public class Window {
    protected int startX;
    protected int startY;
    protected Color bgColor;
    private int strokeWeight = 2;
    private int strokeColor = 255;
    private int r = 100, g = 100, b = 100, a = 100;
    private boolean active = true;

    public Window(Window window) {
        this.startX = window.startX;
        this.startY = window.startY;
        this.bgColor = window.bgColor;
    }

    public Window(int startX, int startY, Color bgColor) {
        this.startX = startX;
        this.startY = startY;
        this.bgColor = bgColor;
        r = bgColor.r;
        g = bgColor.g;
        b = bgColor.b;
        a = bgColor.a;
    }

    public Window(int startX, int startY) {
        this.startX = startX;
        this.startY = startY;
    }

    public Window(float startX, float startY, Color bgColor) {
        this.startX = (int)startX;
        this.startY = (int)startY;
        this.bgColor = bgColor;
        r = bgColor.r;
        g = bgColor.g;
        b = bgColor.b;
        a = bgColor.a;
    }

    public Window(float startX, float startY) {
        this.startX = (int)startX;
        this.startY = (int)startY;
    }

    public void drawWindow(boolean stroke) {
        if (active) {
            if (stroke) {
                strokeWeight(strokeWeight);
                strokeCap(ROUND);
                stroke(strokeColor);
            } else {
                strokeWeight(0);
            }
            fill(r, g, b, a);
            rect(startX, startY, width-2, height-startY-2);
        }
    }

    public void drawWindow(int endX, int endY, boolean stroke) {
        if (active) {
            if (stroke) {
                strokeWeight(strokeWeight);
                strokeCap(ROUND);
                stroke(strokeColor);
            } else {
                strokeWeight(0);
            }
            fill(r, g, b, a);
            rect(startX, startY, endX, endY);
        }
    }

    public void changeColor(Color newColor) {
        r = newColor.r;
        g = newColor.g;
        b = newColor.b;
        a = newColor.a;
    }

    public boolean isHover() {
        if (mouseX >= startX && mouseX < width && mouseY < height && mouseY >= startY && active) {
            return true;
        } else {
            return false;
        }
    }

    public void destroy() {
        active = false;
    }

    public void create() {
        active = true;
    }
}
