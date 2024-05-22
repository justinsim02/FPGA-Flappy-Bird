// Generates the First Tube at three different frequencies
module tubeFirst (clk, pattern, light_o, lineTest, SW1,SW2);
	input logic clk,SW1, SW2;
	input logic [15:0] pattern;
	output logic [15:0] light_o;
	input logic [15:0] lineTest;
	
	
	always_ff @(posedge clk) begin
		// sees if their are any tubes currently displayed on the board
		// lineTest corresponds to 16x1 array on the horizontal axis of the highest pixel on the vertical axis
		// lineTest should be all 0 when there are no tubes displayed
		
		//faster speed
		if (SW1) begin
			if (lineTest == 16'b0000000010000000 |lineTest == 16'b0000000000000000)
				light_o <= pattern;
			else
				light_o <= 16'b0000000000000000;
				//impossible speed
		end else if (SW2) begin
			if (lineTest == 16'b0000001000000000 | lineTest == 16'b0000000000000000 | lineTest == 16'b0000001000000100)
				light_o <= pattern;
			else 
				light_o <= 16'b0000000000000000;
		end else begin
		//normal speed
			if (lineTest == 16'b0000000000010000 | lineTest == 16'b0000000000000000)
				light_o <= pattern;
			else
				light_o <= 16'b0000000000000000;
		end
	end
	
		


endmodule 

module tubeFirst_testbench();
	logic clk;
	logic [15:0] light_o;
	logic [15:0] pattern;
	logic [15:0] lineTest;

	// Set up a simulated clock.
		parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
		end 
		
	tubeFirst dut (.clk,.light_o,.pattern,.lineTest);

	initial begin
		pattern <= 16'b0000000110000011;@(posedge clk);
		lineTest<= 16'b0000000000000000;repeat(2)@(posedge clk);
		lineTest <= 16'b1000000000000000;@(posedge clk);
		$stop;
	end
endmodule
		
		
	