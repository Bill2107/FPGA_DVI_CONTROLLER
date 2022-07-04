`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2022 21:46:44
// Design Name: 
// Module Name: Vsync
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


module Vsync(
    input LIN_CNT,
    output reg VSYNC
    );
    
        always @(LIN_CNT) begin
        if(LIN_CNT > 480)begin // VISIBLE AREA
        end else if (LIN_CNT > 480 + 10)begin // FRONT PORCH
        end else if (LIN_CNT > 480 + 10 + 2)begin // SYNC PULSE
            VSYNC = 1;
        end else if (LIN_CNT > 480 + 10 + 2 + 33)begin // BACK PORCH
            VSYNC = 0;
        
        end
    end
endmodule
