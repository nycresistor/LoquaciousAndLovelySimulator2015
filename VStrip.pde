public class VStrip {
  PShape path;
  LPD8806 strip;
  int xOffset;
  int yOffset;
  
  public VStrip(PShape path, LPD8806 strip, int xOffset, int yOffset) {
    this.path = path;
    this.strip = strip;
    
    int size = this.path.getVertexCount();
    this.xOffset = xOffset;
    this.yOffset = yOffset;
  }
    
  public void draw() {
    PVector v;
    ellipseMode(CENTER);
    for (int i=0; i<strip.led_array.length; i++) {
      v = path.getVertex(i);
      fill(strip.led_array[i]);
      noStroke();
      ellipse(v.x+xOffset, v.y+yOffset,3,3);
    }
  }
}
  
  
