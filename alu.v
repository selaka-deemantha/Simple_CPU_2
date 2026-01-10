module alu(
	input [7:0] a,b,
	input alu_sel,
	output reg [7:0] c
	);
	
always @(*) begin
	if(alu_sel) c<=a^b;
	else c<=a+b;
end

endmodule
