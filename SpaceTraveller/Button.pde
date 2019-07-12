public class Button {
    protected int startX, startY;
    protected int w, h;
    protected PFont font = createFont("Consolas", 16);
    protected Color bgColor;
    private boolean active = true;;
    
    public Button(int startX, int startY) {
        this.startX = startX;
        this.startY = startY;
        w = 75;
        h = 75;
        bgColor = new Color(0, 0, 255, 255);
    }
    
    public Button(int startX, int startY, int w, int h) {
        this(startX, startY);
        this.w = w;
        this.h = h;
    }
    
    public Button(int startX, int startY, int w, int h, Color bgColor) {
        this(startX, startY);
        this.w = w;
        this.h = h;
        this.bgColor = bgColor;
    }
    
    public void drawButton(String text) {
        if(active) {
            applyHoverEffect();
            fill(bgColor.r, bgColor.g, bgColor.b, bgColor.a);
            rect(startX, startY, w, h);
            fill(255);
            textFont(font);
            text(text, startX+w/2-6*text.length(), startY+h/2+4);
        }
    }
    
    public void drawButton(String text, Color fontColor) {
        if(active) {
            applyHoverEffect();
            fill(bgColor.r, bgColor.g, bgColor.b, bgColor.a);
            rect(startX, startY, w, h);
            fill(fontColor.r, fontColor.b, fontColor.b, fontColor.a);
            textFont(font);
            text(text, startX+w/2-6*text.length(), startY+h/2+4);
        }
    }
    
    public void drawButton(String text, int textX, int textY) {
        if(active) {
            applyHoverEffect();
            fill(bgColor.r, bgColor.g, bgColor.b, bgColor.a);
            rect(startX, startY, w, h);
            fill(255);
            textFont(font);
            text(text, textX, textY);
        }
    }
    
    private void applyHoverEffect() {
        if (mouseX >= startX && mouseX <= startX+w && mouseY >= startY && mouseY <=startY+h) {
            bgColor.r = Math.max(bgColor.r-100, 0);
            bgColor.g = Math.max(bgColor.g-100, 0);
            bgColor.b = Math.max(bgColor.b-100, 0);
        }
    }
    
    public boolean isClicked() {
        if (mouseX >= startX && mouseX <= startX+w && mouseY >= startY && mouseY <=startY+h && mousePressed && active) {
            return true;
        } else {
            return false;
        }
    }
    
    public void destroy() {
        this.active = false;
    }
}
