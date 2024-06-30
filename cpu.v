module cpu(
	input clk,
	input rst,
	
	//test purpose
	output [7:0] ac_out_t,alu_out_t,dr_out_t,tr_out_t,
	output pcinc_t,pc_bus_t,drh_bus_t,drl_bus_t,bus_mem_t,read_t,write_t,ar_load_t,dr_load_t,ir_load_t,
	output [15:0] pc_out_t,bus_t
	);
	
	
assign ac_out_t=ac_out;
assign pcinc_t=pc_inc;
assign drh_bus_t=drh_bus;
assign drl_bus_t=drl_bus;
assign bus_mem_t=bus_mem;
assign read_t=read;
assign write_t=write;
assign pc_out_t=pc_out;
assign bus_t=bus;
assign ar_load_t=ar_load;
assign dr_load_t=dr_load;
assign ir_load_t=ir_load;
assign pc_bus_t=pc_bus;
assign alu_out_t=alu_out;
assign dr_out_t=dr_out;
assign tr_out_t=tr_out;

	
reg [15:0] bus;
always @(*) begin
	bus=16'b0000000000000000;
	if(pc_bus) bus=pc_out;
	else if(drh_bus & tr_bus) begin
		bus[15:8]=dr_out;
		bus[7:0]=tr_out;
	end
	else if(drl_bus && ~bus_mem) bus[7:0]=dr_out;
	else if(drl_bus && bus_mem) begin
		bus[7:0]=dr_out;
		mem_in_reg=bus;
	end
	else if(mem_bus) bus=mem_out;
	//else if(tr_bus) bus=tr_out;
	else if(r_bus) bus=r_out;
	else if(ac_bus) bus=ac_out;
	//else if(bus_mem) mem_in_reg=bus;
	else bus=8'b0000000000000000;
end	
	
	

wire pc_bus,drh_bus,drl_bus,mem_bus,tr_bus,r_bus,ac_bus,bus_mem;
wire ar_load,pc_load,dr_load,tr_load,ir_load,r_load,ac_load,z_load;
wire ar_inc,pc_inc;
wire read,write;
wire [3:0] alu_sel;
wire z_out;
wire [15:0] pc_out,ar_out;
wire [7:0] mem_out,mem_in,tr_out,r_out,ac_out,dr_out,ir_out,alu_out;
wire [23:0] ctrl_out;

reg [7:0] mem_in_reg;
assign mem_in=mem_in_reg;

	

assign ar_load=ctrl_out[17];
assign ar_inc=ctrl_out[16];

assign pc_load=ctrl_out[15];
assign pc_inc=ctrl_out[14];

assign dr_load=ctrl_out[13];

assign ac_load=ctrl_out[12];

assign ir_load=ctrl_out[11];
assign r_load=ctrl_out[19];
assign tr_load=ctrl_out[18];

assign z_load=ctrl_out[10];

assign alu_sel=ctrl_out[23:20];

assign mem_bus=ctrl_out[9];

assign bus_mem=ctrl_out[8];

assign pc_bus=ctrl_out[7];

assign drh_bus=ctrl_out[6];

assign drl_bus=ctrl_out[5];

assign tr_bus=ctrl_out[4];
assign r_bus=ctrl_out[3];
assign ac_bus=ctrl_out[2];

assign read=ctrl_out[1];
assign write=ctrl_out[0];
	
	
pc pc(
	.clk(clk),
	.rst(rst),
	.pc_inc(pc_inc),
	.pc_load(pc_load),
	.bus(bus),
	.out(pc_out)
	);

AR AR(
	.clk(clk),
	.rst(rst),
	.ar_load(ar_load),
	.ar_inc(ar_inc),
	.bus(bus),
	.out(ar_out)
);

DR DR(
	.clk(clk),
	.rst(rst),
	.dr_load(dr_load),
	.bus(bus[7:0]),
	.out(dr_out)
);

IR IR(
	.clk(clk),
	.rst(rst),
	.ir_load(ir_load),
	.dr_out(dr_out),
	.opcode(ir_out)

);

R R(
	.clk(clk),
	.rst(rst),
	.r_load(r_load),
	.bus(bus[7:0]),
	.out(r_out)

);

AC AC(
	.clk(clk),
	.rst(rst),
	.ac_load(ac_load),
	.ac_input(alu_out),
	.out(ac_out)

);

alu alu(
	.bus(bus[7:0]),
	.ac(ac_out),
	.alusel(ctrl_out[23:20]),
	.c(alu_out)

);

z z(
	.clk(clk),
	.rst(rst),
	.alu_out(alu_out),
	.z_out(z_out)

);

TR TR(
	.clk(clk),
	.rst(rst),
	.tr_load(tr_load),
	.dr_out(dr_out),
	.tr_out(tr_out)

);
memory memory(
	.clk(clk),
	.rst(rst),
	.read(read),
	.write(write),
	.ar_out(ar_out),
	.mem_input(mem_in),
	.mem_output(mem_out)

);
controller controller(
	.clk(clk),
	.rst(rst),
	.opcode(ir_out),
	.out(ctrl_out)
);

endmodule
