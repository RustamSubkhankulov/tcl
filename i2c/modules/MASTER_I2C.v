`timescale 1ns / 1ps

module MASTER_I2C(

  inout SDA,                     // Физический сигнал SDA мастера
  input st,                      // Импульс запуска передачи
  input clk,                     // Сигнал синхронизации
  
  input [7:0]ADR_COM,            // Адрес-команда (адрес ведомого + команда)
                                 // [7:1] - адрес ведомого
                                 // [0] - команда: 0 - запись, 1 - чтение

  input [7:0]adr_REG,            // Адрес регистра ведомого
  input [7:0]dat_REG,            // Данные для ведомого


  output reg SCL            = 1, // Сигнал SCL мастера
  output reg SDA_MASTER     = 1, // Логический сигнал SDA мастера
  
  output reg T_start        = 0, // Старт передачи
  output reg T_stop         = 0, // Стоп передачи
  
  output reg [3:0]cb_bit    = 0, // Счетчик бит
  output reg en_tx          = 0, // Разрешение передачи
  
  output wire ce_tact,           // Границы тактов
  output wire ce_bit,            // Середины тактов
  output wire ce_byte,           // Границы байт

  output wire T_AC,              // Такт подтверждения  
  output wire ce_AC,             // Строб такта T_AC
  output wire err_AC,            // Триггер подтверждения
  
  output reg [2:0]cb_byte   = 0, // Счетчик байт
  
  output reg [7:0]sr_rx_SDA = 0, // Регистр сдвига принимаемых данных
  output reg [7:0]RX_dat = 0     // Регистр данных от ведомого
);

// PULLUP Резистор
PULLUP DA1(SDA);

// Выходной буфер с третьим состоянием (SDA=SDA_MASTER & SDA_SLAVE)
BUFT DD1(.I(1'b0), .O(SDA), .T(SDA_MASTER))

parameter Fclk   = 50000000;          // Fclk = 50000 kHz
parameter Fvel   = 1250000;           // Fvel = 1250 kHz
parameter N4vel  = Fclk / (4 * Fvel); // 50000000 / (4 * 1250000) = 10
parameter N_byte = 3 ;                // Число байт (адрес ведомого, адрес регистра, данные)

reg [10:0]cb_ce = 4 * N4vel;
assign ce_tact  = (cb_ce == 1 * N4vel);         // 10, границы тактов
assign ce_bit   = (cb_ce == 3 * N4vel) & en_tx; // 30, середины тактов

reg [7:0]sr_tx_SDA = 8'h00 ; // Регистр сдвига передаваемых данных

assign T_AC  = (cb_bit == 8);                      // Такт подтверждения
wire   T_dat = en_tx & !T_start & !T_stop & !T_AC; // Такт передачи данных

assign ce_AC   = T_AC & ce_bit;                    // Строб такта T_AC
assign ce_byte = ce_tact & T_AC;                   // Границы байт

wire R_W = ADR_COM[0]; // Команда: 1-чтение, 0-запись
reg rep_st = 0;        // ?

wire [7:0]TX_dat = (cb_byte==0)?          ADR_COM : // Адрес-команда
                   (cb_byte==1)?          adr_REG : // Адрес регистра
                   ((cb_byte==2) & !R_W)? dat_REG : // Данные регистра
                   8'hFF ; 

always @ (posedge clk) begin
  
  // 3 * N4vel - задержка первого ce_bit от st
  // При импульсе запуска передачи устанавливаем задержку первого ce_bit
  // Если значение счетчика дошло до 0, устанавливаем 4 * N4vel,
  // Иначе декрементируем значение счетчика по сигналу синхронизации
  cb_ce <= st? 3 * N4vel : (cb_ce == 1)? 4 * N4vel : cb_ce-1 ; 
  
  // Старт передачи при импульсе запуска передачи, 
  // иначе по границе
  T_start <= st? 1 : ce_tact? 0 : T_start;

end

endmodule // MASTER_I2C