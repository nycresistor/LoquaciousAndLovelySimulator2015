// Keep this as close to Arduino code as possible, the point
// is to copy/paste it into the final sketch.

class Arduino {
  //#define color uint32_t

  LPD8806 head;
  LPD8806 leftFrontLeg;
  LPD8806 leftBackLeg;
  LPD8806 rightFrontLeg;
  LPD8806 rightBackLeg;
  LPD8806[] strips = new LPD8806[5];

  //long frame;
  //color col;
  int mode = 0;
  int index = 0;
  int modes[] = new int[8];
  color rainbowWipeColor = color(0, 0, 0);

  public void setup() {    
    strips[0] = head = new LPD8806(100);
    strips[1] = leftFrontLeg = new LPD8806(80);
    strips[2] = leftBackLeg = new LPD8806(80);
    strips[3] = rightFrontLeg = new LPD8806(80);
    strips[4] = rightBackLeg = new LPD8806(80);

    modes[0] = 100; // colorWipe
    modes[1] = 100; // colorWipe
    modes[2] = 100; // colorWipe
    modes[3] = 100;  // rainbowWarp
    modes[4] = 100;  // rainbowWarp
    modes[5] = 100;  // rainbowWarp
    modes[6] = 100;  // blinkyBlinky
    modes[7] = 100;  // sparklySparkly

    //frame = 0;
    //col = head.Color(int(random(255)), int(random(255)), int(random(255)));
  }

  void colorWipe(int index, color col) {
    for (int strip = 0; strip < 5; strip++) {
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
      for (int i = 0; i < 5; i++) {
        for (int section = 0; section < 5; section++) {
            int led = (strips[i].numPixels() / 5) * section;
            strips[i].setPixelColor(led, color(random(50, 255), random(50, 255), random(50, 255)));
        }
      }
    }

    for (int strip = 0; strip < 5; strip++) {
      for (int led = strips[strip].numPixels () - 1; led > 0; led--) {
        strips[strip].setPixelColor(led, strips[strip].getPixelColor(led - 1));
      }
      strips[strip].show();
    }
  }

  void blinkyBlinky(int index) {
    for (int i = 0; i < 5 ; i++) {
      for (int led = 0; led < strips[i].numPixels (); led++) {
        if (index % 6 < 3) {
          strips[i].setPixelColor(led, color(255, 255, 255));
        } else {
          strips[i].setPixelColor(led, color(0, 0, 0));
        }
      } 

      strips[i].show();
    }
  }

  void sparklySparkly(int index) {
      if (index % 4 == 0) {
        for (LPD8806 strip : strips) {
          for (int led = 0; led < strip.numPixels (); led++) {
            if (random(3) > 2) strip.setPixelColor(led, color(255, 255, 255));
            else strip.setPixelColor(led, color(0, 0, 0));
          } 
          strip.show();
        }
      }
    }

  void clear() {
    for (int i=0; i<5; i++) {
      for (int led=0; led<strips[i].numPixels(); led++) {
        strips[i].setPixelColor(led, color(0));
      }
    }
  }

/*
  void loop() 
  {
     int i;
     
     frame++;
     
     if (frame % 100 == 0) {
     col = color(random(255),random(255),random(255));
     }
     
     for (i=0; i<5; i++) {
       all[i].setPixelColor(int(frame % all[i].numPixels()), col);
       all[i].show();
     }
   }
*/

  void loop() {
    index++;
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
}
