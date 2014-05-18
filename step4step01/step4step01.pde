// for graph
float dataMin = 0, dataMax = 60000;
float plotMinX = 30, plotMinY = 30; // minmum point of graph area
float plotMaxX = 500, plotMaxY = 300; // maximum point of graph area
float plotX, plotY;

// for simulation
float[] delivery = new float[100]; // Products/Month. The number of products which company delivers to customers every month.
float[] supply   = new float[100]; // Products/Month. The number of products which company buys from the supplier every month.

float[] inventory = new float[100]; 

float simtime = 0;
float maxtime = 50;
float dt = 1;
int i = 0;

void setup(){
	size(640, 360);
	background(0);
	stroke(255);
}

void draw() {
	i++;
	simtime = simtime + dt;
	supply[i] = 1000;
	delivery[i] = 0;
	inventory[i] = inventory[i-1] + supply[i] - delivery[i];
	// print
	System.out.printf("%3.0f : %10.2f \n", simtime, inventory[i]);
	// graph
	plotX = map(simtime, 1, maxtime, plotMinX, plotMaxX);
	plotY = map(inventory[i], dataMin, dataMax, plotMinY, plotMaxY);
	line(plotX, plotMaxY - plotMinY, plotX, plotMaxY - plotY);
	//
	if(simtime > maxtime)noLoop();
}
