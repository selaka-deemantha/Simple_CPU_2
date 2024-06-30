module z(
	input clk,rst,
	input [7:0] alu_out,
	output reg z_out
	);
	
always @(*) begin
	if(alu_out==8'b00000000) z_out=0;
	else z_out=1;
	end
endmodule

