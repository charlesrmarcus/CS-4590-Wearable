import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//Global Variables
SamplePlayer sp, alert, ambient;
ControlP5 p5;
Button frequency, b1, b2, b3, b4, b5, b6;
Slider sl;
WavePlayer wp;

//Get Ambient Sounds
void getAmbientSound(String filepath) {
  ambient.pause(true);
  ambient = getSamplePlayer(filepath);
  ambient.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  ac.out.addInput(ambient);
  ambient.start();
}

//Get Alert Sounds
void getAlertSound(String filepath) {
  sp.pause(true);
  sp = getSamplePlayer(filepath);
  ac.out.addInput(sp);
  sp.start();
}

void setup() {
  size(320, 240);
  noStroke();
  
  //Instantiate Global Variables
  ac = new AudioContext();
  p5 = new ControlP5(this);
  
  //Create Buttons
  b1 = p5.addButton("Alert_1")
         .setSize(60, 35)
         .setPosition(25,75)
         ;
         
  b2 = p5.addButton("Alert_2")
         .setSize(60, 35)
         .setPosition(90,75)
         ;
         
  b3 = p5.addButton("Alert_3")
         .setSize(60, 35)
         .setPosition(155,75)
         ;
  
  b4 = p5.addButton("Ambient_1")
         .setSize(60, 35)
         .setPosition(25,30)
         ;
         
  b5 = p5.addButton("Ambient_2")
         .setSize(60, 35)
         .setPosition(90,30)
         ;
         
  b6 = p5.addButton("Ambient_3")
         .setSize(60, 35)
         .setPosition(155,30)
         ;
         
  frequency = p5.addButton("Play Frequency")
                .setPosition(75, 155)
                .setSize(90, 35)
                ;
  
  //Slider Setup
  sl = p5.addSlider("Frequency")
         .setPosition(65, 125)
         .setMin(220)
         .setMax(440)
         .setValue(440)
         ;
  
  wp = new WavePlayer(ac, 220.0f, Buffer.SINE);
  wp.pause(true);
  ac.out.addInput(wp);
         
  //Ambient and Alert Setup
  ambient = getSamplePlayer("piano2.wav");
  ambient.pause(true);
  sp = getSamplePlayer("piano2.wav");
  sp.pause(true);
         
  ac.start();
}

void draw() {
 background(0); 
 loadAmbientEngine();
 loadAlertEngine();
 loadSlider();
}

void controlEvent(ControlEvent e) {
  if (e.isFrom(frequency)) {
    wp.pause(!wp.isPaused());
  }
}

void loadAmbientEngine() {
  if (b4.isPressed() == true) {
     getAmbientSound("low_ambient.wav");
  } else if (b5.isPressed() == true) {
     getAmbientSound("mid_ambient.wav");
  } else if (b6.isPressed() == true) {
     getAmbientSound("high_ambient.wav"); 
  }
  
}
  

void loadAlertEngine() {
  if (b1.isPressed() == true) {
     getAlertSound("piano2.wav");
  } else if (b2.isPressed() == true) {
     getAlertSound("piano3.wav");
  } else if (b3.isPressed() == true) {
     getAlertSound("piano5.wav"); 
  }
}

void loadSlider() {
  float currentFreq = sl.getValue();
  wp.setFrequency(currentFreq);
}
