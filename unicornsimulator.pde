PShape leftShape;
PShape rightShape;
PImage leftBg;
PImage rightBg;

VStrip leftHead;
VStrip leftFrontLeg;
VStrip leftBackLeg;
VStrip rightHead;
VStrip rightFrontLeg;
VStrip rightBackLeg;

Arduino arduino;

void setup() {
  size(1360,394);
  
  // The vertexes in the SVG paths are used to 
  // define where LEDs go
  leftShape = loadShape("left.svg");
  rightShape = loadShape("right.svg");
  leftBg = loadImage("left.jpg");
  rightBg = loadImage("right.jpg");
  
  // The virtual arduino sketch will instantiate a
  // bunch of LPD8806s in its setup() method
  arduino = new Arduino();
  arduino.setup();
  
  // VStrip ties the LPD8806 instances to the SVG paths.
  // The last two parameters are offsets to correct lining up with the background.
  leftFrontLeg = new VStrip(leftShape.getChild("frontleg"), arduino.leftFrontLeg, -55, -110);
  leftBackLeg = new VStrip(leftShape.getChild("backleg"), arduino.leftBackLeg, -55, -110);
  leftHead = new VStrip(leftShape.getChild("head"), arduino.head, -55, -110);
  rightFrontLeg = new VStrip(rightShape.getChild("frontleg"), arduino.rightFrontLeg, 670, -110);
  rightBackLeg = new VStrip(rightShape.getChild("backleg"), arduino.rightBackLeg, 670, -110);
  rightHead = new VStrip(rightShape.getChild("head"), arduino.head, 670, -110);
}

void draw() {
  arduino.loop();
  
  image(leftBg,0,0);
  image(rightBg,width/2,0);

  leftFrontLeg.draw();
  leftBackLeg.draw();
  leftHead.draw();
  rightFrontLeg.draw();
  rightBackLeg.draw();
  rightHead.draw();
}


