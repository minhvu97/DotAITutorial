class Population {
  Dot[] dots;
  float fitnessSum = 0;
  int gen = 1;
  int bestDotIndex = 0;
  
  int minStep = 400;
  
  Population(int size){
    dots = new Dot[size];
    for (int i = 0 ; i < size ; i++){
      dots[i]  = new Dot();
    }
  }
  
  //---------------------------------------------------------------------------------
  void show() {
    for (int i = 1 ; i < dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }
  
  //----------------------------------------------------------
  void update() {
    for (int i = 0 ; i < dots.length; i++){
      if (dots[i].brain.step > minStep){
        dots[i].isDead = true;
      }
      else {
        dots[i].update();
      }
    }
  }
  
  //-------------------------------------------------------
  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }
  
  //-----------------------------------------------------
  Boolean allDotsAreDead() {
    for ( int i = 0 ; i < dots.length; i++) {
      if (!dots[i].isDead && !dots[i].reachedGoal){
        return false;
      }
    }
    return true;
  }
  
  //---------------------------------------------------------
  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    calculateFitnessSum();
    setBestDotIndex();
    newDots[0] = dots[bestDotIndex].gimmeBaby();
    newDots[0].isBest = true;
    
    for (int i = 1; i < newDots.length; i++){
      // select parent based on the fitness
      Dot parent = selectParent();
      
      // get babies from them
      newDots[i] = parent.gimmeBaby();
    }
    
    dots = newDots.clone();
    gen ++;
  }
  
  
  //----------------------------------------------------------
  
  void calculateFitnessSum(){
    fitnessSum = 0 ; 
    for (int i = 0 ; i < dots.length; i++){
      fitnessSum +=  dots[i].fitness;
    }
  }
  
  Dot selectParent(){
    float rand = random(fitnessSum);
    
    float runningSum = 0;
    
    for (int i = 0; i < dots.length; i++){
      runningSum += dots[i].fitness;
      if (runningSum > rand){
        return dots[i];
      }
    }
    
    // should never get to this point
    return null;
  }
  
 
  //------------------------------------------------------------
  void mutateDemBabies() {
    for (int i = 1 ; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }
  
  //-------------------------------------------------
  void setBestDotIndex() {
    int maxIndex = 0;
    float max = dots[maxIndex].fitness;
    for (int i = 1 ; i  < dots.length; i ++){
      if (dots[i].fitness > max){
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDotIndex = maxIndex;
    
    if (dots[bestDotIndex].reachedGoal) {
      minStep = dots[bestDotIndex].brain.step; //<>//
    }
  }
}
