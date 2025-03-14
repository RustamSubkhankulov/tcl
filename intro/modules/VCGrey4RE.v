`timescale 1ns / 1ps

// ����� ������������ 4-���������� �������� � ���� ���� 
// � ���������� ������� � ���� � � ������ 'ce' ���������� �����
module VCGrey4RE (

  input ce,  // Clock Enable - ������ ���������� �����
  input clk, // ������ ������������� (����������� ������)
  input R,   // ������ ����������� ������ � ����

  output wire [3:0]Y, // �������� �������� � ���� ����
  output wire TC,     // Terminal Count - ������ ������������
  output wire CEO     // Clock Enable Output - ������ ��������
);

reg [4:0]q = 0;

// ������ ������������
assign TC = (q[4:0] == ((1 << 4) | 1));

// ������ ��������
assign CEO = ce & TC;

assign Y = q[4:1];

// �� ������ ����� �������������
always @(posedge clk) begin
  
  q[0] <= (R | CEO)? 0 : ce? !q[0] : q[0];
  q[1] <= (R | CEO)? 0 : ((q[0] == 0) & ce)? !q[1] : q[1];
  q[2] <= (R | CEO)? 0 : (q[1:0] == ((1 << 1) | 1) & ce)? !q[2] : q[2];
  q[3] <= (R | CEO)? 0 : (q[2:0] == ((1 << 2) | 1) & ce)? !q[3] : q[3];
  q[4] <= (R | CEO)? 0 : (q[3:0] == ((1 << 3) | 1) & ce)? !q[4] : q[4];
end

endmodule
