module R(
	input clk,
	input rst,
	input r_load,
	input [7:0] bus,
	output [7:0] out
	);
	
reg [7:0] r_reg;

always @(posedge clk, posedge rst) begin
	if(rst) r_reg<=8'b0;
	else if(r_load) r_reg<=bus;
end

assign out=r_reg;

endmodule
