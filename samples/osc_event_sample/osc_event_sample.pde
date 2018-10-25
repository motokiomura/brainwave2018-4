import oscP5.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
PrintWriter file;

final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

boolean flag = false;

void setup() {
  file = createWriter(args[0] + ".csv");
  minim = new Minim(this);
  String[] musics = {"fantastic_baby", "rock_ballad_of_singer", "senbonzakura"};
  int[] start_times = {35200, 86000, 57300};
  
  for (int i = 0; i < musics.length; i++) {
    custom_play(musics[i], start_times[i]);
  }
  
  file.flush();
  file.close();
  
  exit();
}

void custom_play(String file_name, int start_time) {
  player = minim.loadFile("../../music/" + file_name + ".mp3");
  player.play(start_time);
  flag = true;
  
  delay(10000); // play music for 10 sec
  
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
  boolean[] is_good = {false, false, false, false};
  
  if (msg.checkAddrPattern("/muse/elements/is_good")) {
    for (int i = 0; i < 4; i++) {
      if (msg.get(i).intValue() == 1) {
        is_good[i] = true;
      }
    }
  }
  
  if (flag == true && msg.checkAddrPattern("/muse/elements/alpha_relative")) {
    float alpha_value_sum = 0;
    int count = 0;
    
    for (int i = 0; i < 4; i++) {
      if (is_good[i] == true) {
        alpha_value_sum += msg.get(i).floatValue();
        count++;
      }
    }
    
    if (count > 0) alpha_value_sum/= count;
    
    file.print(alpha_value_sum);
    file.print("\n");
  }
}
