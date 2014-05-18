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

public class step4step01 extends PApplet {

/*
 * System Dynamics : Step by Step learning 
 * Simple Inventory Model.
 * 2014/5/18
 */

// for graph
float dataMin = 0, dataMax = 60000;
float plotMinX = 30, plotMinY = 30; // minmum point of graph area
float plotMaxX = 400, plotMaxY = 300; // maximum point of graph area
float plotX, plotY;

// for simulation
int maxtime = 50; // Month
int simtime = 0;  // Month
int dt = 1;       // Month, ticktime (simulation cycle)

float[] delivery = new float[maxtime]; // Products/Month. The number of products which company delivers to customers every month.
float[] supply   = new float[maxtime]; // Products/Month. The number of products which company buys from the supplier every month.

float[] inventory = new float[maxtime]; 

int i = 0;

public void setup(){
	size(640, 360);
	background(0);
	stroke(255);
	textSize(12);
	inventory[0] = 1000;
	drawInventory(0);
}

public void draw() {
	i++;
	simtime = simtime + dt;

	//simulate
	supply[i] = 1000;
	delivery[i] = 0;
	inventory[i] = inventory[i-1] + supply[i] - delivery[i];

	// graph
	drawInventory(i);

	// finalize
	if(simtime + dt >= maxtime){
		drawResult();
		noLoop();
	}
}

public void drawInventory(int simT){
	// console
	System.out.printf("%3d : %10.2f \n", i, inventory[simT]);
	// graph
	plotX = map(simT, 1, maxtime, plotMinX, plotMaxX);
	plotY = map(inventory[simT], dataMin, dataMax, plotMinY, plotMaxY);
	line(plotX, plotMaxY - plotMinY, plotX, plotMaxY - plotY);
}

public void drawResult(){
	text("max:", 450, 30);
	text(str(max(inventory)), 500, 30);
	text("min:", 450, 50);
	text(str(min(inventory)), 500, 50);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "step4step01" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
