module Sch_lab401(
  
  input clk,
  input BTN0,
  input [7:0] SW,
  
  output [3:0] AN,
  output [7:0] SEG
);

wire [15:0] dat;

wire ce_Gen_Nms_1s;
wire ce_VCJmRE;
wire ce_VCBmRE;
wire ce_VCBDmSE;
wire ce_VCGrey4RE;

Gen_Nms_1s submodule_Gen_Nms_1s(
  .clk(clk),
  .ce(ce_Gen_Nms_1s),
  .Tmod(SW[7]),

  .CEO(ce_VCJmRE)
);

VCJmRE submodule_VCJmRE(
  .ce(ce_VCJmRE),
  .clk(clk),
  .R(BTN0),

  .Q(dat[3:0]),
  .CEO(ce_VCBmRE)
);

VCBmRE submodule_VCBmRE(
  .ce(ce_VCBmRE),
  .clk(clk),
  .R(BTN0),

  .Q(dat[7:4]),
  .CEO(ce_VCBDmSE)
);

VCBDmSE submodule_VCBDmSE(
  .ce(ce_VCBDmSE),
  .clk(clk),
  .s(BTN0),

  .Q(dat[11:8]),
  .CEO(ce_VCGrey4RE)
);

VCGrey4RE submodule_VCGrey4RE(
  .ce(ce_VCGrey4RE),
  .clk(clk),
  .R(BTN0),

  .Y(dat[15:12])
);

DISPLAY submodule_DISPLAY(
  .clk(clk),
  .dat(dat),
  .PTR(SW[5:4]),

  .AN(AN),
  .SEG(SEG),
  .ce1ms(ce_Gen_Nms_1s)
);

endmodule
