`timescale 1ns / 1ps

module Sch1_lab401(
  
  input F50MHz,
  input BTN0,
  input [7:0] SW,
  
  output [3:0] AN,
  output [7:0] SEG,
  output [7:0] LED
);

wire [15:0] dat;
wire clk;

wire ce_Gen_Nms_1s;
wire ce_1;
wire ce_2;
wire ce_3;
wire ce_4;

assign LED = SW;
assign clk = F50MHz;

DISPLAY submodule_DISPLAY(
  .clk(clk),
  .dat(dat),
  .PTR(SW[5:4]),

  .AN(AN),
  .SEG(SEG),
  .ce1ms(ce_Gen_Nms_1s)
);

Gen_Nms_1s submodule_Gen_Nms_1s(
  .clk(clk),
  .ce(ce_Gen_Nms_1s),
  .Tmod(SW[7]),

  .CEO(ce_1)
);

VCJ4RE submodule_VCJ4RE(
  .ce(ce_1),
  .clk(clk),
  .R(BTN0),

  .Q(dat[3:0]),
  .CEO(ce_2)
);

VCB4RE submodule_VCB4RE(
  .ce(ce_2),
  .clk(clk),
  .R(BTN0),

  .Q(dat[7:4]),
  .CEO(ce_3)
);

VCBD4SE submodule_VCBD4SE(
  .ce(ce_3),
  .clk(clk),
  .s(BTN0),

  .Q(dat[11:8]),
  .CEO(ce_4)
);

VCGrey4RE submodule_VCGrey4RE(
  .ce(ce_4),
  .clk(clk),
  .R(BTN0),

  .Y(dat[15:12])
);

endmodule
