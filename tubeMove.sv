// Guides the tube in the leftward direction, moving the pattern column one pixel left each clock cycle
module tubeMove (clk, RST, col_R, light_o, dead);
	input logic clk, RST, dead;
	input logic [15:0] col_R;
	output logic [15:0] light_o;

	always_ff @(posedge clk) begin
		// sees if reset is on or if the col has already been on for a cycle and zeros that col if so
		if (RST | light_o != 16'b0000000000000000 | dead)
			light_o <= 16'b0000000000000000;
		// sets the current column pattern equal to the column to the right of it
		else if (col_R != 16'b0000000000000000) begin
			light_o <= col_R;
		end
	end	
	
//	enum {on, off} ps, ns;
//		
//	always_latch begin
//		case(ps)
//			on:	begin
//				light_init = 16'b0000000000000000;
//				ns = off;
//			end 
//			
//			off:	begin
//				if (col_R != 16'b0000000000000000) begin
//					ns = on;
//					//sets the current column equal to the pattern chosen
//					light_init <= col_R;
//				end else begin
//					ns = off;
//					light_init = 16'b0000000000000000;
//				end
//			end
//		endcase
//	end
//	
//	assign light_o = light_init;
endmodule

module tubeMove_testbench();
logic clk;
logic RST;
logic [15:0] col_R;
logic [15:0] light_o;

tubeMove dut (.clk,.RST,.col_R,.light_o);

// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
	end 
	
initial begin
	RST <= 1;@(posedge clk);
	RST <= 0;@(posedge clk);
	light_o <= 16'b0000000000000000;@(posedge clk);
	col_R   <= 16'b0000000000000000;@(posedge clk);
	col_R   <= 16'b0000000000001111;repeat(3)@(posedge clk);
	
	$stop;
end
endmodule
				
			