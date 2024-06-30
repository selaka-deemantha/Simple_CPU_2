module pc(
	input clk,
	input rst,
	input pc_inc,
	input pc_load,
	input [15:0] bus,
	output [15:0] out);
	
reg [15:0] pc_reg;

always @(posedge clk, posedge rst) begin
	if(rst) pc_reg<=16'b0;
	else if(pc_load) pc_reg<=bus;
	else if(pc_inc) pc_reg<=pc_reg+1;
end

assign out=pc_reg;

endmodule
