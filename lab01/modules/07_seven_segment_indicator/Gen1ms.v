// Генератор сигналов с периодом 1 мс
module Gen1ms(
  
  // Тактирующий сигнал
  input clk,

  // 1 миллисекунда
  output wire ce1ms = 0
);

// Частота генератора синхронизации 50 МГц
parameter Fclk = 50000000;
  
// Частота 1 кГц
parameter F1kHz = 1000;

// Счетчик миллисекунд
reg [15:0]cb_ms = 0;
// 1 миллисекунда
assign ce1ms = (cb_ms == 1);

// Делитель частоты
always @(posedge clk) begin
  // Счет миллисекунд
  cb_ms <= ce1ms? (Fclk / F1kHz) : cb_ms-1;
end

endmodule