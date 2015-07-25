public class VStrip {
  PShape path;
  LPD8806 strip;
  int xOffset;
  int yOffset;
  
  public VStrip(PShape path, LPD8806 strip, int xOffset, int yOffset) {
    this.path = path;
    this.strip = strip;
    this.xOffset = xOffset;
    this.yOffset = yOffset;
  }
    
  public void draw() {
    PVector v;
    ellipseMode(CENTER);
    for (int i=0; i<strip.led_array.length; i++) {
      v = path.getVertex(i);
      fill(red(strip.led_array[i])*2,green(strip.led_array[i])*2,blue(strip.led_array[i])*2);
      noStroke();
      ellipse(v.x+xOffset, v.y+yOffset,3,3);
    }
  }
}
  
  
