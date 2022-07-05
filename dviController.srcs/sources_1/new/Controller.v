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
    input rst,
    output HSYNC,
    output VSYNC,
    output [0:2] VGA_DISP,
    output [0:9] PIX_CNT
   // output Hsync,           // THE HYSNC LINE
   // output Vsync,           // THE VYNC LINE
   // output [2:0] Display    // THE 3 DISPLAY OUTPUT PINS
    );
    
    wire vgaClock;
    vgaClk pixelClock(vgaClock, clk);
    
    reg [0:2] DISPLAY_REG;
    assign VGA_DISP = DISPLAY_REG;
     
    reg VAL = 1'b0;
    //wire [0:9] PIX_CNT;
    wire [0:9] LIN_CNT;
    
    wire [0:3] CMR_PIXEL;
    wire [0:9]PIX_MAX;
    wire [0:9]LIN_MAX;
    assign CMR_PIXEL =  4'd8; // we want the pixel freq = 25.175MHz, so  every 4 clk ticks (8 including inverts)
    assign PIX_MAX = 10'd800; // no more than 800 pixels per line!
    assign LIN_MAX = 10'd525; // no more than 800 pixels per frame! wtf :)

    pixelCounter PC(vgaClock, rst, CMR_PIXEL, PIX_MAX, LIN_MAX, PIX_CNT, LIN_CNT);
    
    wire PLOT_VIS;    
    Hsync HS(PIX_CNT, PLOT_VIS, HSYNC);
    Vsync VS(LIN_CNT, VSYNC);

    always @(posedge vgaClock) begin
        if(PLOT_VIS == 1) begin
            DISPLAY_REG = 3'b111;
        end else begin
            DISPLAY_REG = 3'b000;
        end
    end
endmodule
