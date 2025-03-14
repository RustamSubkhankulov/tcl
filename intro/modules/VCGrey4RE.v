`timescale 1ns / 1ps

// Схема суммирующего 4-разрядного счетчика в коде Грея 
// с синхронным сбросом в ноль и с входом 'ce' разрешения счета
module VCGrey4RE (

  input ce,  // Clock Enable - сигнал разрешения счета
  input clk, // Сигнал синхронизации (тактирующий сигнал)
  input R,   // Сигнал синхронного сброса в ноль

  output wire [3:0]Y, // Значение счетчика в коде грея
  output wire TC,     // Terminal Count - сигнал переполнения
  output wire CEO     // Clock Enable Output - сигнал переноса
);

reg [4:0]q = 0;

// Сигнал переполнения
assign TC = (q[4:0] == ((1 << 4) | 1));

// Сигнал переноса
assign CEO = ce & TC;

assign Y = q[4:1];

// По фронту входа синхронизации
always @(posedge clk) begin
  
  q[0] <= (R | CEO)? 0 : ce? !q[0] : q[0];
  q[1] <= (R | CEO)? 0 : ((q[0] == 0) & ce)? !q[1] : q[1];
  q[2] <= (R | CEO)? 0 : (q[1:0] == ((1 << 1) | 1) & ce)? !q[2] : q[2];
  q[3] <= (R | CEO)? 0 : (q[2:0] == ((1 << 2) | 1) & ce)? !q[3] : q[3];
  q[4] <= (R | CEO)? 0 : (q[3:0] == ((1 << 3) | 1) & ce)? !q[4] : q[4];
end

endmodule
