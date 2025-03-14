`timescale 1ns / 1ps

module Gen_P(
  
  input [1:0]ptr,
  input [1:0]adr_An,

  output wire seg_P
);

assign seg_P = !(ptr == adr_An);

endmodule
