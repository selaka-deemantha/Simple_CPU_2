module cpu(
	input clk,
	input rst,
	output [7:0] acc,
	output pcinc,pcload,pcbus,acinc,acload,alusel,membus,memread
	);
	
	
	
assign acc=ac_out;
assign pcinc=pc_inc;
assign pcload=pc_load;
assign pcbus=pc_bus;
assign acinc=ac_inc;
assign acload=ac_load;
assign alusel=alu_sel;
assign membus=mem_bus;
assign memread=mem_read;

	
	
wire [5:0] pc_out,ar_out;
wire [7:0] mem_out,dr_out,ac_out,ac_input;
wire [1:0] opcode;
wire [11:0] ctrl_out;

wire pc_inc;
wire pc_load;
wire pc_bus;
wire ar_load;
wire ac_inc;
wire ac_load;
wire dr_load;
wire dr_bus;
wire ir_load;
wire alu_sel;
wire mem_bus;
wire mem_read;


reg [7:0] bus;
always @(*) begin
	if(pc_bus) bus=pc_out;
	else if(dr_bus) bus=dr_out;
	else if(mem_bus) bus=mem_out;
	else bus=8'b0;
end

assign pc_inc=ctrl_out[9];
assign pc_load=ctrl_out[10];
assign pc_bus=ctrl_out[2];

assign ar_load=ctrl_out[11];

assign ac_inc=ctrl_out[6];
assign ac_load=ctrl_out[7];

assign dr_load=ctrl_out[8];
assign dr_bus=ctrl_out[1];

assign ir_load=ctrl_out[5];

assign alu_sel=ctrl_out[4];

assign mem_bus=ctrl_out[3];

assign mem_read=ctrl_out[0];


	
pc pc(
	.clk(clk),
	.rst(rst),
	.pc_inc(pc_inc),
	.pc_load(pc_load),
	.bus(bus[5:0]),
	.out(pc_out)
	);
	
AR AR(
	.clk(clk),
	.rst(rst),
	.ar_load(ar_load),
	.bus(bus[5:0]),
	.out(ar_out)

);

DR DR(
	.clk(clk),
	.rst(rst),
	.dr_load(dr_load),
	.bus(bus),
	.out(dr_out)

);

AC AC(
	.clk(clk),
	.rst(rst),
	.ac_inc(ac_inc),
	.ac_load(ac_load),
	.ac_input(ac_input),
	.out(ac_out)

);

IR IR(
	.clk(clk),
	.rst(rst),
	.ir_load(ir_load),
	.bus(bus[7:6]),
	.opcode(opcode)
	);
	

memory memory(
	.read(mem_read),
	.addr(ar_out),
	.data(mem_out)

);

controller controller(
	.clk(clk),
	.rst(rst),
	.opcode(opcode),
	.out(ctrl_out)
	
);

alu alu(
	.a(bus),
	.b(ac_out),
	.alu_sel(alu_sel),
	.c(ac_input)
	);

endmodule
