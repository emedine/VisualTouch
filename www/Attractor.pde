
class Attractor{
    float mass;
    PVector location;
    float G;
    
    Attractor(float theG){
        location = new PVector(width/2, height/2);
        mass = 20;
        G = theG;
    }
    
    // returns it attraction
    PVector attract(Mover m){
        PVector force = PVector.sub(location, m.location);
        float distance = force.mag();
        distance = constrain(distance, 5.0, 25.0);
        
        force.normalize();
        float strength = (G * mass * m.mass) / (distance * distance);
        force.mult(strength);
        return force;
    }  
    
    //
    void display(){
        fill(0,0,0,0);
        strokeWeight(1);
        stroke(color(trimColor, 65),200);
        ellipse(location.x, location.y, mass, mass);
    }
    
}


//// end attractor class
