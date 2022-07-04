`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2022 21:22:47
// Design Name: 
// Module Name: pixelCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pixelCounter(
    input clk,
    input CMR_PIX,
    input PIX_MAX,
    input LIN_MAX,
    output reg [0:9] PIX_CNT,
    output reg [0:9] LIN_CNT
    );
    
    reg TMR;
    
    always @(clk) begin // 24Mhz because also inverts
        TMR = TMR + 1;
        if(TMR == CMR_PIX) begin
        PIX_CNT = PIX_CNT + 1;
        TMR = 0;
        end
        if(PIX_CNT > PIX_MAX) begin
            PIX_CNT  = 0;
            LIN_CNT = LIN_CNT + 1;
        end
        if(LIN_CNT>LIN_MAX) LIN_CNT = 0;
    end
endmodule
