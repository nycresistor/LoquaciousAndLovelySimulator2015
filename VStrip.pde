public class VStrip {
  PShape path;
  color[] state;
  int size;
  
  public VStrip(PShape path) {
    this.path = path;
    
    this.size = this.path.getVertexCount();
    this.state = new color[size];
  }
  
  public int numPixels() {
  
    return this.size;
  }
  
  public void setPixelColor(int idx, color c) {
    state[idx] = c;
  }
  
  public void setPixelColor(int idx, int r, int g, int b) {
    state[idx] = color(r,g,b);
  }
  
  public int count() {
    return state.length;
  }
  
  public void show() {
    PVector v;
    ellipseMode(CENTER);
    for (int i=0; i<state.length; i++) {
      v = path.getVertex(i);
      fill(state[i]);
      ellipse(v.x+offset_x, v.y+offset_y,3,3);
    }
  }
}
  
  
