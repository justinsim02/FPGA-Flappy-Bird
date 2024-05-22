module death (RedPixels,GrnPixels, dead);
	input logic [15:0][15:0] RedPixels,GrnPixels;
	output logic dead;
	
	assign dead = ((RedPixels[11][0] & GrnPixels[11][0]) |
						(RedPixels[11][1] & GrnPixels[11][1]) |
						(RedPixels[11][2] & GrnPixels[11][2]) |
						(RedPixels[11][3] & GrnPixels[11][3]) |
						(RedPixels[11][4] & GrnPixels[11][4]) |
						(RedPixels[11][5] & GrnPixels[11][5]) |
						(RedPixels[11][6] & GrnPixels[11][6]) |
						(RedPixels[11][7] & GrnPixels[11][7]) |
						(RedPixels[11][8] & GrnPixels[11][8]) |
						(RedPixels[11][9] & GrnPixels[11][9]) |
						(RedPixels[11][10] & GrnPixels[11][10]) |
						(RedPixels[11][11] & GrnPixels[11][11]) |
						(RedPixels[11][12] & GrnPixels[11][12]) |
						(RedPixels[11][13] & GrnPixels[11][13]) |
						(RedPixels[11][14] & GrnPixels[11][14]) |
						(RedPixels[11][15] & GrnPixels[11][15]) );
	
endmodule
