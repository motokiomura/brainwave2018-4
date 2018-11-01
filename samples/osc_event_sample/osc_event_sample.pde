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
  int[] play_time = {12800, 13200, 12500};
  
  for (int i = 0; i < musics.length; i++) {
    custom_play(musics[i], start_times[i], play_time[i]);
  }
  
  file.flush();
  file.close();
  
  exit();
}

void custom_play(String file_name, int start_time,int play_time) {
  player = minim.loadFile("../../music/" + file_name + ".mp3");
  player.play(start_time);
  flag = true;
  
  delay(play_time); // play music for 10 sec
  
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
    float alpha_value_sum = 0;
    int count = 0;
    
    for (int i = 0; i < 4; i++) {
      if (!(Double.isNaN(msg.get(i).floatValue()))) {
        alpha_value_sum += msg.get(i).floatValue();
        count++;
        print(msg.get(i).floatValue());
      }
    }
    
    if (count > 0) alpha_value_sum/= count;
    
    file.print(alpha_value_sum);
    file.print("\n");
  }
}
