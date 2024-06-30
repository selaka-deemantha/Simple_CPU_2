module AR(
	input clk,
	input rst,
	input ar_load,
	input ar_inc,
	input [15:0] bus,
	output [15:0] out);
	
reg [15:0] ar_reg;

always @(posedge clk, posedge rst) begin
	if(rst) ar_reg<=16'b0;
	else if(ar_load) ar_reg<=bus;
	else if(ar_inc) ar_reg<=ar_reg+1;
end

assign out=ar_reg;

endmodule
