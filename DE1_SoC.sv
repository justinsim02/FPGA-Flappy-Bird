module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_1);
	input logic 				CLOCK_50;
	output logic 	[6:0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic	[9:0] 	LEDR;
	input logic 	[3:0]	 	KEY; // True when not pressed, False when pressed
	input logic 	[9:0] 	SW;
	output logic 	[35:0] 	GPIO_1;
	
	
	logic [15:0] pattern;
	logic key, dead;
	logic [31:0] 	div_clk;
	logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
   logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	logic RST, RST2;              
	logic clk,clk2;
	logic fall;

	assign RST = SW[0];
	
	
	//Counter
	count grav(.clk(clk2), .reset(RST),.enable(fall));
	
	//---------------------------------------------------------------------
	// for Tube Clock
	logic hm;
	parameter whichClock = 23;
	
	clock_divider cdiv (.clock(CLOCK_50),
								.reset(RST),
								.divided_clocks(div_clk));
	
	assign clk = CLOCK_50; // for simulation 
//	assign clk = div_clk[whichClock]; // for board
	
//	//For Bird Clock Controls

	parameter whichClock2 = 12;
	logic [31:0] div_clk2;
	clock_divider cdiv2 (.clock(CLOCK_50),
								.reset(RST),
								.divided_clocks(div_clk2));
	
	assign clk2 = CLOCK_50; // for simulation 
//	assign clk2 = div_clk2[whichClock2]; // for board

//	
//	//for LED board clock
	logic [31:0] CLK;
	logic SYSTEM_CLOCK;
	 
	clock_divider_LED_Driver divider (.clock(CLOCK_50), .divided_clocks(CLK));
	 
	assign SYSTEM_CLOCK = CLK[14]; // 1526 Hz clock signal	 
	  
	 //-----------------------------------------------------------------------
		
	//controls user input, ensures that input only stays true for one clock cycle
	userIn in (.clk(clk2),.in(~KEY[0]),.out(key));
	userIn in2 (.clk(clk2),.in(~KEY[3]),.out(key3));
	
	// Initiates LED Board
	LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	
	logic [15:0] lineTest2;
	assign lineTest2 = {
					RedPixels[11][0],
					RedPixels[11][1],
					RedPixels[11][2],
					RedPixels[11][3],
					RedPixels[11][4],
					RedPixels[11][5],
					RedPixels[11][6],
					RedPixels[11][7],
					RedPixels[11][8],
					RedPixels[11][9],
					RedPixels[11][10],
					RedPixels[11][11],
					RedPixels[11][12],
					RedPixels[11][13],
					RedPixels[11][14],
					RedPixels[11][15]};
//	// Control Bird Flight in y-directon based on KEY[3]
	birdOn bird1 (.clk(clk2), .RST, .key, .topLight(1'b0),.botLight(RedPixels[11][14]), .light(RedPixels[11][15]), .fall);	//Reset brings bird to top
	birdOn bird2 (.clk(clk2), .RST, .key, .topLight(RedPixels[11][15]), .botLight(RedPixels[11][13]), .light(RedPixels[11][14]),.fall, .dead);
	birdOn bird3 (.clk(clk2), .RST, .key, .topLight(RedPixels[11][14]), .botLight(RedPixels[11][12]), .light(RedPixels[11][13]),.fall, .dead);
	birdOn bird4 (.clk(clk2), .RST, .key, .topLight(RedPixels[11][13]), .botLight(RedPixels[11][11]), .light(RedPixels[11][12]),.fall, .dead);
	birdOn bird5 (.clk(clk2), .RST, .key, .topLight(RedPixels[11][12]), .botLight(RedPixels[11][10]), .light(RedPixels[11][11]),.fall, .dead);
	birdOn bird6 (.clk(clk2), .RST, .key, .topLight(RedPixels[11][11]), .botLight(RedPixels[11][9]), .light(RedPixels[11][10]),.fall, .dead);
	birdOnTop bird7  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][10]), .botLight(RedPixels[11][8]), .light(RedPixels[11][9]), .fall, .dead);
	birdOn bird8  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][9]),  .botLight(RedPixels[11][7]), .light(RedPixels[11][8]),.fall, .dead);
	birdOn bird9  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][8]),  .botLight(RedPixels[11][6]), .light(RedPixels[11][7]),.fall, .dead);
	birdOn bird10  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][7]),  .botLight(RedPixels[11][5]), .light(RedPixels[11][6]),.fall, .dead);
	birdOn bird11  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][6]),  .botLight(RedPixels[11][4]), .light(RedPixels[11][5]),.fall, .dead);
	birdOn bird12  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][5]),  .botLight(RedPixels[11][3]), .light(RedPixels[11][4]),.fall, .dead);
	birdOn bird13  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][4]),  .botLight(RedPixels[11][2]), .light(RedPixels[11][3]),.fall, .dead);
	birdOn bird14  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][3]),  .botLight(RedPixels[11][1]), .light(RedPixels[11][2]),.fall, .dead);
	birdOn bird15  (.clk(clk2), .RST, .key, .topLight(RedPixels[11][2]),  .botLight(RedPixels[11][0]), .light(RedPixels[11][1]),.fall, .dead); 
	birdOn bird0 (.clk(clk2), .RST, .key, .topLight(RedPixels[11][1]),.botLight(1'b0),					.light(RedPixels[11][0]),.fall, .dead);
//	
//	
	// Chooses a Pattern for the obstacles
	// Moves the tube pattern in x direction 
	
	logic [15:0] lineTest;
	assign lineTest = {
					GrnPixels[0][0],
					GrnPixels[1][0],
					GrnPixels[2][0],
					GrnPixels[3][0],
					GrnPixels[4][0],
					GrnPixels[5][0],
					GrnPixels[6][0],
					GrnPixels[7][0],
					GrnPixels[8][0],
					GrnPixels[9][0],
					GrnPixels[10][0],
					GrnPixels[11][0],
					GrnPixels[12][0],
					GrnPixels[13][0],
					GrnPixels[14][0],
					GrnPixels[15][0]};
	
	//initialzie tube design
	tubePick init_tube 	(.clk,.RST,.pattern,.dead);
	//first tube column, starts cycle
	tubeFirst tube1		(.clk,.pattern,.light_o(GrnPixels[0]),.lineTest, .SW1(SW[9]),.SW2(SW[8]));
	tubeMove tube2 (.clk(clk), .RST, .col_R(GrnPixels[0]), .light_o(GrnPixels[1]), .dead);
	tubeMove tube3 (.clk(clk), .RST, .col_R(GrnPixels[1]), .light_o(GrnPixels[2]), .dead);
	tubeMove tube4 (.clk(clk), .RST, .col_R(GrnPixels[2]), .light_o(GrnPixels[3]), .dead);
	tubeMove tube5 (.clk(clk), .RST, .col_R(GrnPixels[3]), .light_o(GrnPixels[4]), .dead);
	tubeMove tube6 (.clk(clk), .RST, .col_R(GrnPixels[4]), .light_o(GrnPixels[5]), .dead);
	tubeMove tube7 (.clk(clk), .RST, .col_R(GrnPixels[5]), .light_o(GrnPixels[6]), .dead);
	tubeMove tube8 (.clk(clk), .RST, .col_R(GrnPixels[6]), .light_o(GrnPixels[7]), .dead);
	tubeMove tube9 (.clk(clk), .RST, .col_R(GrnPixels[7]), .light_o(GrnPixels[8]), .dead);
	tubeMove tube10(.clk(clk), .RST, .col_R(GrnPixels[8]), .light_o(GrnPixels[9]), .dead);
	tubeMove tube11(.clk(clk), .RST, .col_R(GrnPixels[9]), .light_o(GrnPixels[10]), .dead);
	tubeMove tube12(.clk(clk), .RST, .col_R(GrnPixels[10]), .light_o(GrnPixels[11]), .dead);
	tubeMove tube13(.clk(clk), .RST, .col_R(GrnPixels[11]), .light_o(GrnPixels[12]), .dead);
	tubeMove tube14(.clk(clk), .RST, .col_R(GrnPixels[12]), .light_o(GrnPixels[13]), .dead);
	tubeMove tube15(.clk(clk), .RST, .col_R(GrnPixels[13]), .light_o(GrnPixels[14]), .dead);
	tubeMove tube16(.clk(clk), .RST, .col_R(GrnPixels[14]), .light_o(GrnPixels[15]), .dead);
																			
	death bed (.RedPixels,.GrnPixels, .dead);
	
endmodule 

//////-------------------------------------------------------------------------------------------------
module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [35:0] GPIO_1;
	logic [15:0] pattern;
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .GPIO_1);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;//toggle the clock indefinitely
	end 
	
	// Test the design.
	initial begin
		KEY[0] <= 1;		

		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(5)@(posedge CLOCK_50);
		KEY[0] <= 0;repeat(2)@(posedge CLOCK_50);
		SW[0] <= 0; repeat(5)@(posedge CLOCK_50);

	$stop;
	end 
endmodule 

