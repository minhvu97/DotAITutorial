Population test;
PVector goal = new PVector(400, 10);

void setup() {
  size(800,800);
  test = new Population(500);
}

void draw() {
  background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
  fill(0,0,255);
  
  rect(100, 300, 600, 10);
  
  if (test.allDotsAreDead()){
    // generic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  }
  else {
    test.update();
    test.show();
  }
}
