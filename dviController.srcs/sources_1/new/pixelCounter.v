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
    input rst,
    input [0:3] CMR_PIX,
    input [0:9] PIX_MAX,
    input [0:9] LIN_MAX,
    output reg [0:9] PIX_CNT,
    output reg [0:9] LIN_CNT
    );
    
    
    reg [0:9] TMR = 10'b0;
    reg [0:9] TEMP_TMR = 10'b0;
    reg flip = 0;
    reg [0:2] ADD_STATE = 0;
    
    always @(posedge clk) begin // 100Mhz because also inverts
        if(rst) begin
            TMR = 0;
            PIX_CNT = 0;
            LIN_CNT = 0;
        end else begin
            PIX_CNT = PIX_CNT + (TMR == CMR_PIX)*(PIX_CNT != PIX_MAX) - PIX_CNT*(PIX_CNT == PIX_MAX);
            TMR = TMR + (TMR!=CMR_PIX) - TMR*(TMR == CMR_PIX);
        end
    end
endmodule
