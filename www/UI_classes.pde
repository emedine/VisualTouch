public class vSlider
{
  float sliderX;// = 30;
  float sliderY;// = 200;
  float sWidth;// = hotCornerSize;
  float sHeight;// = stageHeight;
  int buffer = 1;
  boolean isOver;
  float sdifx = 0.0; 
  float sdify = 0.0; 
  color c;
  boolean locked,switch1,switch2;
  float origHeight,origY ;
  float sliderPosition,sliderValue;
  int Opacity;
  
  String theLabel;
  
  boolean UIclicked = true;

  
  void setSliderX(float sliderX)
  {
    this.sliderX = sliderX;
  }
  void setSliderY(float sliderY)
  {
    this.sliderY = sliderY;
  }
  
  vSlider(float sliderX, float sliderY, float sWidth, float sHeight, color colorPreset,float sliderValue, String tLabel)
  {
    theLabel = tLabel;
    this.sliderX = sliderX;
    this.sliderY = sliderY;
    this.sWidth = sWidth-2;
    this.sHeight = sHeight;
    this.sliderValue = sliderValue;
    origHeight = sHeight;
    origY = sliderY;
    sliderPosition = sliderY + sHeight - map(sliderValue,0,255,0,sHeight);
    c = colorPreset;
  }
  
  //--------added by hanjy --------------
  void updateSliderValue(float newSliderValue)
  {
    sliderValue = newSliderValue;
    sliderPosition = sliderY + sHeight - map(sliderValue,0,255,0,sHeight);
  }
  
  boolean checkOver() 
  {
    if ( mouseX > sliderX && mouseX < sliderX + sWidth &&  mouseY > sliderY && mouseY < sliderY + sHeight ) {
        return true;
        //isOver = true;
      } else {
        // isOver = false;
        return false;
      }
  }
    
  void display () 
  {
    if(checkOver()){
      isOver = true;      
    } else {
      isOver = false; 
    }

/*
    if(isOver && showSliders) { 
       if (UIclicked) {     
          locked = true;
//      println("slider Clicked");
      }
    }
    if(!UIclicked) {
      locked = false;
    }
    */
    if(isOver && showSliders){
      locked = true;
    } else {
      locked = false;
    }
    if(showSliders) Opacity +=5;
    else Opacity -=5;
    
    if (Opacity >0) Opacity = 0;
    if (Opacity < -50) Opacity = -50;
  
    strokeWeight (2);    
    fill(c,10+Opacity);
    stroke(c,50+Opacity);
    stroke(c,50+Opacity);
    beginShape();
    vertex(sliderX + sWidth - sWidth/4, sliderY-sWidth/4); 
    vertex(sliderX + sWidth, sliderY-sWidth/4);
    vertex(sliderX + sWidth, sliderY);      
    endShape(CLOSE);  
    
    beginShape();    
    if (locked) {
      fill(c,75+Opacity);
      stroke(c,165+Opacity); 
      
      sliderPosition = mouseY;
      
      if (sliderPosition < sliderY) {
          sliderPosition = sliderY;
        }
      if (sliderPosition > sliderY + sHeight) {
          sliderPosition = sliderY + sHeight;
        }
      
      sliderValue = map(sliderPosition, sliderY, sliderY + sHeight, 255, 0); 
    }else {
          fill(c,75+Opacity);
          stroke(c,165+Opacity); 
        } 
    vertex(sliderX, sliderPosition-sWidth/4);
    vertex(sliderX + sWidth - sWidth/4, sliderPosition-sWidth/4); 
    vertex(sliderX + sWidth, sliderPosition);
    vertex(sliderX + sWidth, sliderY + sHeight);
    vertex(sliderX , sliderY + sHeight);  
    endShape(CLOSE);  

    fill(c,165+Opacity);
    text(theLabel + " : " + int(sliderValue), sliderX +5, sliderY + sHeight-1);     
  }
}

///////////////////////////////////
//////////// TOGLLE BUTTON ///////////
///////////////////////////////////

public class button{
  float bX;// = 30;
  float bY;// = 200;
  float bWidth;// = hotCornerSize;
  float bHeight;// = stageHeight;
  boolean bOver;
  float bdifx = 0.0; 
  float bdify = 0.0; 
  int c;
  boolean toggle;
  boolean buttonClicked,switch1,switch2;
  int style;
  int Opacity;
  
  boolean UIclicked = true;
  
  button(float bX, float bY, float bWidth, float bHeight, int colorPreset, int style){
    this.bX = bX;
    this.bY = bY;
    this.bWidth = bWidth;
    this.bHeight = bHeight;
    this.bOver = false;
    this.c = colorPreset;
    this.style = 0;
    this.toggle = false;
  }
  
