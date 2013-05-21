int visID = 0;
String visType;

int tWidth = 1024;
int tHeight = 768;
int tMargin = 20;

/////// MOVING SPHERES and SINE WAVE
int totalMovers = 5;
int totalSines = 2;
Attractor a;
PVector wind = new PVector(0.01,0);
PVector gravity = new PVector(0,0.01);
/// COLOR SEEKER
ColorSeeker theSwarm;
//////Rorschach
Rorschach theRorshack;
/// SpaceHarrier
SpaceHarrier tSpaceHarrier;
////// SPINNING BOXES
/*
float depth = 400;
RotatingBoxes theBoxes;
*/

// MASTER COLORS
color trimColor = color(255);
color MXColor1 = color(0);
color MXColor2 = color(255,0,0);
color UITrim = color(255,255,255);

float gravWeight = -5;

//////// OBJECT ARRAYS
ArrayList<Mover> movers;
/// ArrayList<TLine> lines;
ArrayList<SineWave> tsines;

//////// INTERFACE ARRAYAS
ArrayList<vSlider> Sliders;
ArrayList<wheelUI> Wheels;
ArrayList<button> Buttons;

/////// VISUALS ARRAYS
/// should store the visual classes here someohow
ArrayList<String> VisNames;
// interface elements

int sliderWidths = 50; //// the image elements use this when setting their params
int sliderHeights = 100; //// the image elements use this when setting their params
int sliderRad = 100;
int sliderPosX = 200;
int sliderPosY = tHeight - sliderHeights - tMargin;
int buttonWidth = 50;
int buttonHeight = 50;

vSlider gravitySlider;
vSlider speedSlider;
vSlider sizeSlider;
vSlider spawnSlider;
vSlider heightSlider;

wheelUI colorWheelL;
wheelUI colorWheelR;

button styleSwitch0;
button styleSwitch1;
button styleSwitch2;
button styleSwitch3;

boolean showSliders = true;
boolean showSwitches = true;
boolean showWheels = true;
boolean UIlocked = false;
boolean UIVisible = true;
int UIbrightness = 255;
int mouseMode = 1;

boolean interfaceShowing = true;
boolean bangOnce = false;

void setup(){
    size(tWidth, tHeight);
    /// colorMode(HSB, 360,100,100,100);
    colorMode(RGB);
    smooth();
    /// objects
    tsines = new ArrayList();
    /// lines = new ArrayList();
    movers = new ArrayList();
    /// theBoxes = new RotatingBoxes();
    theRorshack = new Rorschach();
    theRorshack.generateBalls();
    theSwarm = new ColorSeeker();
    theSwarm.init(); 
    tSpaceHarrier = new SpaceHarrier();
    
    spawnMovers();
    spawnSines();
    // generate attractor
    a = new Attractor(gravWeight);
    
   
   
    /// interfaces
    VisNames = new ArrayList();
    Sliders = new ArrayList();
    Wheels = new ArrayList();
    Buttons = new ArrayList();
    
     //// create visual names array /////  
    VisNames.add("SineWave");
    VisNames.add("ColorSeeker");
    VisNames.add("Rorchach");
    VisNames.add("Tunnel");
    VisNames.add("SpaceHarrier");
    visType = VisNames.get(visID);
    /////  /////  /////  
    ////////// do wheels ////////////
    //////////  (int x,int y, int radius)
    colorWheelL = new wheelUI(0 + sliderRad, tHeight - sliderRad, sliderRad);
    Wheels.add(colorWheelL);
    colorWheelR = new wheelUI(tWidth - sliderRad, tHeight - sliderRad, sliderRad);
    Wheels.add(colorWheelR);
    
    ///////////  do sliders /////////////// 
    //////////  float sliderX, float sliderY, float sWidth, float sHeight, int colorPreset,float sliderValu
    spawnSlider = new vSlider(sliderPosX, sliderPosY, sliderWidths, sliderHeights, color(255,0,100), 255, "Number");
    gravitySlider = new vSlider(sliderPosX + (sliderWidths*1) + tMargin, sliderPosY, sliderWidths, sliderHeights, UITrim, 255,"Gravity");
    sizeSlider = new vSlider(sliderPosX + (sliderWidths*2) + tMargin*2, sliderPosY, sliderWidths, sliderHeights, UITrim, 255,"Size");
    speedSlider = new vSlider(sliderPosX +  (sliderWidths*3) + tMargin*3, sliderPosY, sliderWidths, sliderHeights, UITrim, 255, "Speed");
    heightSlider = new vSlider(sliderPosX +  (sliderWidths*4) + tMargin*4, sliderPosY, sliderWidths, sliderHeights, UITrim, 255, "Height");
    
    Sliders.add(spawnSlider);
    Sliders.add(gravitySlider);
    Sliders.add(sizeSlider);
    Sliders.add(speedSlider);
    Sliders.add(heightSlider);

    int tLength = VisNames.size();
    //// do buttons
    /// (float bX, float bY, float bWidth, float bHeight, int colorPreset, int style)
    styleSwitch0 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);
    styleSwitch1 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth * 2, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);
    styleSwitch2 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth * 3, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);
    styleSwitch3 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth * 4, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);

    ///////////  do buttons /////////////// 
    Buttons.add(styleSwitch0);
    Buttons.add(styleSwitch1);
    Buttons.add(styleSwitch2);
    Buttons.add(styleSwitch3);

}

