int visID = 1;

int tWidth = 1024;
int tHeight = 768;
int tMargin = 20;
boolean has3D = false;

/////// MOVING SPHERES
int totalMovers = 5;
int totalSines = 2;


////// SPINNING BOXES
/*
float depth = 400;
RotatingBoxes theBoxes;
*/

/// COLOR SEEKER
ColorSeeker theSwarm;
//////Rorschach
Rorschach theRorshack;

// MASTER COLORS
color trimColor = color(255);
color MXColor1 = color(0);
color MXColor2 = color(255,0,0);
color UITrim = color(255,255,255);

float gravWeight = -5;

//////// OBJECT ARRAYS
ArrayList<Mover> movers;
ArrayList<TLine> lines;
ArrayList<SineWave> tsines;

//////// INTERFACE ARRAYAS
ArrayList<String> VisNames;
ArrayList<vSlider> Sliders;
ArrayList<wheelUI> Wheels;
ArrayList<button> Buttons;

/////// VISUALS ARRAYS
/// should store the visual classes here someohow

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

boolean showSliders = true;
boolean showSwitches = true;
boolean showWheels = true;

int UIbrightness = 255;
int mouseMode = 1;


Attractor a;
//
PVector wind = new PVector(0.01,0);
PVector gravity = new PVector(0,0.01);
//

boolean interfaceShowing = true;
boolean bangOnce = false;

void setup(){
  
   
    size(tWidth, tHeight);
    /// colorMode(HSB, 360,100,100,100);
    colorMode(RGB);
    smooth();
    /// objects
    tsines = new ArrayList();
    lines = new ArrayList();
    movers = new ArrayList();
    /// theBoxes = new RotatingBoxes();
    /// init rorshack
    theRorshack = new Rorschach();
    theRorshack.generateBalls();
    /// init Color Seeker
    theSwarm = new ColorSeeker();
    theSwarm.init();
    
    //// sines and circles   
    spawnMovers();
    spawnSines();
    // generate attractor
    a = new Attractor(gravWeight);
   
   
    /// interfaces
    VisNames = new ArrayList();
    Sliders = new ArrayList();
    Wheels = new ArrayList();
    Buttons = new ArrayList();
        
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

    int tLength = Sliders.size();
    //// do buttons
    /// (float bX, float bY, float bWidth, float bHeight, int colorPreset, int style)
    styleSwitch0 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);
    styleSwitch1 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth * 2, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);
    styleSwitch2 = new button(sliderPosX + (sliderWidths*tLength) + tMargin*tLength + buttonWidth * 3, sliderPosY, buttonWidth, buttonHeight, UITrim, 1);

    Buttons.add(styleSwitch0);
    Buttons.add(styleSwitch1);
    Buttons.add(styleSwitch2);
    
    VisNames.add("SineWave");
    VisNames.add("ColorSeeker");
    VisNames.add("Rorchach");

}

void draw(){
    /// do bg color
    if(visID == 0){
      background(0);
    } else {
      background(MXColor1);
    }
    
    /// draw and apply visuals
    drawVisuals();
    /// shows the "attractor"
    /// a.display();
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

//////// DRAW ALL VISUALS /////////

void drawVisuals(){
  int num = visID;

  switch(num) {
    case 0: 
      has3D = false;
       /// change this to array list capture
      drawMovers();
      drawSines();
      break;
    case 1: 
      theSwarm.display(mouseX, mouseY);
      break;
    case 2: 
      // drawRorschach();
      theRorshack.display();
      break;
  }
  
  
}

/////////////////////////
//// update all settings
///////////////////////////
void checkInterface(){
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
       if(visID == 2){
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
    //*/
}


////// INITIAL SPAWNS /////////

void spawnSines(){
    for (int i=0; i< totalSines; i++){
        tsines.add(new SineWave());
    }
    
}
void spawnLines(){
    for (int i=0; i< totalMovers; i++){
        lines.add(new TLine(10, random(0.1,5),500,i * 10));  
    } 
}
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

/////// DRAW OBJEXTS ///////////
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



//// start rorshach
void drawRorschach(){

   theRorshack.display();
  
}
//// end rorshach

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
// SPAWN PARAMS
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
}
void changeSineSpeed(float theS){
    for (int i=0; i< tsines.size(); i++){
        SineWave dsine = tsines.get(i);
        //// dsine.period = map(theS, -200,200, 0, 800); ///this changes the spacing
        dsine.theta = map(theS, 0,sliderHeights, 0.00, .99);
    }
}

//// DISPLAY PARAMS
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

////////////////
///// INTERFACE PARAMS ///////////
/////////////////////////////

void mousePressed() {
  
}
void mouseClicked() {
  if (bangOnce == false) {
    bangOnce = true;
  } 
}

 

 

///////////////////////////////////////
/////// LINE OBJECT CLASS //////////
///////////////////////////////////////
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


