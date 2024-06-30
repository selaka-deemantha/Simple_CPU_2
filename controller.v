module controller(
	input clk,
	input rst,
	input [7:0] opcode,
	output [23:0] out
	);
	
	
localparam RLOAD=19;
localparam TRLOAD=18;
localparam ARLOAD=17;
localparam ARINC=16;
	
localparam PCLOAD=15;	
localparam PCINC=14;

localparam DRLOAD=13;

localparam ACLOAD=12;

localparam IRLOAD=11;

localparam ZLOAD=	10;




localparam MEMBUS= 9;
localparam BUSMEM= 8;	

localparam PCBUS= 7;
localparam DRHBUS= 6;	
localparam DRLBUS= 5;
localparam TRBUS=	4;
localparam RBUS=	3;
localparam ACBUS=	2;

localparam READ= 1;
localparam WRITE=	0;

localparam NOP=8'b00000000;
localparam LDAC=8'b00000001;
localparam STAC=8'b00000010;
localparam MVAC=8'b00000011;
localparam MOVR=8'b00000100;
localparam JUMP=8'b00000101;
localparam JMPZ=8'b00000110;
localparam JPNZ=8'b00000111;
localparam ADD=8'b00001000;
localparam SUB=8'b00001001;
localparam INAC=8'b00001010;
localparam CLAC=8'b00001011;
localparam AND=8'b00001100;
localparam OR=8'b00001101;
localparam XOR=8'b00001110;
localparam NOT=8'b00001111;

reg [23:0] ctrl_word;
reg [3:0] stage;



always @(posedge clk, posedge rst) begin
	if(rst) stage<=0;
	else begin 
		if(stage==8) stage<=0;
		else stage<=stage+1;
	end
end

always @(*) begin
	ctrl_word=24'b000000000000000000000000;
	case(stage)
		0: begin 
			ctrl_word[PCBUS]=1;
			ctrl_word[ARLOAD]=1;
		end
		1: begin
			ctrl_word[READ]=1;
			ctrl_word[MEMBUS]=1;
			ctrl_word[DRLOAD]=1;
			ctrl_word[PCINC]=1;
		end
		2: begin
			//ctrl_word[DRBUS]=1;
			ctrl_word[IRLOAD]=1;
			ctrl_word[PCBUS]=1;
			ctrl_word[ARLOAD]=1;
			
		end
		
		3: begin
			case(opcode)
				ADD: begin
					ctrl_word[RBUS]=1;
					ctrl_word[23:20]=4'b0001;
					ctrl_word[ACLOAD]=1;
				end
				SUB: begin
					ctrl_word[PCBUS]=1;
					ctrl_word[23:20]=4'b0010;
					ctrl_word[ACLOAD]=1;
				end
				AND: begin
					ctrl_word[RBUS]=1;
					ctrl_word[23:20]=4'b0101;
					ctrl_word[ACLOAD]=1;
				end
				OR: begin
					ctrl_word[RBUS]=1;
					ctrl_word[23:20]=4'b0110;
					ctrl_word[ACLOAD]=1;
				end
				XOR: begin
					ctrl_word[RBUS]=1;
					ctrl_word[23:20]=4'b0111;
					ctrl_word[ACLOAD]=1;
				end
				NOT: begin
					ctrl_word[23:20]=4'b1000;
					ctrl_word[ACLOAD]=1;
				end
				INAC: begin
					ctrl_word[23:20]=4'b0011;
					ctrl_word[ACLOAD]=1;
				end
				CLAC: begin
					ctrl_word[23:20]=4'b0100;
					ctrl_word[ACLOAD]=1;
				end
				LDAC: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
					ctrl_word[PCINC]=1;
					ctrl_word[ARINC]=1;
				end
				STAC: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
					ctrl_word[PCINC]=1;
					ctrl_word[ARINC]=1;
					
				end
				default: ctrl_word=0;
			endcase
		end	
					
		4: begin
			case(opcode)
				LDAC: begin
					ctrl_word[TRLOAD]=1;
				end
				STAC: begin
					ctrl_word[TRLOAD]=1;
				end
				default: ctrl_word=0;
			endcase
		end
		5: begin
			case(opcode)
				LDAC: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
					ctrl_word[PCINC]=1;
				end
				STAC: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
					ctrl_word[PCINC]=1;
				end
				default: ctrl_word=0;
			endcase
		end
		6: begin
			case(opcode)
				LDAC: begin
					ctrl_word[DRHBUS]=1;
					ctrl_word[TRBUS]=1;
					ctrl_word[ARLOAD]=1;
				end
				STAC: begin
					ctrl_word[DRHBUS]=1;
					ctrl_word[TRBUS]=1;
					ctrl_word[ARLOAD]=1;
				end
				default: ctrl_word=0;
			endcase
		end
		7: begin
			case(opcode)
				LDAC: begin
					ctrl_word[READ]=1;
					ctrl_word[MEMBUS]=1;
					ctrl_word[DRLOAD]=1;
				end
				STAC: begin
					ctrl_word[ACBUS]=1;
					ctrl_word[DRLOAD]=1;
				end
				default: ctrl_word=0;
			endcase
		end
		8: begin
			case(opcode)
				LDAC: begin
					ctrl_word[DRLBUS]=1;
					ctrl_word[23:20]=4'b0000;
					ctrl_word[ACLOAD]=1;
				end
				STAC: begin
					
					ctrl_word[DRLBUS]=1;
					ctrl_word[BUSMEM]=1;
					ctrl_word[WRITE]=1;
				end
				default: ctrl_word=0;
			endcase
		end
		default: ctrl_word=0;
	endcase
end

assign out=ctrl_word;

endmodule
	
				
			
					
				
				
										

			


	
