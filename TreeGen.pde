import java.util.Queue;
import java.util.LinkedList;
Node root;
int count;
float size;
float offset;
ArrayList<ArrayList<Integer>> adjList;

void setup() {
  size(800, 800);
  adjList = new ArrayList<ArrayList<Integer>>();
  count = 1;
  size = 25;
  root = new Node(width/2, height/2, size, count);
  
  offset = 10;
  count++;
}

void draw() {
  background(0);
  stroke(255);
  showNodes(root);
  if(root == null){
    return;
  }
  Queue<Node> queue = new LinkedList<Node>();
  queue.add(root);
  while (!queue.isEmpty()) {
    int n = queue.size();
    while (n > 0) {
      Node temp = queue.poll();
      checkOverlap(temp);
      
      for (int i = 0; i < temp.children.size(); i++) {
        queue.add(temp.children.get(i));
      }
      n--;
    }
  }
}

void mouseReleased() {
  if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) 
  {

    Node n = getNodeByPos(mouseX, mouseY);
    if (n == null) {
      ellipse(mouseX, mouseY, 10, 10);
    } else {
      //check for overlap.
      Node nNode = new Node(n.xPos, n.yPos + 2 * n.size + offset, size, count);
      n.children.add(nNode);
      if(count % 10 == 0){
        size *= 0.9;
        changeSize(root, size);
      }
      count++;
      
    }
  }
}
void checkOverlap(Node node){
  HashMap<Float, Float> pos = new HashMap<Float, Float>();
  if(root == null){
    return;
  }
  Queue<Node> queue = new LinkedList<Node>();
  queue.add(root);
  while (!queue.isEmpty()) {
    int n = queue.size();
    while (n > 0) {
      Node temp = queue.poll();
      while(temp.xPos + 2 * temp.size >= node.xPos && temp.yPos + 2 * temp.size >= node.yPos){
        if(temp.data != node.data){
          node.xPos++;
          temp.xPos--;
          
        } else {
          return;
        }
      }
      
      for (int i = 0; i < temp.children.size(); i++) {
        queue.add(temp.children.get(i));
      }
      n--;
    }
  }
}

void showNodes(Node node) {
  //bfs
  if (node == null) {
    return;
  }
  Queue<Node> queue = new LinkedList<Node>();
  queue.add(node);
  while (!queue.isEmpty()) {
    int n = queue.size();
    while (n > 0) {
      Node temp = queue.poll();
      temp.show();
      for (int i = 0; i < temp.children.size(); i++) {
        line(temp.xPos, temp.yPos, temp.children.get(i).xPos, temp.children.get(i).yPos);
        queue.add(temp.children.get(i));
      }
      n--;
    }
  }
}

Node getNodeByPos(float x, float y) {
  Queue<Node> queue = new LinkedList<Node>();
  queue.add(root);
  while (!queue.isEmpty()) {
    int n = queue.size();
    while (n > 0) {
      Node temp = queue.poll();
      if ((temp.xPos - temp.size) < x && (temp.xPos + temp.size) > x
        && (temp.yPos - temp.size) < y && (temp.yPos + temp.size) > y
        ) {
        return temp;
      }
      for (int i = 0; i < temp.children.size(); i++) {
        queue.add(temp.children.get(i));
      }
      n--;
    }
  }
  return null;
}

void changeSize(Node node, float nSize){
  //bfs
  if (node == null) {
    return;
  }
  Queue<Node> queue = new LinkedList<Node>();
  queue.add(node);
  while (!queue.isEmpty()) {
    int n = queue.size();
    while (n > 0) {
      Node temp = queue.poll();
      if(temp.data != 1){
        temp.yPos -= temp.size * 0.2;
      }
      
      temp.size = nSize;
      
      for (int i = 0; i < temp.children.size(); i++) {
        queue.add(temp.children.get(i));
      }
      n--;
    }
  }
}
