//Randomly Selects a Tube pattern out of 16 options
module tubePick (clk, RST, pattern, dead);
	input logic clk, RST, dead;
	output logic [15:0] pattern;
	logic [15:0] init;

	logic [15:0][15:0] choice;
	assign choice[0][15:0] = 16'b0001111111111111;
	assign choice[1][15:0] = 16'b1000111111111111;
	assign choice[2][15:0] = 16'b1100011111111111;
	assign choice[3][15:0] = 16'b1110001111111111;
	assign choice[4][15:0] = 16'b1111000111111111;
	assign choice[5][15:0] = 16'b1111100011111111;
	assign choice[6][15:0] = 16'b1111110001111111;
	assign choice[7][15:0] = 16'b1111111000111111;
	assign choice[8][15:0] = 16'b1111111100011111;
	assign choice[9][15:0] = 16'b1111111110001111;
	assign choice[10][15:0] = 16'b1111111111000111;
	assign choice[11][15:0] = 16'b1111111111100011;
	assign choice[12][15:0] = 16'b1111111111110001;
	assign choice[13][15:0] = 16'b1111111001111111;
	assign choice[14][15:0] = 16'b1110011111111111;
	assign choice[15][15:0] = 16'b1100111111111111;
	
	logic [3:0] num;
	random pick (.clk, .RST, .num);
	
	always_comb begin
		if (RST | dead)
			init = 16'b0000000000000000;
		else begin
			init[0] = choice[num][0];
			init[1] = choice[num][1];
			init[2] = choice[num][2];
			init[3] = choice[num][3];
			init[4] = choice[num][4];
			init[5] = choice[num][5];
			init[6] = choice[num][6];
			init[7] = choice[num][7];
			init[8] = choice[num][8];
			init[9] = choice[num][9];
			init[10] = choice[num][10];
			init[11] = choice[num][11];
			init[12]= choice[num][12];
			init[13]= choice[num][13];
			init[14] = choice[num][14];
			init[15] = choice[num][15];
		end
			pattern <= init;

	end	
	
endmodule 
	
module tubePick_testbench();

logic clk;
logic RST;
logic [15:0] pattern;
logic [15:0] init;

tubePick dut (.clk(clk),.RST,.pattern);

// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
	end 
	
	initial begin
		RST <= 1;@(posedge clk);
		RST <= 0;
		$stop;
	end
endmodule

	
	