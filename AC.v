module AC(
	input clk,
	input rst,
	input ac_load,
	input [7:0] ac_input,
	output [7:0] out);
	
reg [7:0] ac_reg;

always @(posedge clk, posedge rst) begin
	if(rst) ac_reg<=7'b0;
	else if(ac_load) ac_reg<=ac_input;
end

assign out=ac_reg;

endmodule
