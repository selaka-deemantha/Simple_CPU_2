module IR(
	input clk,
	input rst,
	input ir_load,
	input [1:0] bus,
	output [1:0] opcode
	);
	
reg [1:0] ir_reg;

always @(posedge clk, posedge rst) begin
	if(rst) ir_reg<=2'b0;
	else if(ir_load) ir_reg<=bus;
end

assign opcode=ir_reg;

endmodule