void draw(){
    /// do bg color
    if(visType == "SineWave"){
      /// background(0);
      fill(0,0,0,65);
    } else {
      // background(MXColor1);
      fill(MXColor1,65);
    }
    noStroke();
    /// do weird "tracer"
    rect(0,0,tWidth, tHeight);
    /// draw and apply visuals
    drawVisuals();
    //// draw and apply interface
    drawInterface();
    checkInterface();
}

void drawInterface(){
  for(int k=0; k<Buttons.size(); k++){
    button b = Buttons.get(k);
    /// s.checkOver();
    b.display();
  }
  for(int i=0; i<Sliders.size(); i++){
    vSlider s = Sliders.get(i);
    /// s.checkOver();
    s.display();
  }
  
  for(int j=0; j<Wheels.size(); j++){
    wheelUI w = Wheels.get(j);
    /// s.checkOver();
    w.display();
  }
}


/////////////////////////
//// update all settings
///////////////////////////
void checkInterface(){
  if(!UIlocked){
   if(spawnSlider.isOver){
      changeSpawns(spawnSlider.sliderValue);
    }
    if(gravitySlider.isOver){
      changeGravity((int)gravitySlider.sliderValue);
    }
    if(sizeSlider.isOver){
      changeSize((int)sizeSlider.sliderValue);
    }
    if(speedSlider.isOver){
      changeSineSpeed((int)speedSlider.sliderValue);
    }
    if(heightSlider.isOver){
      changeSineHeight((int)heightSlider.sliderValue);
    }
    
    
    if(colorWheelL.isOver){
       MXColor1 = colorWheelL.whColor;
    }
    
    if(colorWheelR.isOver){
       MXColor2 = colorWheelR.whColor;
       if(visType == "Rorchach"){
         theRorshack.ballColor = MXColor2;
         
       }
    }
    ///*
    if(styleSwitch0.toggle){
      visID = 0;
    }
    if(styleSwitch1.toggle){
      visID = 1;
    }
    if(styleSwitch2.toggle){
      visID = 2;
    }
    if(styleSwitch3.toggle){
      visID = 3;
    }
    //*/
    
  }
}

//////// DRAW ALL VISUALS /////////

void drawVisuals(){
  int num = visID;
  visType = VisNames.get(num);
  switch(num) {
    case 0: 
      drawMovers();
      drawSines();
      break;
    case 1: 
      theSwarm.display(mouseX, mouseY);
      break;
    case 2: 
      theRorshack.display();
      break;
    case 3: 
      tSpaceHarrier.display();
      break;
  }
  
}

///////////////////////////////
//// MOVEMENT PARAMS
void changeGravity(float theGrav){
    gravWeight = map(theGrav, 0,sliderHeights,-10,10);
    a.G = gravWeight;
    /// println("GRAV: " + theGrav + " NEW: " + gravWeight);
    
}
void changeSize(float theSize){
    for (int i=0; i< tsines.size(); i++){
        SineWave dsine = tsines.get(i);
        dsine.sampSize = (int)map(theSize, 0, sliderHeights, 16, 127);
    } 
  
}

