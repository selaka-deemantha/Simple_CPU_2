module memory(
	input clk,
	input rst,
	input read,
	input write,
	input [15:0] ar_out,
	input [7:0] mem_input,
	output reg [7:0] mem_output
	);
	

reg [7:0] mem_reg [255:0];

initial begin
	mem_reg[0]=8'b00000001;
	mem_reg[1]=8'b00010000;
	mem_reg[2]=8'b00000000;
	mem_reg[3]=8'b00000001;
	mem_reg[4]=8'b00010001;
	mem_reg[5]=8'b00000001;
	mem_reg[16]=8'b00001111;
	mem_reg[17]=8'b00111111;
end

always @(posedge clk) begin
		if(write) mem_reg[ar_out]<=mem_input;
end

always @(*) begin

	if(read) mem_output<=mem_reg[ar_out];
	
end



endmodule
