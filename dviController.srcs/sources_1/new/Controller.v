`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2022 19:30:50
// Design Name: 
// Module Name: Controller
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


module Controller(
    input clk,              // vgaClk runs at 100Mhz
    output HSYNC,
    output VSYNC,
    output [0:2] VGA_DISP
   // output Hsync,           // THE HYSNC LINE
   // output Vsync,           // THE VYNC LINE
   // output [2:0] Display    // THE 3 DISPLAY OUTPUT PINS
    );
    
    wire vgaClock;
    vgaClk pixelClock(vgaClock, clk);
    
    reg [0:2] DISPLAY_REG;
    assign VGA_DISP = DISPLAY_REG;
     
    reg VAL;
    wire PIX_CNT;
    wire LIN_CNT;
    
    wire CMR_PIXEL;
    wire PIX_MAX;
    wire LIN_MAX;
    assign CMR_PIXEL  = 4'd8; // we want the pixel freq = 25.175MHz, so  every 4 clk ticks (8 including inverts)
    assign PIX_MAX = 10'd800; // no more than 800 pixels per line!
    assign LIN_MAX = 10'd525; // no more than 800 pixels per frame!

    pixelCounter PC(vgaClock, CMR_PIXEL, PIX_MAX, LIN_MAX, PIX_CNT, LIN_CNT);
    
    wire PLOT_VIS;    
    Hsync HS(PIX_CNT, PLOT_VIS, HSYNC);
    Vsync VS(LIN_CNT, VSYNC);

    always @(vgaClock) begin
        if(PLOT_VIS == 1) begin
            DISPLAY_REG = 3'b111;
        end else begin
            DISPLAY_REG = 3'b000;
        end
    end
endmodule
