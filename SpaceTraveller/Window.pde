class Window {
    protected int startX;
    protected int startY;
    protected Color bgColor;
    private int r = 100, g = 100, b = 100, a = 100;
    private boolean active = true;
    
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
    
    public void drawWindow() {
        if(active) {
            fill(r, g, b, a);
            rect(startX, startY, width, height);
        }
    }
    
    public void drawWindow(int endX, int endY) {
        if(active) {
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
        if (mouseX >= startX && mouseX < width && mouseY < height && mouseY >= startY) {
            return true;
        } else {
            return false;
        }
    }

    public void destroy() {
        active = false;
    }
    
}
