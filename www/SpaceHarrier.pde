class SpaceHarrier{

  int tSpacing = 10;
  int curX = 0;
  int curY = 0;
  
  int rectW = 1024;
  int rectH = 1;
  int numLines = 7;
  int lineSpeed = 10;
  
  int spawnPoint = 100;
  // int totalWidth = 600;
  
  LineClass tLine;
  
  ArrayList<LineClass> SkyLines;
  ArrayList<LineClass> GroundLines;
  
  SpaceHarrier(){
    // size(600,tHeight);
    
    SkyLines = new ArrayList();
    GroundLines = new ArrayList();
    rectW = tWidth *2;
  
    for(int i=0; i<numLines; i++){
      int up = (int)(spawnPoint - (i * tSpacing));
       //
      tLine = new LineClass(rectW+10, rectH, curX-10, up, true);
      SkyLines.add(tLine);
      println("up: " + up);
      
      int down = (int)(spawnPoint + (i * tSpacing));
        //
      tLine = new LineClass(rectW+10, rectH, curX-10, down, false);
      GroundLines.add(tLine);
      println("down: " + down);
    }
  }
  
  void display(){
     spawnPoint = mouseY;
     // background(MXColor1);
     float rotation = (float)map(mouseX, 0, tWidth, -25,25);
     fill(MXColor1);
     noStroke();
     pushMatrix();
     // translate(tWidth/2, tHeight/2);
     translate(-500, -300);
     
     rotate(radians(rotation));
     rect((float)0,(float)spawnPoint,(float)tWidth*2,(float)(tHeight*2-spawnPoint));
     fill(0,0,0,125);
     rect((float)0,(float)spawnPoint,(float)tWidth*2,(float)(tHeight*2-spawnPoint));
     for(int i=0; i< numLines; i++){
        // tLine.posY = curY;
        LineClass tl = GroundLines.get(i);
        
        tl.DZ += tl.DDZ;
        tl.Z += cos(tl.DZ);
        tl.display();
        
        //// tl.posY += (tl.posY)*.05; /// lineSpeed * (tl.posY*(tl.posY - tHeight));
        tl.posY = tl.DZ;
        tl.lHeight = (tl.posY)*.175;
        // tl.posY -= tl.lHeight/2;
        /// tl.lHeight = (tl.posY)*.1;
        if(tl.posY > tHeight){
          tl.lHeight = 1;
          tl.posY = spawnPoint;
          tl.DDZ = lineSpeed;
          tl.DZ = spawnPoint;
          // tl.Z = spawnPoint;
          tl.lineColor = color(MXColor2, 65);
        }
     }   
    
    /// sky
    for(int j=0; j < numLines; j++){
        // tLine.posY = curY;
        LineClass tl = SkyLines.get(j);
        
        tl.DZ -= tl.DDZ;
        tl.Z -= cos(tl.DZ);
        tl.display();
        
        //// tl.posY += (tl.posY)*.05; /// lineSpeed * (tl.posY*(tl.posY - tHeight));
        tl.posY = tl.DZ;
        tl.lHeight = (tHeight-tl.posY)*.05;
        if(tl.posY < 0){
          tl.lHeight = 1;
          tl.posY = spawnPoint-tl.lHeight;
          tl.DDZ = lineSpeed;
          tl.DZ = spawnPoint;
          // tl.Z = spawnPoint;
          tl.lineColor = color(MXColor2,165);
        }
     }    
     popMatrix();
  }
}

//////////////
class LineClass{
  float lWidth;
  float lHeight;
  float posX;
  float posY;
  boolean isSky;
  
  int lineSpeed = 10;
  int DDZ = lineSpeed;
  int DZ = 0;
  int Z = 0;
  color lineColor = color(54,54,54);
    
  LineClass(float lw, float lh, float px, float py, boolean iS){
    lWidth = lw;
    lHeight = lh;
    posX = px;
    posY = py;
    isSky = iS;
  }
  
  void display(){
     fill(lineColor);
     strokeWeight(0);
     // stroke(255);
     if(!isSky){
       rect(posX, posY, lWidth, lHeight);
       fill(0,0,0,65);
       rect(posX, posY, lWidth, lHeight);
     } else {
       rect(posX, posY, lWidth, lHeight);
     }
  }
  
  
/// end class 
}


