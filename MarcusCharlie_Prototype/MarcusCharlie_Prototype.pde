import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//Global Variables
SamplePlayer sp, alert, ambient, met;
ControlP5 p5;
Button frequency, stop, b1, b2, b3, b4, b5, b6, w1, w2, w3;
Button start_tts, stop_tts, change_tts;
Slider sl;
WavePlayer wp, wp1, wp2, wp3;
TextToSpeechMaker ttsMaker;
Clock clock1, clock2, clock3;

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
  
  met = getSamplePlayer("met.wav");
  met.pause(true);
  ac.out.addInput(met);
  
  clock1 = new Clock(ac, 430f);
  clock1.addMessageListener(new Bead() {
        public void messageReceived(Bead message) {
          if(clock1.isBeat()) {
            met.reset();
            met.pause(false);
          }
        }
      });
   clock1.pause(true);
   ac.out.addDependent(clock1);
   
  clock2 = new Clock(ac, 316f);
  clock2.addMessageListener(new Bead() {
        public void messageReceived(Bead message) {
          if(clock2.isBeat()) {
            met.reset();
            met.pause(false);
          }
        }
      });
   clock2.pause(true);
   ac.out.addDependent(clock2);
   
  clock3 = new Clock(ac, 250f);
  clock3.addMessageListener(new Bead() {
        public void messageReceived(Bead message) {
          if(clock3.isBeat()) {
            met.reset();
            met.pause(false);
          }
        }
      });
   clock3.pause(true);
   ac.out.addDependent(clock3);
    
  
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
  loadTTSEngine();
  loadSlider();
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
  } else if (e.isFrom(b4)) {
    clock1.pause(!clock1.isPaused());
  } else if (e.isFrom(b5)) {
    clock2.pause(!clock2.isPaused());
  } else if (e.isFrom(b6)) {
    clock3.pause(!clock3.isPaused());
  } else if (e.isFrom(b1)) {
    getAlertSound("piano2.wav");
  } else if (e.isFrom(stop)) {
    ambient.pause(true);
    sp.pause(true);
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

void ttsPlayer(String inputSpeech) {
  String ttsFilePath = ttsMaker.createTTSWavFile(inputSpeech);
  SamplePlayer sp = getSamplePlayer(ttsFilePath, true);
  
  ac.out.addInput(sp);
  sp.setToLoopStart();
  sp.start();
}
