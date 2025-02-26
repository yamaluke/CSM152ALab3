`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2025 11:29:31 AM
// Design Name: 
// Module Name: display
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


module display(
    input wire clkDis,
    input wire clkLED,
    input wire [2:0] m10,
    input wire [3:0] m1,
    input wire [2:0] s10,
    input wire [3:0] s1,
    input wire adj,
    input wire sel,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    
    reg [1:0] digit_select;   // For digit multiplexing (0: m10, 1: m1, 2: s10, 3: s1)

    reg secStop = 0;
    reg minStop = 0;

    always @(posedge clkLED) begin
        if (adj && sel)
        secStop <= ~secStop;
        if (adj && ~sel)
            minStop <= ~minStop;
    end

    // Multiplexing 7-segment decoder
    always @(posedge clkDis) begin
        case (digit_select)
            2'b00: begin
                // Display minutes tens digit (m10)
                an = 4'b0111;  // Only m10 is active
                if(~minStop)
                begin
                    case (m10)
                        3'b000: seg = 7'b1000000;
                        3'b001: seg = 7'b1111001;
                        3'b010: seg = 7'b0100100;
                        3'b011: seg = 7'b0110000;
                        3'b100: seg = 7'b0011001;
                        3'b101: seg = 7'b0010010;
                    endcase
                end
                else
                begin
                    seg = 7'b0000000;
                end
            end
            2'b01: begin
                // Display minutes ones digit (m1)
                an = 4'b1011;  // Only m1 is active
                if(~minStop)
                begin
                    case (m1)
                        4'b0000: seg = 7'b1000000;
                        4'b0001: seg = 7'b1111001;
                        4'b0010: seg = 7'b0100100;
                        4'b0011: seg = 7'b0110000;
                        4'b0100: seg = 7'b0011001;
                        4'b0101: seg = 7'b0010010;
                        4'b0110: seg = 7'b0000010;
                        4'b0111: seg = 7'b1111000;
                        4'b1000: seg = 7'b0000000;
                        4'b1001: seg = 7'b0010000;
                    endcase
                end
                else
                begin
                    seg = 7'b0000000;
                end
            end
            2'b10: begin
                // Display seconds tens digit (s10)
                an = 4'b1101;  // Only s10 is active
                if(~secStop)
                begin
                    case (s10)
                        3'b000: seg = 7'b1000000;
                        3'b001: seg = 7'b1111001;
                        3'b010: seg = 7'b0100100;
                        3'b011: seg = 7'b0110000;
                        3'b100: seg = 7'b0011001;
                        3'b101: seg = 7'b0010010;
                    endcase
                end
                else
                begin
                    seg = 7'b0000000;
                end
            end
            2'b11: begin
                // Display seconds ones digit (s1)
                an = 4'b1110;  // Only s1 is active
                if(~secStop)
                begin
                    case (s1)
                    4'b0000: seg = 7'b1000000;
                    4'b0001: seg = 7'b1111001;
                    4'b0010: seg = 7'b0100100;
                    4'b0011: seg = 7'b0110000;
                    4'b0100: seg = 7'b0011001;
                    4'b0101: seg = 7'b0010010;
                    4'b0110: seg = 7'b0000010;
                    4'b0111: seg = 7'b1111000;
                    4'b1000: seg = 7'b0000000;
                    4'b1001: seg = 7'b0010000;
                endcase
                end
                else
                begin
                    seg = 7'b0000000;
                end
                
            end
        endcase

        // Cycle through the digits (m10, m1, s10, s1) with multiplexing
        digit_select <= digit_select + 1;
    end
endmodule

                