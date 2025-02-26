module debouncer(
    input wire clkDis,    // Clock input
    input wire rstB,   // Reset Button
    input wire pauseB, // Pause Button

    output reg rst,    // Debounced Reset
    output reg pause,   // Debounced Pause
    output reg [2:0] m10,
    output reg [3:0] m1,
    output reg [2:0] s10,
    output reg [3:0] s1
);

    reg [2:0] stepRst, stepPause;
    reg pauseFlip;

    // Shift registers for debouncing
    always @(posedge clkDis)
    begin
        if (rst) 
        begin
            stepRst   <= 3'b000;
            stepPause <= 3'b000;
        end
        else 
        begin
            stepRst   <= {rstB, stepRst[2:1]};
            stepPause <= {pauseB, stepPause[2:1]};
        end
    end

    // Rising edge detection (Debounced)
    always @(posedge clkDis)
    begin
        if (rst) 
        begin
            rst   <= 1'b0;
            pause <= 1'b0;
            m10 <= 3'b000;
            m1 <= 4'b0000;
            s10 <= 3'b000;
            s1 <= 4'b0000;
        end 
        else if (pauseFlip)
        begin
            pause <= ~pause;
            pauseFlip <= 1'b0;
        end
        else 
        begin
            rst   <= ~stepRst[0]   & stepRst[1];
            pauseFlip <= ~stepPause[0] & stepPause[1];
        end
    end

endmodule
