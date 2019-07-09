public class TextWindow {
    private final int TEXT_PER_ROW = 48;
    private final PFont MAIN_FONT = createFont("Consolas", 16);
    protected int fontSize = 16;
    protected int padding = fontSize;
    protected String name;
    protected String text;
    protected Window window;
    protected boolean active = true;
    
    public TextWindow(Window window, String name, String text) {
        this.window = window;
        this.name = name;
        this.text = text;
    }
    
    public TextWindow(Window window, String name, String text, int fontSize) {
        this.window = window;
        this.name = name;
        this.text = text;
        this.fontSize = fontSize;
        this.padding = fontSize;
    }
    
    public void drawWindow() {
        if(active) {
            int ln = 1; //current line
            int currentChar = 1;
            window.drawWindow();
            
            //draw name
            for(int i=0; i<name.length(); i++) {
                textFont(MAIN_FONT);
                fill(100, 255, 255);
                text(name.charAt(i), (padding+window.startX)+i*padding, window.startY+padding*2*ln);
            }
            ln++;
            
            //draw main text
            for(int i=0; i<text.length(); i++) {
                textFont(MAIN_FONT);
                fill(255);
                text(text.charAt(i), (padding+window.startX)+(currentChar-1)*padding, window.startY+padding*2*ln);
                currentChar++;
                if(currentChar >= TEXT_PER_ROW) {
                    ln++;
                    currentChar = 1;
                }
            }
        }
    }
    
    public void destroy() {
        window.destroy();
        active = false;
    }
    
}
