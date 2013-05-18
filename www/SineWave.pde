 ///////////////////////////////////////
//////// SINE WAVE OBJECT CLASS /////////
///////////////////////////////////////

class SineWave{
    ///*
     int sampSize = 16;
     int xspacing = 16;   // How far apart should each horizontal location be spaced
     int w;              // Width of entire wave
     
     float theta = 0.02;
     float thetaBase = 0.0; // Start angle at 0
     float amplitude = 125.0;  // Height of wave
     float period = 800.0;  // How many pixels before the wave repeats
     float dx;  // Value for incrementing X, a function of period and xspacing
     float[] yvalues;  // Using an array to store height values for the wave
     //*/
    
    SineWave(){
        
         w = 1024+16;
         dx = (TWO_PI / period) * xspacing;
         yvalues = new float[w/xspacing];
         
    }
    
    void update(float tAmp, float tPer){
        amplitude = map(tAmp, 0, sliderHeights, 0, 250);
        period = map(tPer, 0,sliderHeights, 0, 1200);
        
        
    }
    
    
    void display() {
      dx = (TWO_PI / period) * xspacing;
      yvalues = new float[w/xspacing];
       calcWave();
       renderWave();
     }
       
     void calcWave() {
       // Increment theta (try different values for 'angular velocity' here
       // thetaBase += 0.02;
       thetaBase += theta;
       // For every x value, calculate a y value with sine function
       float x = thetaBase;
       for (int i = 0; i < yvalues.length; i++) {
         yvalues[i] = sin(x)*amplitude;
         x+=dx;
       }
     }
       
     void renderWave() {
       fill(0,0,0,0);
       strokeWeight(sampSize/3);
       stroke(MXColor2);
       // A simple way to draw the wave with an ellipse at each location
       for (int x = 0; x < yvalues.length; x++) {
         ellipse(x*sampSize, height/2+yvalues[x], sampSize, sampSize);
       }
     }
    
    
}
