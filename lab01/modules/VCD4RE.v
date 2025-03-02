`timescale 1ns / 1ps

`define m 4

// ����� ������������ ��������� �������� � ���������� ������� � ���� 
// � � ������ 'ce' ���������� �����
module VCD4RE (

  input ce,  // Clock Enable - ������ ���������� �����
  input clk, // ������ ������������� (����������� ������)
  input R,   // ������ ����������� ������ � ����

  output reg [`m-1:0]Q = 0, // �������� ��������
  output wire TC,           // Terminal Count - ������ ������������
  output wire CEO           // Clock Enable Output - ������ ��������
);

// Q0 & Q1 &...& Q'm-1 == 1
assign TC = (Q == 9);

// ������ ��������
assign CEO = ce & TC;

// �� ������ ����� �������������
always @(posedge clk) begin
  
  // ����� � 0 ���������� ��� ��� Q == 9 � ce == 1 ��� ��� R == 1
  // ����� ���� ce == 1, �� "�����������", ����� "������"
  Q <= (R | CEO)? 0 : ce? Q+1 : Q;
end

endmodule
