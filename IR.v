module IR(
	input clk,
	input rst,
	input ir_load,
	input [7:0] dr_out,
	output [7:0] opcode
	);
	
reg [7:0] ir_reg;

always @(posedge clk, posedge rst) begin
	if(rst) ir_reg<=8'b0;
	else if(ir_load) ir_reg<=dr_out;
end

assign opcode=ir_reg;

endmodule
