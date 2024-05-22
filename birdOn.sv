// Moves the position of the bird in non-center
module birdOn (clk, RST, key, topLight, botLight, light,fall, dead);
	input logic clk, RST, key, topLight, botLight, fall, dead;
	output logic light;
	
	// State variables
	enum { ON, OFF } ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
			ON:  if ((key & ~fall) | (~key & fall))		            ns = OFF;
				  else																	   ns = ON;
 			OFF: if ((botLight & key & ~fall) | (topLight & ~key & fall))	ns = ON;
				  else 											                     ns = OFF;
		endcase
	end

	// Output logic
	assign light = (ps == ON);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (RST | dead)
			ps <= OFF;
		else
			ps <= ns;
	end
	
endmodule 
//	input logic clk, RST, key, topLight, botLight;
//	output logic light;
//	output logic fall;
//
//	enum logic {on = 1'b1, off = 1'b0} ps, ns;
//	
//	always_comb begin 
//		case (ps)
//			on: begin
//				if (key || fall) begin
//					ns = off;
//				end else begin
//					ns = on;
//				end
//			end
//			off: begin
//			// key pressed and bird 1 pixel below
//			// OR key not press and bird 1 pixel above
//				if ((key && botLight) || (fall && topLight)) begin
//					ns = on;
//				end else begin
//					ns = off;
//				end
//			end
//			default: begin ns = off; end
//		endcase
//	end
//	
//	
//	always_ff @(posedge clk) begin
//		if (RST)
//			ps <= off;
//		else
//			ps <= ns;
//	end
//	
//	assign light = ps;
//
//	
//endmodule 

//module birdOn_testbench();
//	logic clk, RST, key, topLight, botLight;
//	logic light;
//	
//	birdOn dut (.clk, .RST, .key, .topLight, .botLight, .light);
//	// Set up a simulated clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
//	end 
//	
//	initial begin
//		RST <= 1;@(posedge clk);
//		RST <= 0;@(posedge clk);
		
		
	