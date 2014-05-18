// for graph
float dataMin = 0, dataMax = 300;
float plotMinX =  30, plotMinY =  30; //minimum point of graph area 
float plotMaxX = 500, plotMaxY = 300; //maximum point of graph area
float plotX, plotY;

// for simulation
float halflife = 3.2;	// hr
int plasmaVolume = 3000;	// ml
float eliminationConstant = -1 * log(0.5) / halflife; // 1/hr

float[] aspirinInPlasma = new float[100];
float[]	plasmaConscentration = new float[100];

int simulationHours = 8;
float dX = 5.0 / 60;

float simtime = 0;
int i = 0;

void setup(){
	size(640, 360);
	background(0);
	stroke(255);
	aspirinInPlasma[0] = 2 * 325 * 1000;	// ug
}

void draw() {
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

void mousePressed(){
	noLoop();
}
