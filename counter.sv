// Takes in logic that decides which edge is about to win, and The left and right KEY press inputs
// increments and outputs the current number of wins for one of the players
module counter (clk, reset, L, R, CL, outHEX, i);
	input logic clk;
	input logic i; 		// i = right player, ~i = left player
	input logic reset;
	input logic L, R, CL;
	output logic 	[6:0] 	outHEX;
	
	enum logic [6:0] {seven = 7'b1111000, six = 7'b0000010, five = 7'b0010010, four = 7'b0011001, 
					three = 7'b0110000, two = 7'b0100100, one = 7'b1111001, zero = 7'b1000000} ps, ns;
	
	always_comb begin

			case(ps)
				zero: 	if ((CL & i & R) | (CL & ~i & L)) ns = one; 	else ns = zero;
				one: 		if ((CL & i & R) | (CL & ~i & L)) ns = two;	else ns = one;
				two: 		if ((CL & i & R) | (CL & ~i & L)) ns = three;	else ns = two;
				three: 	if ((CL & i & R) | (CL & ~i & L)) ns = four;	else ns = three;
				four: 	if ((CL & i & R) | (CL & ~i & L)) ns = five;	else ns = four;
				five: 	if ((CL & i & R) | (CL & ~i & L)) ns = six;	else ns = five;
				six: 		if ((CL & i & R) | (CL & ~i & L)) ns = seven;	else ns = six;
				seven:	if ((CL & i & R) | (CL & ~i & L)) ns = seven;	else ns = seven;
				default ns = zero;
			endcase
	end
		
	assign outHEX = ps;
			
	always_ff @(posedge clk) begin
		if (reset)
			ps <= zero; 
		else
			ps <= ns; 
   end

	
endmodule 

module counter_testbench();
	logic i;
	logic clk;
	logic reset;
	logic L, R, CL;
	logic 	[6:0] 	outHEX;
	
	counter dut (clk, reset, L, R, CL, outHEX, i);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin	
		i <= 1'b1;
      reset <= 1;    @(posedge clk); // Always reset FSMs at start
      reset <= 0; L <= 0;  @(posedge clk);
		CL <= 1;
		R <= 1; @(posedge clk);
		CL <= 1;
		R <= 1; @(posedge clk);
		
                
		$stop; // End the simulation.
	end
endmodule



	