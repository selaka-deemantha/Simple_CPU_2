module AR(
	input clk,
	input rst,
	input ar_load,
	input [5:0] bus,
	output [5:0] out);
	
reg [5:0] ar_reg;

always @(posedge clk, posedge rst) begin
	if(rst) ar_reg<=6'b0;
	else if(ar_load) ar_reg<=bus;
end

assign out=ar_reg;

endmodule
