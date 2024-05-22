// Generates a 4-bit number (from 1-16) every clock cycle
module random (clk, RST, num);
	input logic clk, RST;
	output logic [3:0] num;
	
	always @(posedge clk) begin
		if(RST)
			num <= 4'b0000;
		else	begin
			num[2:0] <= num[3:1];
			num[3] 	<= (num[0] & num[1]) | (~num[0] & ~num[1]);
			end
		end

endmodule