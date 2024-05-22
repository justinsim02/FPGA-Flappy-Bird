// This module ensures metastability by ensuring the user input
// is only true for one clock cycle
// Prevents player from holding down key in order to win
module userIn (clk, in, out);
input logic clk;
input logic in;
output logic out;	
logic in1;
	
	always_ff @(posedge clk) begin
	in1 <= in;
		end
		always_ff @(posedge clk) begin
	out <= (in&~in1);
		end
		
endmodule	