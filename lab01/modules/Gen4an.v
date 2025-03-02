`timescale 1ns / 1ps

module Gen4an(

  input clk, // ����������� ������
  input ce,  // ���������� ������������ �����

  output reg [1:0]q = 0,  // ������� ������ �����
  output wire [3:0]an 
);

assign an = (q == 0)? 4'b1110 : // ��������� ����� 0
            (q == 1)? 4'b1101 : // ��������� ����� 1
            (q == 2)? 4'b1011 : // ��������� ����� 2
                      4'b0111 ; // ��������� ����� 3

always @(posedge clk) if (ce) begin
  q <= q + 1;
end

endmodule
