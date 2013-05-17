///////////////////////////////////////
/////// MOVER OBJECT CLASS //////////
///////////////////////////////////////
class Mover{
    PVector location;
    PVector velocity;
    PVector acceleration;
    PVector wind;
    PVector gravity;
    
    float mass;
    int ballSize = 16;
    
    /// the mass, the x, the y);
    Mover(float m, float x, float y){
        mass = m;
        location = new PVector(random(width), random(height));
        velocity = new PVector(random(-2,2),random(-2,2));
        acceleration = new PVector(0.1,0.2);
        
    }
    
    /// force
    void applyForce(PVector force){
        PVector f = PVector.div(force,mass);
        acceleration.add(f);
        
    }
    
    void update(){
        velocity.add(acceleration);
        location.add(velocity);
        acceleration.mult(0);
    }
    
    
    
    void checkEdges(){
        if(location.x>width){
            location.x = width;
            velocity.x *= -1;
        } else if (location.x<0){
            velocity.x *= -1;
            location.x = 0;
        }
        
        if(location.y>height){
            velocity.y *= -1;
            location.y = height;
        } else if (location.y<0){
            location.y = 0;
            velocity.y *=-1;
        }
        
    }
    void display(){
        stroke(trimColor);
        strokeWeight(4);
        fill(0,0,0);
        
        ellipse(location.x, location.y, mass*ballSize, mass*ballSize);
        
    }
    
}
/// end mover class
