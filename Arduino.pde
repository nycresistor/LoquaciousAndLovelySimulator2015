// Keep this as close to Arduino code as possible, the point
// is to copy/paste it into the final sketch.

class Arduino {

//  #include <LPD8806.h>

  LPD8806 head;
  LPD8806 leftFrontLeg;
  LPD8806 leftBackLeg;
  LPD8806 rightFrontLeg;
  LPD8806 rightBackLeg;
//  LPD8806 strips[5];
  LPD8806[] strips = new LPD8806[5];

  int mode = 0;
  int idx = 0;
//  int modes[8];
  int modes[] = new int[8];
//  uint32_t rainbowWipeColor;
  color rainbowWipeColor;


//  uint32_t color(byte r, byte g, byte b) {
//    return ((uint32_t)(g | 0x80) << 16) |
//           ((uint32_t)(r | 0x80) <<  8) |
//                       b | 0x80 ;
//  }

  void setup() {    
//    strips[0] = head = LPD8806(100);
//    strips[1] = leftFrontLeg = LPD8806(80);
//    strips[2] = leftBackLeg = LPD8806(80);
//    strips[3] = rightFrontLeg = LPD8806(80);
//    strips[4] = rightBackLeg = LPD8806(80);
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
  }

//  void colorWipe(int idx, uint32_t col) {
  void colorWipe(int idx, color col) {
    for (int strip = 0; strip < 5; strip++) {
      for (int led = 0; led < strips[strip].numPixels (); led++) {

        if ( led <= ((strips[strip].numPixels() / float(modes[mode])) * idx)) {
          strips[strip].setPixelColor(led, col);
        } else {
          // Leave it be
        }
      }
      strips[strip].show();
    }
  }

  void rainbowWarp(int idx) {
    if (idx % 10 == 0) {
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

  void blinkyBlinky(int idx) {
    for (int i = 0; i < 5 ; i++) {
      for (int led = 0; led < strips[i].numPixels (); led++) {
        if (idx % 6 < 3) {
          strips[i].setPixelColor(led, color(255, 255, 255));
        } else {
          strips[i].setPixelColor(led, color(0, 0, 0));
        }
      } 

      strips[i].show();
    }
  }

  void sparklySparkly(int idx) {
      if (idx % 4 == 0) {
        for (int i = 0; i < 5; i++) {
          for (int led = 0; led < strips[i].numPixels(); led++) {
            if (random(3) > 2) strips[i].setPixelColor(led, color(255, 255, 255));
            else strips[i].setPixelColor(led, color(0, 0, 0));
          } 
          strips[i].show();
        }
      }
    }

  void clear() {
    for (int i=0; i<5; i++) {
      for (int led=0; led<strips[i].numPixels(); led++) {
        strips[i].setPixelColor(led, color(0,0,0));
      }
    }
  }

  void loop() {
    idx++;
    if (idx == modes[mode]) {
      idx = 0;
      mode++;

      if (mode == 8) mode = 0;
    }

    switch(mode) {
      case 0:
        colorWipe(idx, color(255, 0, 0));
        break;
      case 1:
        colorWipe(idx, color(0, 255, 0));
        break;
      case 2:
        colorWipe(idx, color(0, 0, 255));
        break;
      case 3:
      case 4:
      case 5:
        rainbowWarp(idx);
        break;
      case 6:
        blinkyBlinky(idx);
        break;
      case 7:
        sparklySparkly(idx);
        break;
    }
  }
}
