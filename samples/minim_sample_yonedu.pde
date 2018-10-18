import ddf.minim.*;
 
Minim minim;
AudioPlayer player;
 
void setup(){
  minim = new Minim(this);
  player = minim.loadFile("./sample.mp3");
  while (true) {
    play();
  }
}

void draw() {
}

void play() {
  player.play(60300);
  delay(6000);
}
 
void stop(){
  player.close();
  minim.stop();
  super.stop();
}
