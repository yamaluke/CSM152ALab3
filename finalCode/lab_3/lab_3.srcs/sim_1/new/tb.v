`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 10:47:02 AM
// Design Name: 
// Module Name: tb
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


module tb;
    reg clk;
    reg rst;
    wire [2:0] m10;
    wire [3:0] m1;
    wire [2:0] s10;
    wire [3:0] s1;
    
    counter my_counter(clk, rst, m10,m1, s10, s1);
    
    initial begin
        $monitor("Clock: %d%d:%d%d", m10, m1, s10, s1);
        clk = 0;
        rst = 1;
        #10
        rst = 0;
        
        #500 $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
endmodule
