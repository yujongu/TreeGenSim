class Node{
  float xPos;
  float yPos;
  int data;
  float size;
  ArrayList<Node> children;
  
  Node(int d){
    data = d;
    children = new ArrayList<Node>();
  }
  
  Node(float x, float y, float s, int d){
    xPos = x;
    yPos = y;
    size = s;
    data = d;
    children = new ArrayList<Node>();
  }
  
  void show(){
    ellipseMode(RADIUS);
    fill(255);
    ellipse(xPos, yPos, size, size);
    textAlign(CENTER, CENTER);
    fill(0);
    text(data, xPos, yPos);
    
  }
  
}
