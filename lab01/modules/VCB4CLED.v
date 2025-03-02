`timescale 1ns / 1ps

`define m 4

// ����� m-���������� ������������ �������� � ����������� ������� � ����
// � � ������ 'ce' ���������� �����
module VCB4CLED (

  input ce,         // Clock Enable - ������ ���������� �����
  input up,         // ����������� �����
  input [`m-1:0]di, // �������� �������� ��� ��������
  input L,          // ������ ���������� ���������� ��������
  input clk,        // ������ ������������� (����������� ������)
  input clr,        // ������ ������������ ������ � ����

  output reg [`m-1:0]Q = 0, // �������� ��������
  output wire TC,           // Terminal Count - ������ ������������
  output wire CEO           // Clock Enable Output - ������ ��������
);

// Q0 & Q1 &...& Q'm-1 == 1 ��� up == 1
// Q0 & Q1 &...& Q'm-1 == 0 ��� up == 0
assign TC = up? (Q == ((1 << `m) - 1)) : (Q == 0);

// ������ ��������
assign CEO = ce & TC;

// �� ������ ����� ������������� ��� �� ������ ������� ������������ ������
always @(posedge clr or posedge clk) begin
  
  // ����������� �����
  if (clr) Q <= 0;
  // ��� clr == L == 0, ce == 1, up == 1 "�����������"
  // ��� clr == L == 0, ce == 1, up == 0 "��������"
  // ��� clr == 0, L == 1 ���������� �� ce ��������  �������� ������������ � di
  else     Q <= L? di : (up & ce)? Q+1 : (!up & ce)? Q-1 : Q; 
end

endmodule
