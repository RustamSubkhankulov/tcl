`timescale 1ns / 1ps

`define m 4

// ����� ����������� m-���������� �������� � ���������� ������� � ���� 
// � � ������ 'ce' ���������� �����
module VCBD4SE (

  input ce,  // Clock Enable - ������ ���������� �����
  input clk, // ������ ������������� (����������� ������)
  input s,   // ������ ���������� ��������� � 2^m-1

  output reg [`m-1:0]Q = 0, // �������� ��������
  output wire TC,           // Terminal Count - ������ ������������
  output wire CEO           // Clock Enable Output - ������ ��������
);

// Q0 & Q1 &...& Q'm-1 == 0
assign TC = (Q == 0);

// ������ ��������
assign CEO = ce & TC;

// �� ������ ����� �������������
always @(posedge clk) begin
  
  // ���� s == 1, �� ������ 2^m-1
  // ����� ���� ce == 1, �� "��������", ����� "������"
  Q <= (s)? ((1 << `m) - 1) : ce? Q-1 : Q;
end

endmodule
