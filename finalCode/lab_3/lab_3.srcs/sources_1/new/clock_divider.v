`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 11:52:31 AM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input wire clk,
    input wire rst,
    output reg clkTime,
    output reg clkAdj,
    output reg clkLED,
    output reg clkDis
    );
    
    reg [31:0] countTime;
    reg [31:0] countAdj;
    reg [31:0] countLED;
    reg [31:0] countDis;
    
    always@(posedge clk)
    begin
        if (rst)
        begin
            countTime <= 0;
            countAdj <= 0;
            countLED <= 0;
            countDis <= 0;
            clkTime <= 0;
            clkAdj <= 0;
            clkLED <= 0;
            clkDis <= 0;
        end
        
        if (countDis == 100000)
        begin
            clkDis <= ~clkDis;
            countDis <= 0;
        end
        else
        begin
            countDis <= countDis + 1;
        end
        
        if (countLED == 10000000)
        begin
            clkLED <= ~clkLED;
            countLED <= 0;
        end
        else
        begin
            countLED <= countLED + 1;
        end
        
        if (countAdj == 25000000)
        begin
            clkAdj <= ~clkAdj;
            countAdj <= 0;
        end
        else
        begin
            countAdj <= countAdj + 1;
        end
        
        if (countTime == 50000000)
        begin
            clkTime <= ~clkTime;
            countTime <= 0;
        end
        else
        begin
            countTime <= countTime + 1;           
        end
    end
    
endmodule