  void display(){
   if (showSwitches) {
     Opacity += 5;
   } else { 
     Opacity -= 5;
   }
   
   if (Opacity < -75) Opacity = -75;
   if (Opacity > 0) Opacity = 0;
     
   if (mouseX > bX && mouseX < bX+bWidth && 
        mouseY > bY && mouseY < bY+bHeight) {       
      this.bOver = true;    
    } 
    else 
    {
      this.bOver = false;
    }
    if (this.bOver == true && bangOnce){
      if (this.toggle && showSwitches){
        // buttonClicked = true;
        this.style = 0;
        this.toggle = false;
        bangOnce = false;
        println("toggle = " + this.toggle);           

      } else if (!this.toggle){

        this.toggle = true;
        this.style = 1;
        println("toggle = " + this.toggle);           
        
      }
      
    } else {
      buttonClicked = false;
    }
    
    // noStroke();
    int tB;
    if(this.style == 0){
      tB = 200;
      
    } else {
      tB = 100;
    } 
    
    color tColor = color(c);
    fill(tColor, 65);
    if(toggle){
      rect (bX,bY, bWidth,bHeight);   
    }
    // 
    
    ///*
    // fill(c,tB,tB,30+Opacity);
    rectMode (CORNER);
    // noFill();
    strokeWeight(1);
    stroke(tColor);
    // */

    int ts = 5;
    beginShape();
    vertex (bX+ts,bY); vertex (bX,bY); vertex (bX,bY+ts);
    endShape();
    beginShape();
    vertex (bX+bWidth-ts,bY+bHeight); vertex (bX+bWidth,bY+bHeight); vertex (bX+bWidth,bY+bHeight-ts);
    endShape();
    beginShape();
    vertex (bX,bY+bHeight-ts); vertex (bX,bY+bHeight); vertex (bX+ts,bY+bHeight);
    endShape();    
    beginShape();
    vertex (bX+bWidth-ts,bY); vertex (bX+bWidth,bY); vertex (bX+bWidth,bY+ts);
    endShape();   
    }
    
    
    
//// end class
}

//////////// XY PAD
//////////////////////////////////////

class xyPad {
  int padX,padY;
  int padWidth = 120;
  int padHeight = 120;
  float xOut,yOut;
  boolean isOver,locked;
  int dotX,dotY;
  
 xyPad (int x,int y) {
   this.padX = x;
   this.padY = y;
   xOut = padWidth/2;
   yOut = padHeight/2;
   dotX = round(padX + xOut);
   dotY = round(padY + yOut);
 }
 void display() {   
    fill (200,100,100,5+UIbrightness);
    strokeWeight(1);
    stroke(250,150,200,50+UIbrightness);
    for(int i = 0; i < 4; i++) {
      line (padX + padWidth/4*i,padY, padX + padWidth/4*i, padY + padHeight);
    }
    for(int i = 0; i < 4; i++) {
      line (padX,padY + padHeight/4*i, padX + padWidth, padY+ padHeight/4*i);
    }    
    rectMode(CORNER);
    rect (padX, padY, padWidth, padHeight);
    stroke(200,200,50,70+UIbrightness);
    strokeWeight(1);
    rectMode(CENTER);
    rect (dotX,dotY,8,8);    
    strokeWeight(2);
    line (dotX-3,dotY-3,dotX+3,dotY+3);
    line (dotX-3,dotY+3,dotX+3,dotY-3);    
    if (mouseX > padX && mouseX < padX + padWidth
        && mouseY > padY && mouseY <padY + padHeight) {
        isOver = true;
        } else isOver = false;
    if(isOver) { 
       if (mouseMode ==1 ) {     
      locked = true;
      println("xyPad Clicked");}
    }
    if(mouseMode == 0) {
      locked = false;
    }    
    if (locked) {
        dotX = mouseX;
        dotY = mouseY;
        if (dotX > padX + padWidth)
        dotX = padX + padWidth;
        if (dotX < padX)
        dotX = padX;
        if (dotY > padY + padHeight)
        dotY = padY + padHeight;
        if (dotY < padY)
        dotY = padY;
        }
        xOut = dotX - padX;
        yOut = dotY - padY;
  }
}
//-------------wheel UI class-----------------
class wheelUI {
 int x,y, radius;
 int lineX,lineY;
 float angle;
 float r;
 boolean isOver, locked;
 float value1, value2, value3;
 int Opacity;
 
 int tR;
 int tG;
 int tB;
 color whColor;
 
