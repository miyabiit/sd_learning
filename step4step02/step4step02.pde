/*
	Sytem Dynamics : Step by Step learning
	2014/5/24

	*/

// for screen
int width = 640;
int height = 360;

// for graph
float dataMin = 0, dataMax = 1000;
float plotMinX = 30, plotMinY = 30; // minmum point of graph area
float plotMaxX = 400, plotMaxY = 300; // maximum point of graph area
float plotX, plotY;
float plotX0, plotY0;
float plotX1, plotY1;

// for simuration
int maxtime = 50; // Month
int simtime = 0;  // Month
int dt = 1;       // Month, ticktime (simulation cycle)

// constant
// The number of product management would always want to have in warehouse.
float desired_inventory = 1000; // Products

// The effect of the inventory status on delivery 
// depends on ratio of inventory/desired inventory.
float effect_of_inventory_ratio = 1.0; // dmnl

// The ratio of current to desired company inventory.
float inventory_ratio = 1.0; // dmnl (without dimension)

// flow
// The number of products which company delivers to customers every month.
float[] delivery = new float[maxtime]; // Products/Month. 
// The number of products which company buys from the supplier every month.
float[] supply = new float[maxtime]; // Products/Month. 
// Demand for the company's product.
float[] demand = new float[maxtime]; // Products/Month. 
// Inventory
float[] inventory = new float[maxtime]; // Products 

int i = 0;

void setup(){
	size(width, height);
	background(0);
	stroke(255);
	textSize(12);

	inventory[0] = 1000;

	drawGraphInitialize();
	drawInventory(0);
}

void draw(){
	i++;
	simtime = simtime + dt;

	// simulate
	supply[i] = 1000;
	demand[i] = 1100;

	inventory_ratio = inventoryRatio(inventory[i-1],desired_inventory); 
	effect_of_inventory_ratio = effectOfInventoryRatio(inventory_ratio);

	// The number of products that the company can deliver to its customers every month.
	delivery[i] = effect_of_inventory_ratio * demand[i]; // Products/Month

	inventory[i] = inventory[i-1] + supply[i] - delivery[i];

	// graph
	drawInventory(i);

	// finalize
	if(simtime + dt >= maxtime){
		drawResult();
		noLoop();
	}
}

// Inventory Raitio function
float inventoryRatio(float inventory, float desired){ 
	float ratio = 0;
	if(inventory <= 0) return 0;
	ratio = inventory / desired;
	return ratio;
}

// Non-linear function of the inventory state effect of company's product delivery.
float effectOfInventoryRatio(float val){
	float result = 1.0;
	float[] vx = { 0, 0.05,  0.1, 0.15, 0.2, 0.25, 0.3, 1 };
	float[] vy = { 0,  0.3, 0.55, 0.75, 0.9, 0.97,   1, 1 };
	if(val < vx[0]) return vy[0];
	if(val > vx[7]) return vy[7];
	for(int i = 0; i < 7; i++){
		if(vx[i] <= val && val < vx[i+1]){
			result = vy[i] + ((vy[i+1] - vy[i]) / (vx[i+1] - vx[i]) * (val - vx[i]));
			return result;
		}
	}
	return result;
}

void drawGraphInitialize(){
	// console
	System.out.print("Time  Inventory InvOfRatio    Effect_\n");
	//   0    1000.00       1.00       1.00
}

void drawInventory(int simT){
	// console
	System.out.printf("%4d ", i, simT);
	System.out.printf("%10.2f ", inventory[simT]);
	System.out.printf("%10.2f ", inventory_ratio);
	System.out.printf("%10.2f \n", effect_of_inventory_ratio);
	// bar graph
	/* 
	plotX = map(simT, 1, maxtime, plotMinX, plotMaxX);
	plotY = map(inventory[simT], dataMin, dataMax, plotMinY, plotMaxY);
	line(plotX, plotMaxY - plotMinY, plotX, plotMaxY - plotY);
	*/
	// plot
	if(simT - 1 >= 0){
		plotX0 = map(simT-1, 1, maxtime, plotMinX, plotMaxX);
		plotY0 = map(inventory[simT-1], dataMin, dataMax, plotMinY, plotMaxY);
		plotX1 = map(simT, 1, maxtime, plotMinX, plotMaxX);
		plotY1 = map(inventory[simT], dataMin, dataMax, plotMinY, plotMaxY);
		line(plotX0, plotMaxY - plotY0, plotX1, plotMaxY - plotY1);
	}
}

void drawResult(){
	text("max:", 450, 30);
	text(str(max(inventory)), 500, 30);
	text("min:", 450, 50);
	text(str(min(inventory)), 500, 50);
}
