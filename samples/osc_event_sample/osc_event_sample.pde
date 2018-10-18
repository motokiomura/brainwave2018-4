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
  player = minim.loadFile("./sample.mp3");
  player.play();
  flag = true;
  delay(10000);
  
  player.close();
  flag = false;
}

void draw() {
}

void stop(){
  minim.stop();
  super.stop();
}

void oscEvent(OscMessage msg) {
  if (flag == true && msg.checkAddrPattern("/muse/elements/alpha_relative")) {
    float avarage_alpha = 0;
    for (int i = 0; i < 4; i++) {
      avarage_alpha += msg.get(i).floatValue();
    }
    fila.print(avarage_alpha);
  }
}
