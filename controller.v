module controller(
	input clk,
	input [1:0] opcode,
	input rst,
	output [11:0] out);
	
	
	
localparam ARLOAD=11;	
localparam PCLOAD=10;	
localparam PCINC=9;	
localparam DRLOAD=8;	
localparam ACLOAD=7;	
localparam ACINC=6;	
localparam IRLOAD=5;	
localparam ALUSEL=4;	
localparam MEMBUS=3;	
localparam PCBUS=2;	
localparam DRBUS=1;	
localparam READ=0;	 	



localparam OP_ADD=2'b00;
localparam OP_AND=2'b01;
localparam OP_JMP=2'b10;
localparam OP_INC=2'b11;

reg[2:0] stage;
reg[11:0] ctrl_word;

always @(posedge clk, posedge rst) begin
	if(rst) stage<=0;
	else begin
		if(stage==4) stage<=0;
		else stage<=stage+1;
	end
end

always @(*) begin
	ctrl_word=12'b0;
	
	case (stage)
		0: begin
			ctrl_word[PCBUS]<=1;
			ctrl_word[ARLOAD]<=1;
		end
		1: begin
			ctrl_word[READ]<=1;
			ctrl_word[MEMBUS]<=1;
			ctrl_word[DRLOAD]<=1;
			ctrl_word[PCINC]<=1;
		end
		2: begin
			ctrl_word[DRBUS]<=1;
			ctrl_word[ARLOAD]<=1;
			ctrl_word[IRLOAD]<=1;
		end
		3: begin
			case (opcode)
				OP_ADD: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
				end
				OP_AND: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
				end
				OP_JMP: begin
					ctrl_word[DRBUS]=1;
					ctrl_word[PCLOAD]=1;
				end
				OP_INC: begin
					ctrl_word[ACINC]=1;
					
				end
			endcase
		end
		4: begin
			case (opcode)
				OP_ADD: begin
					ctrl_word[DRBUS]=1;
					ctrl_word[ACLOAD]=1;
				end
				OP_AND: begin
					ctrl_word[DRBUS]=1;
					ctrl_word[ALUSEL]=1;
					ctrl_word[ACLOAD]=1;
				end
			endcase
		end
	endcase
end
	
assign out=ctrl_word;
endmodule

