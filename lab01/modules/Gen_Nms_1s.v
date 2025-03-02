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

// ������� N �����������
reg [9:0]cb_Nms = 0;

// ����� ��� �������� �������
wire [9:0]Nms = Tmod? `N-1 : ((F1kHz/F1Hz) - 1);

// 1 ������� ��� Nms
assign CEO = ce & (cb_Nms == 0); 

always @(posedge clk) if (ce) begin
  // ���� N �����������
  cb_Nms <= (cb_Nms == 0)? Nms : cb_Nms - 1;
end

endmodule
