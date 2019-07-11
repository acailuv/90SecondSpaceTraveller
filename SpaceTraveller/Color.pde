public class Color {
    protected int r, g, b, a;

    public Color(int r, int g, int b, int a) {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }
    
    public Color(int c) {
        this.r = c;
        this.g = c;
        this.b = c;
        this.a = 255;
    }
}
