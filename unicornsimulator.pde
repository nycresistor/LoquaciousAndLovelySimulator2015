PShape unicorn;
PImage bg;
int offset_x = -55;
int offset_y = -110;
int mode = 0;
int index = 0;
VStrip[] strips = new VStrip[3];
int modes[] = new int[8];
color rainbowWipeColor = color(0, 0, 0);

void setup() {
  size(680, 394);
  noStroke();

  unicorn = loadShape("unicorn.svg");
  bg = loadImage("unicorn.jpeg");
  shape(unicorn, offset_x, offset_y);

  modes[0] = 100; // colorWipe
  modes[1] = 100; // colorWipe
  modes[2] = 100; // colorWipe
  modes[3] = 100;  // rainbowWarp
  modes[4] = 100;  // rainbowWarp
  modes[5] = 100;  // rainbowWarp
  modes[6] = 100;  // blinkyBlinky
  modes[7] = 100;  // sparklySparkly


  strips[0] = new VStrip(unicorn.getChild("frontleg"));
  strips[1] = new VStrip(unicorn.getChild("backleg"));
  strips[2] = new VStrip(unicorn.getChild("head"));
}

void colorWipe(int index, color col) {

  for (int strip = 0; strip < strips.length; strip++) {
    for (int led = 0; led < strips[strip].numPixels (); led++) {

      if ( led <= ((strips[strip].numPixels() / float(modes[mode])) * index)) {
        strips[strip].setPixelColor(led, col);
      } else {
        // Leave it be
      }
    }
    strips[strip].show();
  }
}

void rainbowWarp(int index) {

  if (index % 10 == 0) {
    for (VStrip strip : strips) {
      for (int section = 0; section < 5; section++) {
        int led = (strip.numPixels() / 5) * section;
        strip.setPixelColor(led, color(random(50, 255), random(50, 255), random(50, 255)));
      }
    }
  }

  for (int strip = 0; strip < strips.length; strip++) {
    for (int led = strips[strip].numPixels () - 1; led > 0; led--) {
      strips[strip].setPixelColor(led, strips[strip].state[led - 1]);
    }
    strips[strip].show();
  }
}

void blinkyBlinky(int index) {

  for (VStrip strip : strips) {
    for (int led = 0; led < strip.numPixels (); led++) {

      if (index % 6 < 3) {
        strip.setPixelColor(led, color(255, 255, 255));
      } else {
        strip.setPixelColor(led, color(0, 0, 0));
      }
    } 

    strip.show();
  }
}

void sparklySparkly(int index)
{
  if (index % 4 == 0) {
    for (VStrip strip : strips) {
      for (int led = 0; led < strip.numPixels (); led++) {
        if (random(3) > 2) strip.setPixelColor(led, color(255, 255, 255));
        else strip.setPixelColor(led, color(0, 0, 0));
      } 
      strip.show();
    }
  }
}

void clear()
{
  for (VStrip strip : strips) {
    for (int led = 0; led < strip.numPixels(); led++) {
      strip.setPixelColor(led, color(0)); 
    }
  } 
}

void draw() {
  image(bg, 0, 0);
  if (frameCount % 1 == 0) index++;
  if (index == modes[mode]) {
    index = 0;
    mode++;

    if (mode == modes.length) mode = 0;
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
  case 3:
  case 4:
  case 5:
    rainbowWarp(index);
    break;
  case 6:
    blinkyBlinky(index);
    break;
  case 7:
    sparklySparkly(index);
    break;
  }
}

