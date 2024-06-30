module DR(
	input clk,
	input rst,
	input dr_load,
	input [7:0] bus,
	output [7:0] out);
	
reg [7:0] dr_reg;

always @(posedge clk, posedge rst) begin
	if(rst) dr_reg<=8'b0;
	else if(dr_load) dr_reg<=bus;
end

assign out=dr_reg;

endmodule
