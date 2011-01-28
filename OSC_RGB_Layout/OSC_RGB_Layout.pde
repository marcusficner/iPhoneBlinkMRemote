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
String output;

void setup() {
  size(320, 480);
  oscP5 = new OscP5(this, 8000);    // OscP5(Object theParent, int theReceiveAtPort) 
}


void oscEvent(OscMessage theOscMessage) {
 String addr = theOscMessage.addrPattern();
 output = addr;
 
}

void draw() {
  println(output);
}

