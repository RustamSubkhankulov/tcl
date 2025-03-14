`timescale 1ns / 1ps

module BUTTON(
	input clk, // ce1ms
	input btn_in,
	input [15:0]dat_in,
	
	output [15:0]dat_out
);

reg [15:0]saturation = 0;

reg [15:0]dat_upd = 0;
assign dat_out = dat_upd;

parameter Max_saturation = 25;

reg prev_pressed = 0;
reg is_pressed = 0;

always @(posedge clk) begin
  saturation <= (btn_in && (saturation < Max_saturation))? saturation+1 : (!btn_in && saturation)? saturation-1 : saturation; 
  prev_pressed <= is_pressed;
  is_pressed <= (saturation == Max_saturation)? 1 : (saturation == 0)? 0 : is_pressed;
  dat_upd <= (is_pressed && !prev_pressed)? dat_in+1 : dat_in;
end

endmodule
