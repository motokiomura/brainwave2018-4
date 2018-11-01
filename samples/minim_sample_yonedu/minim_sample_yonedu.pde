import ddf.minim.*;
 
Minim minim;
AudioPlayer player;
 
void setup(){
  minim = new Minim(this);
  player = minim.loadFile("./edm.mp3");
  while (true) {
    play();
  }
}

void draw() {
}

void play() {
  player.play(106000);
  delay(10000);
}
 
void stop(){
  player.close();
  minim.stop();
  super.stop();
}
