class Ship {
    protected float mass;
    protected float positionX;
    protected float positionY;
    protected float velocityX;
    protected float velocityY;
    protected float efficiency;
    protected float brakeFloor; // lower bound of ship horizontal velocity
    protected float brakeSpeed; // how much the ship deaccelerates per second if brakes are active
    protected float maxThrusterPower; // max thruster power
    protected float thrusterPower; // how much the ship accelerates per second if thrusters are active
    protected float fuelCapacity; // max fuel
    protected float fuel; // current fuel, refilled to fuelCapacity every level
    protected int credits; //currency

    public Ship(float mass) {
        this.mass = mass;
        velocityX = 10;
        velocityY = 0;
        positionX = 0;
        positionY = 0;
        efficiency = 0.1;
        thrusterPower = 10;
        brakeFloor = 10;
        brakeSpeed = 1;
        fuel = 100;
    }

    public float getAngle() {
        return atan(velocityY/velocityX);
    }

    public float distanceFromPlanet(Planet p) {
        return pow(positionY - p.positionY, 2) + pow(positionX - p.positionX, 2);
    }

    public float angleFromPlanet(Planet p) {
        return atan((positionY - p.positionY)/(positionX - p.positionX));
    }

    public void universalForce(Planet p) {
        //System.out.println("distance: " + sqrt(distanceFromPlanet(p)));

        float force = mass * p.mass / distanceFromPlanet(p);
        float forceX = force * cos(angleFromPlanet(p));
        float forceY = force * sin(angleFromPlanet(p));
        velocityX += (forceX/mass)/frameRate;
        velocityY += (forceY/mass)/frameRate;
        positionX += velocityX/frameRate;
        positionY += velocityY/frameRate;
    }

    public void mainThruster() {
        velocityX += thrusterPower/frameRate;
        fuel -= (1/efficiency)/frameRate;
    }

    public void topThruster() {
        velocityY -= thrusterPower/frameRate;
        fuel -= (1/efficiency)/frameRate;
    }

    public void bottomThruster() {
        velocityY += thrusterPower/frameRate;
        fuel -= (1/efficiency)/frameRate;
    }

    public void brakePulse() {
        if (velocityX - brakeSpeed/frameRate > brakeFloor) {
            velocityX -= brakeSpeed/frameRate;
            fuel -= (1/efficiency)/frameRate;
        } else velocityX = brakeFloor;
    }
}
