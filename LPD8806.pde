
class LPD8806 {
  int num_leds;
  color led_array[];
  int currentLed;

  LPD8806(int numLeds) {
    num_leds = numLeds;
    led_array = new color[num_leds];
    currentLed = 0;
  }

  color Color(int red, int green, int blue) {
    return color(red, green, blue);
  } 

  void setPixelColor(int led, color col) {
    led_array[led] = col;
  }

  color getPixelColor(int led) {
    return led_array[led];
  }
  
  int numPixels() {
    return num_leds;
  }

  void show() {    
  }
  
  void begin() {
  }
}

