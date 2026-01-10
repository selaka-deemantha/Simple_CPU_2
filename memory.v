module memory(
	input read,
	input [5:0] addr,
	output reg [7:0] data);
	
	
reg [7:0] mem [63:0];

initial begin

mem[0]=8'b00100000; //add: ac=ac+M[100000]
mem[1]=8'b10000100; //add: ac=ac+M[100001]
mem[2]=8'b00100010; //add: ac=ac+M[100010]
mem[3]=8'b00100011; //add: ac=ac+M[100011]
mem[4]=8'b11000000; //add: ac=ac+M[100100]


mem[32]=3;
mem[33]=5;
mem[34]=7;
mem[35]=1;
mem[36]=2;
end


always @(*) begin
	if(read) data=mem[addr];
	end
	
endmodule

