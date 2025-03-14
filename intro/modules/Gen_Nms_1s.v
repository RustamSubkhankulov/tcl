`timescale 1ns / 1ps
`define N 14

module Gen_Nms_1s(
  
  input clk,
  input ce,  // ce1ms
  input Tmod,

  output wire CEO
);

parameter F1kHz = 1000; 
parameter F1Hz = 1;

// —четчик N миллисекунд
reg [9:0]cb_Nms = 0;

// „исло дл€ делител€ частоты
wire [9:0]Nms = Tmod? `N-1 : ((F1kHz/F1Hz) - 1);

// 1 секунда или Nms
assign CEO = ce & (cb_Nms == 0); 

always @(posedge clk) if (ce) begin
  // —чет N миллисекунд
  cb_Nms <= (cb_Nms == 0)? Nms : cb_Nms - 1;
end

endmodule
