`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2025 10:33:02 AM
// Design Name: 
// Module Name: adjust_led
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


module adjust_led(
    input wire clkLED,
    input wire adj,
    output reg adjLED
    );
    
    always @(posedge clkLED) begin
        if(adj)
        begin
            adjLED <= ~adjLED;
        end
        else
        begin
            adjLED <= 0;
        end
    end
    
endmodule
