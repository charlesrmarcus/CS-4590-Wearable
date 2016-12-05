import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//Global Variables
SamplePlayer sp, alert, ambient;
ControlP5 p5;
Button frequency, stop, b1, b2, b3, b4, b5, b6, w1, w2, w3;
Button start_tts, stop_tts, change_tts;
Slider sl;
WavePlayer wp, wp1, wp2, wp3;
TextToSpeechMaker ttsMaker;

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
  size(500, 240);
  noStroke();
  
  //Instantiate Global Variables
  ac = new AudioContext();
  p5 = new ControlP5(this);
  
  //Create Buttons
  b1 = p5.addButton("Alert")
         .setSize(60, 35)
         .setPosition(405,15)
         ;
         
  //b2 = p5.addButton("Alert_2")
  //       .setSize(60, 35)
  //       .setPosition(90,75)
  //       ;
         
  //b3 = p5.addButton("Alert_3")
  //       .setSize(60, 35)
  //       .setPosition(155,75)
  //       ;
  
  b4 = p5.addButton("Slow")
         .setSize(60, 35)
         .setPosition(25, 85)
         ;
         
  b5 = p5.addButton("Medium")
         .setSize(60, 35)
         .setPosition(95, 85)
         ;
         
  b6 = p5.addButton("Fast")
        .setSize(60, 35)
        .setPosition(165,85)
        ;

  w1 = p5.addButton("Frequency 1")
        .setSize(60,35)
        .setPosition(25, 140)
        ;
        
  w2 = p5.addButton("Frequency 2")
        .setSize(60,35)
        .setPosition(95, 140)
        ;

  w3 = p5.addButton("Frequency 3")
        .setSize(60,35)
        .setPosition(165, 140)
        ;
        
  //TTS Buttons
  start_tts = p5.addButton("Start_TTS")
                .setSize(60, 35)
                .setPosition(265, 85)
                ;
                
  change_tts = p5.addButton("Change_TTS")
                .setSize(60, 35)
                .setPosition(335, 85)
                ;
                
  stop_tts = p5.addButton("Stop_TTS")
                .setSize(60, 35)
                .setPosition(405, 85)
                ;
      
  //Slider & Frequency Setup
  frequency = p5.addButton("Play Frequency")
                .setPosition(125, 15)
                .setSize(90, 35)
                ;
                
  stop = p5.addButton("Stop")
                .setPosition(25, 15)
                .setSize(90, 35);
  
  sl = p5.addSlider("Frequency")
         .setPosition(225, 25)
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
  
  //Text To Speech Setup
  ttsMaker = new TextToSpeechMaker();
  
  wp1 = new WavePlayer(ac, 440.0, Buffer.SINE);
  wp1.pause(true);
  ac.out.addInput(wp1);
  
  wp2 = new WavePlayer(ac, 660.0, Buffer.SINE);
  wp2.pause(true);
  ac.out.addInput(wp2);
  
  wp3 = new WavePlayer(ac, 880.0, Buffer.SINE);
  wp3.pause(true);
  ac.out.addInput(wp3);
         
  ac.start();
}

void draw() {
  background(0); 
  loadAmbientEngine();
  loadAlertEngine();
  loadTTSEngine();
  loadSlider();
  loadStop();
}

void controlEvent(ControlEvent e) {
  if (e.isFrom(frequency)) {
    wp.pause(!wp.isPaused());
  } else if (e.isFrom(w1)) {
    wp1.pause(!wp1.isPaused());
  } else if (e.isFrom(w2)) {
    wp2.pause(!wp2.isPaused());
  } else if (e.isFrom(w3)) {
    wp3.pause(!wp3.isPaused());
  }
}

void loadAmbientEngine() {
  if (b4.isPressed() == true) {
     getAmbientSound("slow_tempo.wav");
  } else if (b5.isPressed() == true) {
     getAmbientSound("medium_tempo.wav");
  } else if (b6.isPressed() == true) {
     getAmbientSound("fast_tempo.wav"); 
  }
  
}
  
void loadAlertEngine() {
  if (b1.isPressed() == true) {
     getAlertSound("piano2.wav");
  }
}

void loadTTSEngine() {
  if (start_tts.isPressed() == true) {
     ttsPlayer("Start Exercise"); 
  } else if (change_tts.isPressed() == true) {
     ttsPlayer("Change Exercise"); 
  } else if (stop_tts.isPressed() == true) {
     ttsPlayer("Stop Exercise"); 
  }
}

void loadSlider() {
  float currentFreq = sl.getValue();
  wp.setFrequency(currentFreq);
}

void loadStop() {
 if (stop.isPressed() == true) {
   ambient.pause(true);
   sp.pause(true);
 }
}

void loadFrequencies() {
  if (w1.isPressed() == true) {
     wp1.pause(!wp1.isPaused());
  } else if (w2.isPressed() == true) {
     wp2.pause(!wp2.isPaused());
  } else if (w3.isPressed() == true) {
     wp3.pause(!wp3.isPaused());
  }
}

void ttsPlayer(String inputSpeech) {
  String ttsFilePath = ttsMaker.createTTSWavFile(inputSpeech);
  SamplePlayer sp = getSamplePlayer(ttsFilePath, true);
  
  ac.out.addInput(sp);
  sp.setToLoopStart();
  sp.start();
}
