import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class dosage01 extends PApplet {

// for graph
float dataMin = 0, dataMax = 300;
float plotMinX =  30, plotMinY =  30; //minimum point of graph area 
float plotMaxX = 500, plotMaxY = 300; //maximum point of graph area
float plotX, plotY;

// for simulation
float halflife = 3.2f;	// hr
int plasmaVolume = 3000;	// ml
float eliminationConstant = -1 * log(0.5f) / halflife; // 1/hr

float[] aspirinInPlasma = new float[100];
float[]	plasmaConscentration = new float[100];

int simulationHours = 8;
float dX = 5.0f / 60;

float simtime = 0;
int i = 0;

public void setup(){
	size(640, 360);
	background(0);
	stroke(255);
	aspirinInPlasma[0] = 2 * 325 * 1000;	// ug
}

public void draw() {
	//background(0);
	i++;
	simtime = simtime + dX;
	float elimination = (eliminationConstant * aspirinInPlasma[i-1]) * dX;
	aspirinInPlasma[i] = aspirinInPlasma[i-1] - elimination;
	plasmaConscentration[i] = aspirinInPlasma[i] / plasmaVolume;
	//
	println(simtime);
	println(aspirinInPlasma[i]);
	delay(100);
	//
	plotX = map(simtime, 0, simulationHours, plotMinX, plotMaxX);
	plotY = map(plasmaConscentration[i], 0, 300, plotMinY, plotMaxY);
	line(plotX, plotMaxY - plotMinY, plotX, plotMaxY - plotY);
	//
	if(simtime > simulationHours)noLoop();
}

public void mousePressed(){
	noLoop();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "dosage01" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
