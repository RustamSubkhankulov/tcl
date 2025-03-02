`timescale 1ns / 1ps

module Gen1ms(
  
  // “актирующий сигнал
  input clk,

  // 1 миллисекунда
  output wire ce1ms
);

// „астота генератора синхронизации 50 ћ√ц
parameter Fclk = 50000000;
  
// „астота 1 к√ц
parameter F1kHz = 1000;

// —четчик миллисекунд
reg [15:0]cb_ms = 0;
// 1 миллисекунда
assign ce1ms = (cb_ms == 1);

// ƒелитель частоты
always @(posedge clk) begin
  // —чет миллисекунд
  cb_ms <= ce1ms? (Fclk / F1kHz) : cb_ms-1;
end

endmodule
