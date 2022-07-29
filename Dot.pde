class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  
  Boolean isDead = false;
  
  float fitness = 0;
  
  Boolean reachedGoal = false;
  
  Boolean isBest = false;
  
  Dot() {
   brain = new Brain(400);
    
   pos = new PVector(width/2, height-10);
   vel = new PVector(0,0);
   acc = new PVector(0,0);
  }
  
  //--------------------------------------------
  
  void show(){
    if (isBest){
      fill(0,255,0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
    
  }
  
  //--------------------------------------------
  
  void move(){
    if (brain.directions.length > brain.step){
      acc =  brain.directions[brain.step];
      brain.step++;
    }
    else {
      isDead = true;
    }
    
    vel.add(acc);
    vel.limit(5); // limit max speed to 5
    pos.add(vel);
    
  }
  
  //-----------------------------------------------
  void update(){
    if (!isDead && !reachedGoal){
      move();
      if (pos.x < 2 || pos.y < 2 || pos.x > width-2 || pos.y > height -2 ) {
        isDead = true;
      }
      else if (dist(pos.x, pos.y, goal.x, goal.y) < 5){
        reachedGoal = true;
      }
      else if (pos.x < 700 && pos.y < 310 && pos.x > 100 && pos.y > 300) {
        isDead = true;
      }
    }
  }
  
  //---------------------------------------------------
  void calculateFitness(){
    if (reachedGoal) {
      fitness = 1.0/16 + 1000.0/(float)(brain.step*brain.step);
    }
    else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }
  
  //------------------------------------------------------------
  // clone it
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  
  }
}
