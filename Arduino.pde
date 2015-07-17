// Keep this as close to Arduino code as possible, the point
// is to copy/paste it into the final sketch.

class Arduino {
  //#define color uint32_t
  
  LPD8806 head;
  LPD8806 leftFrontLeg;
  LPD8806 leftBackLeg;
  LPD8806 rightFrontLeg;
  LPD8806 rightBackLeg;
  LPD8806[] all = new LPD8806[5];
  
  long frame;
  color col;
  
  public void setup() {
    all[0] = head = new LPD8806(100);
    all[1] = leftFrontLeg = new LPD8806(80);
    all[2] = leftBackLeg = new LPD8806(80);
    all[3] = rightFrontLeg = new LPD8806(80);
    all[4] = rightBackLeg = new LPD8806(80);
   
    frame = 0;
    col = head.Color(int(random(255)),int(random(255)),int(random(255)));  
  }
  
  public void loop() {
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
}

