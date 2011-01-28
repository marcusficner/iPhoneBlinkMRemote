//
// Created by Marcus Ficner on 28.01.2011
//
// www.marcusficner.de
// @marcusficner
//

import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 oscP5;

float redValue;
float greenValue;
float blueValue;

void setup() {
  size(320, 480);
  oscP5 = new OscP5(this, 8000);    // OscP5(Object theParent, int theReceiveAtPort) 
}


void oscEvent(OscMessage theOscMessage) {
 
  String addr = theOscMessage.addrPattern();
  OscArgument arg = theOscMessage.get(0);
 
  if(addr.equals("/1/fader1")) {
     redValue = arg.floatValue();
  } 
 
  if(addr.equals("/1/fader2")) {
     greenValue = arg.floatValue();
  }
 
  if(addr.equals("/1/fader3")) {
     blueValue = arg.floatValue();
  } 
 
}

void draw() {
 fill(redValue, greenValue, blueValue);
 ellipse(200,200,200,200);
}

