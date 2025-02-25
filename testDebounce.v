module debouncer(
    input wire clkDis,    // Clock input
    input wire rstB,      // Reset Button
    input wire pauseB,    // Pause Button

    output reg rst,       // Debounced Reset
    output reg pause,     // Debounced Pause
    output reg [2:0] m10,
    output reg [3:0] m1,
    output reg [2:0] s10,
    output reg [3:0] s1
);

    reg [2:0] stepRst, stepPause;
    reg pauseFlip;
    reg rstPulse; // New register to generate a reset pulse

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

    // Generate a single-cycle reset pulse
    always @(posedge clkDis)
    begin
        rstPulse <= ~stepRst[0] & stepRst[1];  // Detects a rising edge
        if (rstPulse) 
        begin
            rst   <= 1'b1;
        end
        else 
        begin
            rst   <= 1'b0;  // Ensure rst goes low after one cycle
        end
    end

    // Pause toggle logic
    always @(posedge clkDis)
    begin
        if (rst) 
        begin
            pause   <= 1'b0;
            m10     <= 3'b000;
            m1      <= 4'b0000;
            s10     <= 3'b000;
            s1      <= 4'b0000;
        end 
        else if (pauseFlip)
        begin
            pause <= ~pause;
            pauseFlip <= 1'b0;
        end
        else 
        begin
            pauseFlip <= ~stepPause[0] & stepPause[1];
        end
    end

endmodule
