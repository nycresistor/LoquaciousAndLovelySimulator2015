PShape unicorn;
PImage bg;
int offset_x = -55;
int offset_y = -110;
int mode = 0;
int index = 0;
VStrip[] strips = new VStrip[3];

void setup() {
  size(680, 394);
  noStroke();

  unicorn = loadShape("unicorn.svg");
  bg = loadImage("unicorn.jpeg");
  shape(unicorn, offset_x, offset_y);

  strips[0] = new VStrip(unicorn.getChild("frontleg"));
  strips[1] = new VStrip(unicorn.getChild("backleg"));
  strips[2] = new VStrip(unicorn.getChild("head"));

}

void colorWipe(int index, color col) {
  float steps = 100;

  for (int strip = 0; strip < strips.length; strip++) {
    for (int led = 0; led < strips[strip].numPixels (); led++) {

      if ( led <= ((strips[strip].numPixels() / steps) * index)) {
        strips[strip].setPixelColor(led, col);
      } else {
        // Leave it be
      }
    }
    strips[strip].show();
  }
}

void draw() {
  image(bg, 0, 0);
  if (frameCount % 2 == 0) index++;
  if (index == 100) {
    index = 0;
    mode++;
  }

  switch(mode) {
  case 0:
    colorWipe(index, color(255, 0, 0));
    break;
  case 1:
    colorWipe(index, color(0, 255, 0));
    break;
  case 2:
    colorWipe(index, color(0, 0, 255));
    break;
  }

  if (mode == 3) mode = 0;
}

