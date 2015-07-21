// Keep this as close to Arduino code as possible, the point
// is to copy/paste it into the final sketch.

class Arduino {

//  #include <LPD8806.h>                              // C

  int n_strips = 5;
  LPD8806 head;
  LPD8806 leftFrontLeg;
  LPD8806 leftBackLeg;
  LPD8806 rightFrontLeg;
  LPD8806 rightBackLeg;
//  LPD8806 strips[5];                                // C                        
  LPD8806[] strips = new LPD8806[5];                  // Java

  // Offsets for the front-most LED
  //int offsets[] = {                                 // C
  int offsets[] = new int[] {                         // Java
    0,30,10,70,50
  };

  int mode = 0;
  int idx = 0;
  int n_modes = 12;
//  int modes[n_modes];                               // C
  int modes[] = new int[n_modes];                     // Java
//  uint32_t currentColor;                            // C
  color currentColor;                                 // Java

  int n_colors = 4;
//  byte colors[] = {                                 // C
  int colors[] = new int[] {                          // Java 
    214,37,152,  // Pink
    64,224,208,  // Turquoise
    0,35,102,    // Royal Blue
    239,51,64    // Red
  };
  
//  uint32_t color(byte r, byte g, byte b) {          // C
//    return ((uint32_t)(g | 0x80) << 16) |           // C
//           ((uint32_t)(r | 0x80) <<  8) |           // C
//                       b | 0x80 ;                   // C
//  }                                                 // C     
//                                                    // C
//  byte red(uint32_t color) {                        // C
//    return (byte)(color & 0x7F00) >> 8;             // C
//  }                                                 // C
//                                                    // C
//  byte green(uint32_t color) {                      // C
//    return (byte)(color & 0x7F0000)>>16;            // C
//  }                                                 // C
//                                                    // C
//  byte blue(uint32_t color) {                       // C
//    return (byte)(color & 0x7F);                    // C
//  }                                                 // C

  void setup() {    
//    strips[0] = head = LPD8806(100);                // C
//    strips[1] = leftFrontLeg = LPD8806(80);         // C
//    strips[2] = leftBackLeg = LPD8806(80);          // C
//    strips[3] = rightBackLeg = LPD8806(80);         // C
//    strips[4] = rightFrontLeg = LPD8806(80);        // C
    strips[0] = head = new LPD8806(100);              // Java
    strips[1] = leftFrontLeg = new LPD8806(80);       // Java
    strips[2] = leftBackLeg = new LPD8806(80);        // Java
    strips[3] = rightBackLeg = new LPD8806(80);       // Java
    strips[4] = rightFrontLeg = new LPD8806(80);      // Java

    for (int i=0; i<n_modes; i++) {
      modes[i] = 300;
    }
  }

// uint32_t stepColor(byte r, byte g, byte b, int step, float divisor) {   // C
  color stepColor(int r, int g, int b, int step, float divisor) {          // Java
    r = int(min(255,step/divisor*r));
    g = int(min(255,step/divisor*g));
    b = int(min(255,step/divisor*b));

    return color(r,g,b);
  }
  
  int bound(int n, int max) {
    while (n >= max) n -= max;
    while (n < 0) n += max;
    return n;
  }
  
  void gallop(int idx) {
    int tailsize = 10;
    int x;
    int step;
    int len;
    int hlen;
    
    clear();
    
    for (int i=0; i<n_strips; i++) {
      len = strips[i].numPixels();
      hlen = ((tailsize+len)/2);
      step = (i%2!=0 ? idx % hlen : (idx+150) % hlen) - tailsize; 
      
      for (int j=0; j<tailsize && step+j<len/2; j++) {
        x = bound(offsets[i]+step+j, len); 
        strips[i].setPixelColor(x,stepColor(255,255,255,j,8.0));
        
        x = bound(offsets[i]-step-j, len);
        strips[i].setPixelColor(x,stepColor(255,255,255,j,8.0));
      }
      
      strips[i].show();
    }
  }
  
  void colorBleed(int idx, int r, int g, int b, float div) {
    int x;
    
    for (int i=0; i<n_strips; i++) {
      x = strips[i].numPixels()/2;
      
      strips[i].setPixelColor(x,stepColor(r,g,b,idx,div));
      
      for (int j=1; j<idx; j++) {
        if (x+j<strips[i].numPixels())
          strips[i].setPixelColor(x+j, stepColor(r,g,b,idx-j,div));
        
        if (x-j>=0)
          strips[i].setPixelColor(x-j, stepColor(r,g,b,idx-j,div));
      }
      
      strips[i].show();
    }
  }
  
//  void colorWipe(int idx, uint32_t col) {            // C
  void colorWipe(int idx, color col) {                 // Java
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
    for (int i=0; i<n_strips; i++) {
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

      if (mode == n_modes) mode = 0;
    }

    switch(mode) {
      case 0:
        gallop(idx);
        break;
      case 1:
        exit();
      case 2:
      case 3:
        colorBleed(idx, colors[mode*3], colors[mode*3+1], colors[mode*3+2], modes[mode] / 4.0);
        break;
      case 4:
      case 5:
      case 6:
      case 7:
        colorWipe(idx, color(colors[(mode-4)*3], colors[(mode-4)*3+1], colors[(mode-4)*3+2]));
        break;
      case 8:
      case 9:
      case 10:
        rainbowWarp(idx);
        break;
      case 11:
        sparklySparkly(idx);
        break;
    }
  }
}