void changeSpawns(float theValue){
    totalMovers = int(map(theValue, 1, 400, 1, 20));
    spawnMovers();
    // println(totalMovers);
}

void changeSineHeight(float theH){
    for (int i=0; i< tsines.size(); i++){
        SineWave dsine = tsines.get(i);
        dsine.amplitude = map(theH, 0, sliderHeights, 0, 250);
       
    } 
    
   if(visType == "Rorchach"){
       theRorshack.movementMode = (int)map(theH, 0, sliderHeights, 0, 6);
       
   }
}
void changeSineSpeed(float theS){
    for (int i=0; i< tsines.size(); i++){
        SineWave dsine = tsines.get(i);
        //// dsine.period = map(theS, -200,200, 0, 800); ///this changes the spacing
        dsine.theta = map(theS, 0,sliderHeights, 0.00, .99);
    }
    
    if(visType == "Rorchach"){
       theRorshack.ballShapeMode = (int)map(theS, 0, sliderHeights, 0, 3);
       
   }
   
}
/*
//// color PARAMS
void changeMXColor1(String theColor){
    //// change font color
    String dColor = theColor; // theColor.substring(1);
    color newColor = unhex("FF" + dColor);
    MXColor2 = newColor;
}
void changeMXColor2(String theColor){
    //// change font color
    String dColor = theColor; // theColor.substring(1);
    color newColor = unhex("FF" + dColor);
    MXColor2 = newColor;
}
*/
//////////////
////// SINE WAVE AND MOVING BALL CONTROL /////////

void spawnSines(){
    for (int i=0; i< totalSines; i++){
        tsines.add(new SineWave());
    }
    
}
/*
void spawnLines(){
    for (int i=0; i< totalMovers; i++){
        lines.add(new TLine(10, random(0.1,5),500,i * 10));  
    } 
}
*/
/// spawn movers
void spawnMovers(){
    // generate movers
    movers.clear();
    for (int i=0; i< totalMovers; i++){
        // println("ADDING MOVER: " + i);
        // movers[i] = new Mover(random(0.1,5),0,0);
        movers.add(new Mover(random(0.1,5),0,0));  
    } 
}
////////////////////////////////////////

void drawSines(){
    for (int i=0; i< tsines.size(); i++){
        SineWave dsine = tsines.get(i);
        dsine.display();
    }
    
}
void drawMovers(){
    
    for (int i=0; i< movers.size(); i++){
        Mover dMover = movers.get(i);
        /// movers[i].applyForce(gravity);
        PVector f = a.attract(dMover);
        dMover.applyForce(f);
        dMover.update();
        dMover.checkEdges();
        dMover.display();
    }
}
///////// END SIVNE WAVE AND MOVERS //////////
////////////////
///// MOUSE AND KEYBOARD PARAMS ///////////
/////////////////////////////

void toggleUILock(){
  if(UIlocked){
    UIlocked = false;
  } else {
    UIlocked = true;
  }
  
}
void toggleUIBrightness(){
  if(UIVisible){
    UIVisible = false;
    showSliders = false;
    showSwitches = false;
    showWheels = false;
  } else {
      UIVisible = true;
      showSliders = true;
      showSwitches = true;
      showWheels = true;
    
  }
  
}

void mousePressed() {
  /// lock the interface if you 
  /// click on the upper left quad
  if(mouseX < 50 && mouseY < 50){
    toggleUILock();
    
  }
  
  /// show the interface if you click 20 px from the bottom of the screen
  if(mouseX > tWidth -100 && mouseY < 100){
    println("CLICK QUAD");
    toggleUIBrightness();

    
  } else {
    /*
    
    */

  }
  
}
void mouseClicked() {
  if (bangOnce == false) {
    bangOnce = true;
  } 
}

 

 

///////////////////////////////////////
/////// LINE OBJECT CLASS //////////
///////////////////////////////////////
/* 
class TLine{
    float lWidth;
    float lHeight;
    float posX;
    float posY;
    
    TLine(float lw, float lh, float px, float py){
        lWidth = lw;
        lHeight = lh;
        posX = px;
        posY = py;
        
    }
    void initLine(){
        
        
    }
    void display(){
        fill(0);
        strokeWeight(1);
        stroke(MXColor2,200);
        rect(posX, posY, lWidth, lHeight);
        
        
    }
    // end class
}

//// end line class
*/


