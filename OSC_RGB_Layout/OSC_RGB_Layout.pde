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

String portName = null;
int portSpeed = 19200;
Serial port;

byte blinkMAddr = 0x09;

float redValue;
float greenValue;
float blueValue;

void setup() {
  size(300, 300);
  background(0);
  oscP5 = new OscP5(this, 8000);    // OscP5(Object theParent, int theReceiveAtPort) 
  
  if(portName == null) {
    portName = (Serial.list())[0];
  }
  
  port = new Serial(this, portName, portSpeed);
  
  if(port.output == null) {
    println("ERROR: Could not open serial port: "+portName);
    exit();
  }  
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

public synchronized void sendCommand( byte addr, byte[] cmd ) {
    println("sendCommand: "+(char)cmd[0]);
    byte cmdfull[] = new byte[4+cmd.length];
    cmdfull[0] = 0x01;                    // sync byte
    cmdfull[1] = addr;                    // i2c addr
    cmdfull[2] = (byte)cmd.length;        // this many bytes to send
    cmdfull[3] = 0x00;                    // this many bytes to receive
    for( int i=0; i<cmd.length; i++) {    // and actual command
        cmdfull[4+i] = cmd[i];
    }
    port.write(cmdfull);
}
// a common task, fade to an rgb color
public void fadeToColor( float r, float g, float b ) {
    byte[] cmd = {'c', (byte)r, (byte)g, (byte)b};
    sendCommand( blinkMAddr, cmd );
}

void draw() {
 // update Processing sketch
 fill(redValue, greenValue, blueValue);
 ellipse(150,200,200,200);
 
 // send message to BlinkM
 fadeToColor(redValue, greenValue, blueValue);
}

