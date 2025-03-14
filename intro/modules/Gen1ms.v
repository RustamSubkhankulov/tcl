`timescale 1ns / 1ps

module Gen1ms(
  
  // ����������� ������
  input clk,

  // 1 ������������
  output wire ce1ms
);

// ������� ���������� ������������� 50 ���
parameter Fclk = 50000000;
  
// ������� 1 ���
parameter F1kHz = 1000;

// ������� �����������
reg [15:0]cb_ms = 0;
// 1 ������������
assign ce1ms = (cb_ms == 1);

// �������� �������
always @(posedge clk) begin
  // ���� �����������
  cb_ms <= ce1ms? (Fclk / F1kHz) : cb_ms-1;
end

endmodule
