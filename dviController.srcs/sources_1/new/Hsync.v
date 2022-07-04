`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2022 21:29:39
// Design Name: 
// Module Name: Hsync
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


module Hsync(
    input PIX_CNT,
    output reg PLOT_VIS,
    output reg HSYNC_LINE
    );
    
    always @(PIX_CNT) begin
        if(PIX_CNT > 640)begin // VISIBLE AREA
            PLOT_VIS = 1;
        end else if (PIX_CNT > 640 + 16)begin // FRONT PORCH
            PLOT_VIS = 0;
        end else if (PIX_CNT > 640 + 16 + 96)begin // SYNC PULSE
            HSYNC_LINE = 1;
        end else if (PIX_CNT > 640 + 16 + 96 + 48)begin // BACK PORCH
            HSYNC_LINE = 0;
        
        end
    end
    
endmodule
