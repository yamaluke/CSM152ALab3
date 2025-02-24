`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 10:44:15 AM
// Design Name: 
// Module Name: counter
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


module counter(
    input wire clk, //feed 2hz
    input wire rst,
    input wire pause,
    input wire sel,
    input wire adj,

    output reg [2:0] m10,
    output reg [3:0] m1,
    output reg [2:0] s10,
    output reg [3:0] s1
    );

    logic clk1 = 1;

    reg paused = 0;
    
    initial 
    begin
        m10 <= 3'b000;
        m1 <= 4'b0000;
        s10 <= 3'b000;
        s1 <= 4'b0000;
    end

    always @(posedge clk) 
    begin
        if(paused)
        begin
            if(pause)
            begin
                paused <= ~paused;
            end
        end
        else
        begin
            if(pause)
            begin
                paused <= ~paused;
            end
            else if(rst) 
            begin
                m10 <= 3'b000;
                m1 <= 4'b0000;
                s10 <= 3'b000;
                s1 <= 4'b0000;
            end
            else if(adj)
            begin
                if(sel) //seconds
                begin
                    s1 <= s1 +1;
                    if(s1 == 9)
                    begin
                        s10 <= s10+1;
                        s1 <= 0;
                        if(s10 == 5)
                        begin
                            s10 <= 0;
                        end
                    end
                end 
                else
                begin
                    m1 <= m1 +1;
                    if(m1 == 9)
                    begin
                        m10 <= m10+1;
                        m1 <= 0;
                        if(m10 == 5)
                        begin
                            m10 <= 0;
                        end
                    end
                end
            end
            else if (clk1)
            begin
                s1 <= s1 + 1;
                if (s1 == 9)
                begin
                    s10 <= s10 + 1;
                    s1 <= 0;
                    if (s10 == 5)
                    begin
                        m1 <= m1 + 1;
                        s10 <= 0;
                        if (m1 == 9)
                        begin
                            m10 <= m10 + 1;
                            m1 <= 0;
                            if (m10 == 5)
                            begin
                                m10 <= 0;
                            end
                        end
                    end
                end
            end 
            clk1 <= ~clk1;
        end
    end
endmodule
