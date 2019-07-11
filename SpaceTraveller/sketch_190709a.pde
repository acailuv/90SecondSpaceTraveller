// This file is used for testing the backend system
/*
PImage ship;
Planet[] planets;
boolean gameOver = false;
Ship s;
void setup() {
  frameRate(60);
  size(800, 600);
  ship = loadImage("ship.png");
  s = new Ship(100);
  //mars = new Planet(1e5, 1e3, 1e2, 100);
  planets = new Planet[10];
  for(int i = 0; i < 10; i ++) {
    planets[i] = new Planet(random(2e5, 3e5), (i+1)*2e3, random(-200, 200), random(100, 150));
  }
  for(int i = 0; i < 10; i ++) {
    System.out.println("Planet " + (i+1));
    System.out.println(planets[i].mass + " " + planets[i].radius + " " + planets[i].positionX + " " + planets[i].positionY); 
  }
  
  imageMode(CENTER);
}
void universe() {
  for(int i = 0; i < 10; i ++) {
    s.universalForce(planets[i]);
    if(sqrt(s.distanceFromPlanet(planets[i])) <= planets[i].radius) {
      if(!gameOver)
        System.out.println("Crash at " + s.positionX + " " + s.positionY);
      gameOver = true;
      noLoop();
    } else if(sqrt(s.distanceFromPlanet(planets[i])) <= planets[i].radius * 4) {
      if(s.positionY > planets[i].positionY && s.positionY < planets[i].positionY + planets[i].radius*2) {
        text("Hover up!", 100, 200);
      } else if(s.positionY <= planets[i].positionY && s.positionY > planets[i].positionY - planets[i].radius*2) {
        text("Go down!", 100, 200);
      }
    }
  }
}
void draw() {
  background(255);
  noStroke();
  
  fill(0);
  text("Angle: " + degrees(s.getAngle()), 100, 100);
  text("X Velocity: " + (int)s.velocityX, 100, 120);
  text("Y Velocity: " + (int)s.velocityY, 100, 140);
  text((int)s.positionX + " " + (int)s.positionY, 100, 160);
  text("Fuel: " + s.fuel, 100, 180);
  if(gameOver) text("GAME OVER", width/2, height/2);
  
  universe();
  
  // status system
  translate(50, 50);
  rotate(-s.getAngle());
  image(ship, 0, 0);
}
void keyPressed() {
  if(key == 'w') s.bottomThruster();
  if(key == 's') s.topThruster();
  if(key == 'a') s.brakePulse();
  if(key == 'd') s.mainThruster();
}
*/
