PShape unicorn;
VStrip head;
VStrip frontleg;
VStrip backleg;
PImage bg;
int offset_x = -55;
int offset_y = -110;

void setup() {
  size(680,394);
  unicorn = loadShape("unicorn.svg");
  bg = loadImage("unicorn.jpeg");
  shape(unicorn,offset_x,offset_y);
  frontleg = new VStrip(unicorn.getChild("frontleg"));
  backleg = new VStrip(unicorn.getChild("backleg"));
  head = new VStrip(unicorn.getChild("head"));  
}

void draw() {
  image(bg,0,0);

  frontleg.setPixelColor(frameCount % frontleg.count(), color(255));
  backleg.setPixelColor(frameCount % backleg.count(), color(255));
  head.setPixelColor(frameCount % head.count(), color(255));

  frontleg.show();
  backleg.show();
  head.show();
  
  frontleg.setPixelColor(frameCount % frontleg.count(), color(0));
  backleg.setPixelColor(frameCount % backleg.count(), color(0));
  head.setPixelColor(frameCount % head.count(), color(0));
  
}


