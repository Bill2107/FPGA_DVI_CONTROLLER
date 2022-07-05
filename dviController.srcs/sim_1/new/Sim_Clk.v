`timescale 1ns / 1ps

module SIM ();
reg clk;              // clk runs at 12Mhz
reg rst;
wire HSYNC;
wire VSYNC;
wire [0:2] VGA_DISP;
wire [0:9] PIX_CNT;

reg [0:3] CMR_PIX;
reg [0:9] PIX_MAX;
reg [0:9] LIN_MAX;
wire [0:9] PIX_CNT;
wire [0:9] LIN_CNT;

// MAKE THE UUT 
Controller TEST (
    .clk(clk),
    .rst(rst),
    .HSYNC(HSYNC),
    .VSYNC(VSYNC),
    .VGA_DISP(VGA_DISP ),
    .PIX_CNT(PIX_CNT)
);
// MAKE THE UUT  input clk,
pixelCounter TEST2 (
    .clk(clk),
    .rst(rst),
    .CMR_PIX(CMR_PIX),
    .PIX_MAX(PIX_MAX),
    .LIN_MAX(LIN_MAX ),
    .PIX_CNT(PIX_CNT),
    .LIN_CNT(LIN_CNT)
);
// GENERATE THE 12MHZ CLK
initial begin
    
    clk = 1'b0;
    rst = 1'b1;
    CMR_PIX = 500;
    PIX_MAX = 500;
    LIN_MAX = 600;
    #10 
    clk = 1'b1;
    #10 
    clk = 1'b0;
    #10 
    rst = 1'b0;
end
always
    forever #21 clk = ~clk;

endmodule : SIM
