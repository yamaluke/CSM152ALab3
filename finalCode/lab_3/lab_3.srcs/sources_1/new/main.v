
`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2025 11:21:14 AM
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input btnR,
    input btnC,
    input selSwitch,
    input adjSwitch,
    output adjLED,
    output pauseLED,
    output rstLED,
    output [6:0] seg,
    output [3:0] an
);

    
    wire [31:0] clkTime;
    wire [31:0] clkAdj;
    wire [31:0] clkLED;
    wire [31:0] clkDis;
    
    wire [2:0] m10;
    wire [3:0] m1;
    wire [2:0] s10;
    wire [3:0] s1;
    
    wire rst;
    wire pause;
    
    clock_divider my_cd(clk, rst, clkTime, clkAdj, clkLED, clkDis);
//    debouncer my_debouncer(clkDis, btnR, btnC, rstpause, m10, m1, s10, s1);
    adjust_led my_adjust_led(clkLED, adjSwitch, adjLED);
    counter my_counter(clkAdj,pause, selSwitch, adjSwitch, clkDis,btnR, btnC, m10, m1, s10, s1);
    display my_display(clkDis, clkAdj, m10, m1, s10, s1, adjSwitch, selSwitch, seg, an);
    
endmodule
