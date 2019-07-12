public class Cargo {
    protected String name;
    protected String desc;
    protected int[] price = new int[2];
    protected int finalPrice;

    public Cargo(String name, String desc, int[] price) {
        this.name = name;
        this.desc = desc;
        this.price = price;
    }
    
    //public Cargo[] generateCargoList() {
    //    return new Cargo[] = {};
    //}
}
