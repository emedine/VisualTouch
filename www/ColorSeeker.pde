class ColorSeeker{
  
  // PFont HelveticaLight;
 
  int numBalls = 127;
  int maxBalls = numBalls;
  int fps;
  boolean clearBG, doSmooth;
  int shapeType; // 
  float maxVelocity = 16;// 
  float minAccel = 0.8;// 
  float maxAccel = 1.8;// 
   
  Seeker[] ball = new Seeker[numBalls];
   /*
  void setup(){
   
  }
  */
  
  void init(){
    
    
    noStroke();
   
    clearBG = true;
    doSmooth = false;
    shapeType = 0;

     
    for(int i=0; i<numBalls; i++){
      ball[i] = new Seeker(new PVector(random(tWidth), random(tHeight)));
    }
     
    
    
  }
   
  void display(float kinectX, float kinectY){
   
    
    /*
    if(clearBG){
      background(#111421);
    }
    */
    
    rectMode(CENTER);
    for(int i=0; i<numBalls; i++){
      ball[i].seek(new PVector(kinectX, kinectY));
      ball[i].render();
    }
     
   //  statusWindow();
   
  }
  /* 
  void statusWindow(){
    fill(50, 150);
    rectMode(CORNER);
    rect(5, 5, 140, 150);
    fill(0, 160, 255);
    text ((int)frameRate + " FPS", 15, 30);
    if (shapeType == 0){
      text ("(t) squares", 15, 45);
    }
    else{
      text ("(t) dots", 15, 45);
    }
   
    if (clearBG){
      text ("(p) clear BG", 15, 60);
    }
    else{
      text ("(p) paint BG", 15, 60);
    }
   
    if (doSmooth){
      text ("(o) smooth", 15, 75);
    }
    else{
      text ("(o) no smooth", 15, 75);
    }
   
    text("(z/a) Max velocity: " + nf(maxVelocity, 1, 1), 15, 90);
    text("(x/s) Min acceleration: " + nf(minAccel, 1, 2), 15, 105);
    text("(c/d) Max acceleration: " + nf(maxAccel, 1, 2), 15, 120);
    text("(v/f) Number of specks: " + numBalls, 15, 135);
  }
  
  void keyPressed() {
    if (key == 'p' || key == 'P') {
      clearBG = !clearBG;
    }
    if (key == 't' || key == 'T') {
      shapeType = 1-shapeType;
    }
    if (key == 'o' || key == 'O') {
      doSmooth = !doSmooth;
      if (doSmooth){
        smooth();
      }
      else{
        noSmooth();
      }
    }
    if ((key == 'z' || key == 'Z') && maxVelocity > 1) {
      maxVelocity--;
    }
    if (key == 'a' || key == 'A') {
      maxVelocity++;
    }
    if ((key == 'x' || key == 'X') && minAccel > 0) {
      minAccel-=.05;
    }
    if (key == 's' || key == 'S') {
      minAccel+=.05;
      minAccel = min(minAccel, maxAccel);
    }
    if (key == 'c' || key == 'C') {
      maxAccel-=0.05;
      maxAccel = max(minAccel, maxAccel);
    }
    if (key == 'd' || key == 'D') {
      maxAccel+=0.05;
    }
    if ((key == 'v' || key == 'V')) {
      numBalls-=50;
      numBalls = max(0, numBalls);
    }
    if (key == 'f' || key == 'F') {
      numBalls+=50;
      numBalls = min(maxBalls, numBalls);
    }
  }
   */

}

///////// SEEKER CLASS
class Seeker{
  PVector position;
  float accelRate, radius;
  PVector velocity = new PVector(0, 0);
  color fillColor;
  float rnd;
  float rnd2;
  float rnd3;
  //// previously in color seeker

  int shapeType; // 
  float maxVelocity = 16;// 
  float minAccel = 0.8;// 
  float maxAccel = 1.8;// 
  /*
  int NshapeType; // 
  float NmaxVelocity;// 
  float NminAccel;// 
  float NmaxAccel;// 
     */
  public Seeker(PVector pos){
    position = pos;
    rnd = random(1);
    rnd2 = random(1);
    rnd3 = random(1);
    fillColor = color((int) (rnd*255), (rnd2*255), (rnd3*255));
    strokeWeight(0);
  }
   
  public void seek(PVector target){
    
    //println(target.x + " , " +  target.y);
    
    accelRate = map(rnd, 0, 1, minAccel, maxAccel);
    target.sub(position);
    target.normalize();
    target.mult(accelRate);
    velocity.add(target);
    //velocity.add(new PVector(mouseX, mouseY));
    
    velocity.limit(maxVelocity);
 
    position.add(velocity);
  }
   
  public void render(){
    fill(fillColor);
    radius = sq(map(velocity.mag(), 0, maxVelocity, 10, 5));
    if(shapeType == 0){
      rect(position.x, position.y, radius, radius);
    }
    else{
      ellipse(position.x, position.y, radius, radius);
    }
  }
}


