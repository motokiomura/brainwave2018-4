import oscP5.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
PrintWriter file;

final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

boolean flag = false;

void setup() {
  file = createWriter("test.csv");
  minim = new Minim(this);
  player = minim.loadFile("../sample.mp3");
  
  player.play();
  flag = true;
  
  delay(10000); // play music for 10 sec
  
  player.close();
  flag = false;
  
  file.flush();
  file.close();
}

void draw() {
}

void stop(){
  minim.stop();
  super.stop();
}

void oscEvent(OscMessage msg) {
  if (flag == true && msg.checkAddrPattern("/muse/elements/alpha_relative")) {
    float alpha_value_sum = 0;
    for (int i = 0; i < 4; i++) {
      alpha_value_sum += msg.get(i).floatValue();
    }
    file.print(alpha_value_sum);
    file.print("\n");
  }
}