 boolean UIclicked = true;
 
 wheelUI (int x,int y, int radius) {
  this.x = x;
  this.y = y;
  this.radius = radius;
  boolean locked;
 }

 void  display() {
    if (mouseX > x-radius && mouseX < x + radius
        && mouseY > y-radius && mouseY <y + radius) {
        isOver = true;
        } else isOver = false;
        
    /* 
    if(isOver && showWheels) { 
       if (UIclicked) {     
      locked = true;
      println("Wheel Clicked");}
    }
    if(!UIclicked) {
      locked = false;
    }
    */
    if(isOver && showWheels){
      locked = true;
    } else {
      locked = false;
    }
    
   if (locked) {
     angle = atan2(mouseY - y, mouseX - x);
     r = sqrt(sq(x-mouseX) + sq(y-mouseY));
     if (r > radius) r = radius;
     
     value1 = degrees(angle)+180;
     value2 = map(r, 0, radius, 0,100);
     /// value3 = map(r, 0, radius, 0,100);
   }
   
   if (showWheels) Opacity += 10;
   else Opacity -= 10;
   
   if (Opacity < -100) Opacity = -100;
   if (Opacity > 0) Opacity = 0;
   
    strokeWeight(1);
    stroke(255,0,100,50+Opacity);
    ellipseMode(CENTER);
    
    tR= (int)map(value1, 0, 360, 1, 255);
    tG=(int)map(r, 0, radius, 1, 255);
    tB=(int)map(value2, 0, 180, 1, 255);
    
     pushMatrix();
     translate (x,y);
//     ellipse (0,0,radius*2,radius*2);     
     rotate (angle);
     noFill();
     
     line (r,0,0,0);
     // ellipse (0,0,30,30);
    
     // this is me converting to RGB
     // ( float r, float g, float b, float h, float s, float v )
     color RGBColor = HSVtoRGB(value1, 100*.01, 100*.01);
     
     whColor = RGBColor;
     
     // whColor = color(value1, 100,value2);
     // println("value1: " + value1 + " val 2" + value2 + " rad: " + r + " newcolor: " + whColor);
     fill (whColor);
     // fill (degrees(angle)+180, 100,value2,100+Opacity);
     ellipse (r,0,30,30);
     popMatrix();
//----draw color ring-----------------------
     pushMatrix();     
     translate(x,y);
     rotate(radians(-90));     
     strokeWeight(2);
     for(int i = 0; i < 36; i++) {
        rotate(radians(10));
        stroke (i*10, 100,100,70+Opacity);     
        line (-5,-radius,5,-radius);
//        point (0,-radius);
     }
     popMatrix();      
 }
  //////////////// HSB to RGB
color HSVtoRGB(float h, float s, float v ){
  int i;
  float f, p, q, t;
  float r,g,b;
  if( s == 0 ) {
    // achromatic (grey)
    r = g = b = v;
    /// return;
  }
  h /= 60;      // sector 0 to 5
  i = floor( h );
  f = h - i;      // factorial part of h
  p = v * ( 1 - s );
  q = v * ( 1 - s * f );
  t = v * ( 1 - s * ( 1 - f ) );

    switch( i ) {
    case 0:
      r = v;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = v;
      b = p;
      break;
    case 2:
      r = p;
      g = v;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = v;
      break;
    case 4:
      r = t;
      g = p;
      b = v;
      break;
    default:    // case 5:
      r = v;
      g = p;
      b = q;
      break;
  }
  r = map(r, 0,1,0,255);
  g = map(g, 0,1,0,255);
  b = map(b, 0,1,0,255);
  color x = color(r,g,b);
  return x;
  // println("R: " + r + " G: " + g + " B: " + b);
}

//// 
}
//-------- hightlight button class--------------
 class buttonUp {
   int offsetX,offsetY,id;
   int buttonSize;
   
   buttonUp (int x, int y, int buttonSize, int i) {
     this.offsetX = x +1;
     this.offsetY = y;
     this.id = id;
     this.buttonSize = buttonSize;
   }
   void setID (int id) {
    this.id = id; 
   }
   void Draw () {
    strokeWeight(1);
    beginShape();
    vertex(offsetX, offsetY + buttonSize*id); 
    vertex(offsetX+ buttonSize/4*3, offsetY + buttonSize*id );
    vertex(offsetX  + buttonSize, offsetY+buttonSize/4+ buttonSize*id);
    vertex(offsetX  + buttonSize, offsetY+buttonSize+ buttonSize*id);
    vertex(offsetX , offsetY+buttonSize+ buttonSize*id);    
    endShape(CLOSE);    
 }
 
 


}

