int rad = 30;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom


PVector location;  // Location of shape
PVector velocity;  // Velocity of shape
PVector gravity;   // Gravity acts at the shape's acceleration
float segLength = 75;
float x = 20;
float y = 20;
float angle1 = 0.0;

int ground_plane = 350;
int ground_ball = 190;
boolean pause = false;
boolean stop;


PImage bg;
//int y;

PFont f;

void setup() 
{
  size(1152, 864);
  fill(#FFFB81);
  noStroke();
  frameRate(120);
  ellipseMode(RADIUS);
  location = new PVector(100,100);
  velocity = new PVector(13.2,13.2);
  gravity = new PVector(0,0.0);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 640 x 360 pixels.
  bg = loadImage("background.jpg");
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  printArray(PFont.list());
  f = createFont("font.ttf", 24);
  textFont(f);
}

void draw(){ 
  if(pause == true){
    //background(0);
  }else{
    stroke(#000000);
    strokeWeight(5);
    background(bg);
    if (stop) return;
    noCursor();
    fill(255);
    rect(0, 3, width, 30);

    // Add velocity to the location.
    location.add(velocity);
    // Add gravity to velocity
    velocity.add(gravity);
    //Barriere
    //rect(0, height-200, width, 10);
    // Bounce off edges
    if ((location.x > width) || (location.x < 0)) {
      velocity.x = velocity.x * -1;
    }
    if (location.y < 0){ //Reflektion an der oberen Kante
      // We're reducing velocity ever so slightly 
      // when it hits the bottom of the window
      velocity.y = velocity.y * -0.95; 
      //location.y = mouseY;
    }
    if ((location.y > height-200) && (location.x > mouseX-75) && (location.x < mouseX+75)) {
      velocity.y = velocity.y * -0.99; 
    }
    // Display circle at location vector
    //stroke(255);
    //strokeWeight(2);
    fill(0,255,0);
    ellipse(location.x,location.y,15,15);
    // Update the position of the shape
    xpos = xpos + ( xspeed * xdirection );
    ypos = ypos + ( yspeed * ydirection );

    //paddle
    strokeWeight(2);
    fill(102);
    rect(mouseX-75, height-200, 150, 10, 100);

    // Test to see if the shape exceeds the boundaries of the screen
    // If it does, reverse its direction by multiplying by -1
    if (xpos > width-rad || xpos < rad) {
      xdirection *= -1;
    }
    if (ypos > height-rad-ground_plane || ypos < rad) {
      ydirection *= -1;
    }

    float dx = xpos - x;
    float dy = ypos - y;
    angle1 = atan2(dy, dx);  
    x = xpos - (cos(angle1) * segLength);
    y = ypos - (sin(angle1) * segLength);

    // Draw the plane
    strokeWeight(5);
    fill(255,0,0);
    ellipse(xpos, ypos, 40, 40);

    segment(xpos, ypos, angle1); 
    textAlign(CENTER);
    drawType();
  }
}

void segment(float x, float y, float a) {
  pushMatrix();
  translate(x, y);
  rotate(a);
  line(0, 0, -segLength, 0);
  ellipse(-segLength, 0, 20, 10);
  popMatrix();
}

void drawType() {
  fill(#82FF4D);
  stroke(0);
  strokeWeight(2);
  text(+millis(), width/2, 25);
  text("Drücke >R< zum Neustarten", width/4, 25);
  text("Drücke >ENTER< für eine Pause", width-300, 25);
}
void pause(){
  pause=true;
}

void unpause(){
  pause=false;
}


void keyPressed(){
  if(keyCode == ENTER){
    if(pause == false){
      pause = true;
    }else{
      pause = false; }
  }
  if (key == 'r' || key == 'R') {
     setup();
  }
}
  