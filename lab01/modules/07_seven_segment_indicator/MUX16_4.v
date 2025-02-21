// Мультиплексор 4-х битных цифр
module MUX16_4(
  
  input [15:0]dat,
  input [1:0]addr,

  output wire [3:0]do
);

assign do = (adr == 1)? dat[3:0]  :
            (adr == 2)? dat[7:4]  :
            (adr == 3)? dat[11:8] :
                        dat[15:9] ;
endmodule
