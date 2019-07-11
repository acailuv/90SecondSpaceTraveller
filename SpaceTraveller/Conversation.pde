public class Conversation {
    protected ArrayList<TextWindow> conversationQueue = new ArrayList<TextWindow>();
    private int current = 0;
    
    public Conversation() {
        //do nothing
    }
    
    public void insertDialogue(TextWindow content) {
        conversationQueue.add(content);
    }
    
    public void changeDialogue(int id, TextWindow newContent) {
        conversationQueue.set(id, newContent);
    }
    
    public void execute() {
        try {
            if (conversationQueue.get(current).active == false) {
                current++;
            } else {
                conversationQueue.get(current).drawWindow(0);
            }
        } catch (IndexOutOfBoundsException ex) {
           return; 
        }
    }
}
