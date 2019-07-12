public class Conversation {
    protected ArrayList<TextWindow> conversationQueue = new ArrayList<TextWindow>();
    private ArrayList<Integer> modes = new ArrayList<Integer>();
    private int current = 0;

    public Conversation() {
        //do nothing
    }

    public void insertDialogue(TextWindow content) {
        conversationQueue.add(content);
    }

    public void insertDialogue(TextWindow content, Color windowColor) {
        content.window.changeColor(windowColor);
        conversationQueue.add(content);
        modes.add(0);
    }

    public void insertDialogue(TextWindow content, Color windowColor, int mode) {
        content.window.changeColor(windowColor);
        conversationQueue.add(content);
        modes.add(mode);
    }

    public void changeDialogue(int id, TextWindow newContent) {
        conversationQueue.set(id, newContent);
    }

    public void execute() {
        try {
            if (conversationQueue.get(current).active == false) {
                current++;
            } else {
                conversationQueue.get(current).drawWindow(modes.get(current));
            }
        } 
        catch (IndexOutOfBoundsException ex) {
            return;
        }
    }
    
    public boolean executeReturn() {
        try {
            if (conversationQueue.get(current).active == false) {
                current++;
            } else {
                conversationQueue.get(current).drawWindow(modes.get(current));
            }
            return true;
        } 
        catch (IndexOutOfBoundsException ex) {
            return false;
        }
    }
        
}
