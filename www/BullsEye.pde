class BullsEye{
  int screenPosX = 300;
  int screenPosY = 300;
  
  //
  int lineWidth = 60;
  int tSpacing = 5;
  
  //
  PFont readoutFont;
  PFont readoutFontSm;
  PFont readoutFontM;
  
  
  BullsEye(){
    readoutFont = createFont("Arial",14, true); /// normal fonts
    readoutFontM = createFont("Arial",12, true); /// med fonts
    readoutFontSm = createFont("Arial",10, true); /// sm fonts


    smooth();
    noStroke();
    
  }
  
  void display(){
      if(mouseY < tHeight - 100){
        
        screenPosY = mouseY;
      }
      screenPosX = mouseX;
      lineWidth = 60;
      tSpacing = 5;
      fill(255);
        
        
      // pushMatrix();
      // rotate(1);
      /// do numbers
      //*
      textFont(readoutFontSm);
      text(screenPosY, screenPosX + lineWidth/1.5f, screenPosY + 15);
      textFont(readoutFontM);
      text(screenPosY - screenPosX, screenPosX + lineWidth/2, screenPosY + 30);
      textFont(readoutFont);
      text(screenPosX, screenPosX + 5, screenPosY + 45);
      
      //*/
      
      fill(0);
      stroke(255);
      strokeWeight(1);
        
      /// trim x
      line(screenPosX, screenPosY - tSpacing, screenPosX + lineWidth/2, screenPosY -tSpacing);
      line(screenPosX, screenPosY + tSpacing, screenPosX + lineWidth/2, screenPosY + tSpacing);
      ellipse(screenPosX, screenPosY, lineWidth/2, lineWidth/2);

      /// crosshair
      fill(0,0,0,0);
      stroke(255);
      // do horiz
      line(screenPosX-lineWidth/2, screenPosY, screenPosX + lineWidth, screenPosY);
      /// do vert
      line(screenPosX, screenPosY-lineWidth/2, screenPosX, screenPosY + lineWidth/1.75f);
      // do circle
      // ellipse(screenPosX-lineWidth, screenPosY-lineWidth, lineWidth/2, lineWidth/2);
      // ellipse(screenPosX-lineWidth/2, screenPosY-lineWidth/2, lineWidth/2, lineWidth/2);
      ellipse(screenPosX, screenPosY, lineWidth, lineWidth);
      //*/
      
        
          // thePoly.doPolygon(app, 5, screenPosX, screenPosY, 12, 12, theAlpha, fillColor);
        // thePoly.doPolygon(app, 3, screenPosX, screenPosY, 8, 8, 125, fillColor);
     /// thePoly.rotate(radians(theRotation));
     
     // popMatrix();
    }
  
/// end class
}

