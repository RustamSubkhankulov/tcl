`timescale 1ns / 1ps

`define m 4

// ����� ������������ m-���������� �������� � ���������� ������� � ���� 
// � � ������ 'ce' ���������� �����
module VCB4RE (

  input ce,  // Clock Enable - ������ ���������� �����
  input clk, // ������ ������������� (����������� ������)
  input R,   // ������ ����������� ������ � ����

  output reg [`m-1:0]Q = 0, // �������� ��������
  output wire TC,           // Terminal Count - ������ ������������
  output wire CEO           // Clock Enable Output - ������ ��������
);

// Q0 & Q1 &...& Q'm-1 == 1
assign TC = (Q == (1 << `m) - 1);

// ������ ��������
assign CEO = ce & TC;

// �� ������ ����� �������������
always @(posedge clk) begin
  
  // ���� R == 1, �� ����� � 0 ���������� �� ������� ������������� clk
  // ����� ���� ce == 1, �� "�����������", ����� "������"
  Q <= R? 0 : ce? Q+1 : Q;
end

endmodule
