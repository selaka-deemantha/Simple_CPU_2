module alu(
	input [7:0] bus,ac,
	input [3:0] alusel,
	output reg [7:0] c
	);
	
	
always @(*) begin
	if(alusel==4'b0000) c<=bus;
	else if(alusel==4'b0001) c<=bus+ac;
	else if(alusel==4'b0010) c<=ac-bus;
	else if(alusel==4'b0011) c<=1+ac;
	else if(alusel==4'b0100) c<=0;
	else if(alusel==4'b0101) c<=bus & ac;
	else if(alusel==4'b0110) c<=bus | ac;
	else if(alusel==4'b0111) c<=bus ^ ac;
	else if(alusel==4'b1000) c<= ~ac;
	
end

endmodule
