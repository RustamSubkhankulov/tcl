`timescale 1ns / 1ps

module Sch2_lab402(
  
  input F50MHz,
  input BTN0,
  input [7:0] SW,
  
  output [3:0] AN,
  output [7:0] SEG,
  output [7:0] LED
);

wire [15:0] dat;
wire clk;
wire ce1ms;

assign LED = SW;
assign clk = F50MHz;

DISPLAY submodule_DISPLAY(
  .clk(clk),
  .dat(dat),
  .PTR(SW[5:4]),

  .AN(AN),
  .SEG(SEG),
  .ce1ms(ce1ms)
);

BUTTON submodule_BUTTON(
	.clk(ce1ms),
	.btn_in(BTN0),
	.dat_in(dat),
	.dat_out(dat)
);

endmodule

