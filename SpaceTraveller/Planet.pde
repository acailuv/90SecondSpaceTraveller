class Planet {
    protected float mass;
    protected String planetName;
    protected float positionX;
    protected float positionY;
    protected float radius;

    public Planet(float mass, float positionX, float positionY, float radius, String name) {
        this.mass = mass;
        this.positionX = positionX;
        this.positionY = positionY;
        this.radius = radius;
        this.planetName = name;
    }
}
