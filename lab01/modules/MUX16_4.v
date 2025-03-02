`timescale 1ns / 1ps

module MUX16_4(
  
  input [15:0]dat,
  input [1:0]adr,

  output wire [3:0]do
);

assign do = (adr == 0)? dat[3:0]   :
            (adr == 1)? dat[7:4]   :
            (adr == 2)? dat[11:8]  :
                        dat[15:12] ;
endmodule
