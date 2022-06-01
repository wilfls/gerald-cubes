void setup() {
  size(1000, 1000);
  tri = new ArrayList<Triplice>(36);
  total = 0;
}

ArrayList<Triplice> tri;
int total;

void draw() {
  background(#fcfaf2);
 // strokeCap(ROUND);
  strokeJoin(ROUND);
  for (int i = 0; i < tri.size(); i++) {
    tri.get(i).display();
    if (tri.get(i).Alive()!= true) {
      tri.remove(i);
      total --;
    }
  }

  born();
}

class Triplice {
  int position;
  Cube red;
  Cube blue;
  Cube yellow;
  boolean grow;
  float growRate;
  float opacity;
  boolean alive;


  Triplice(float x, float y, int pos) {
    red = new Cube(x, y, color(#FF00FF));
    blue = new Cube(x+100, y+100, color(#00ffff));
    yellow = new Cube(x-50, y+150, color(#ffff00));
    grow = true;
    growRate = int(random(1, 6));
    opacity = 0;
    position = pos;
    alive = true;
  }

  void display() {
     strokeCap(ROUND);
    red.display(opacity);
    blue.display(opacity);
    yellow.display(opacity);
    if (frameCount%growRate==0) {
    if (grow) {
      opacity++;
      if (opacity == 255) {
        grow = false;
      }
    } else {
      opacity--;
      if (opacity ==0) {
        alive = false;
      }
    }
    }
  }

  boolean Alive() {
    return alive;
  }
}

class Cube {
  color ballCollor;
  float xpos;
  float ypos;
  float size;


  Cube(float x, float y, color myCorlor) {
    xpos = x;
    ypos = y;
    size=100;
    ballCollor = color(myCorlor);
  }

  void display(float opacity) {
    stroke(0, opacity);
    noFill();
    strokeWeight(4);
    float vertical = size/2;
    //back
    quad(xpos, ypos, xpos+size, ypos, xpos+size, ypos+size, xpos, ypos+size);
    //down
    quad(xpos, ypos+size, xpos+size, ypos+size, xpos+size-vertical, ypos+size+vertical, xpos-vertical, ypos+size+vertical);
    //left
    quad(xpos, ypos, xpos-vertical, ypos+vertical, xpos-vertical, ypos+size+vertical, xpos, ypos+size);
    //right 
    quad(  xpos+size, ypos, xpos+size-vertical, ypos+vertical, xpos+size-vertical, ypos+size+vertical, xpos+size, ypos+size);
    //front
    quad(xpos-vertical, ypos+vertical, xpos+size-vertical, ypos+vertical, xpos+size-vertical, ypos+size+vertical, xpos-vertical, ypos+size+vertical);
    //up
    quad(xpos, ypos, xpos+size, ypos, xpos+size-vertical, ypos+vertical, xpos-vertical, ypos+vertical);

    fill(ballCollor, opacity*0.8);

    float avaragex= (xpos+xpos+size+xpos-vertical+xpos+size-vertical)/4;
    float avaragey= (ypos+ypos+size+ypos+vertical+ypos+size+vertical)/4;
    noStroke();
    circle(avaragex, avaragey, size/5);
  }
}


void born() {
  if ((total < 60) && (frameCount%int(random(1, 600))==0)) {
    //println("alive", total);
    float x = int(random(0, 11))*100;
    float y = int(random(0, 11))*100;
    float deslocate = int(random(0,2));
    if (deslocate == 1){
      x = x+50;
      y = y-50;
    }

    tri.add( new Triplice(x, y, total));
    total ++;
  }
}
