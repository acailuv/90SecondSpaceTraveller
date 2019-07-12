class PlanetHandler {
    protected ArrayList <Planet> planets;
    protected int gapBetweenPlanets = 2000;
    protected int planetAmount = 10;
    protected int massFloor = 200000;
    protected int massCeiling = 300000;
    protected int YFloor = -200;
    protected int YCeiling = 200;
    protected int radiusFloor = 100;
    protected int radiusCeiling = 150;
    protected int deadZone = 800; // Y deadzone from -800 to 800
    protected int finishLine;
    
    protected boolean gameStart = false;
    
    
    public PlanetHandler() {
        planets = new ArrayList<Planet>();
    }
    public void generatePlanets() {
      planets.clear();
        for (int i = 0; i < planetAmount; i ++) {
            planets.add(new Planet(random(massFloor, massCeiling), (i+1)*gapBetweenPlanets, random(YFloor, YCeiling), random(radiusFloor, radiusCeiling)));
        }
        finishLine = (planetAmount+1)*gapBetweenPlanets;
    }
    public String universalGravity(Ship s) {
        for (int i = 0; i < 10; i ++) {
            s.universalForce(planets.get(i));
            if (sqrt(s.distanceFromPlanet(planets.get(i))) <= planets.get(i).radius) {
                return "Collision";
            } else if (sqrt(s.distanceFromPlanet(planets.get(i))) <= planets.get(i).radius * 4) {
                if (s.positionY > planets.get(i).positionY && s.positionY < planets.get(i).positionY + planets.get(i).radius*2) {
                    return "Go up";
                } else if (s.positionY <= planets.get(i).positionY && s.positionY > planets.get(i).positionY - planets.get(i).radius*2) {
                    return "Go down";
                }
            }
        }
        return "No problem";
    }
}
