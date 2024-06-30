module TR(
	input clk,
	input rst,
	input tr_load,
	input [7:0] dr_out,
	output [7:0] tr_out
	);
	
reg [7:0] tr_reg;

always @(posedge clk, posedge rst) begin
	if(rst) tr_reg<=8'b0;
	else if(tr_load) tr_reg<=dr_out;
end

assign tr_out=tr_reg;

endmodule
