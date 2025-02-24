module debouncer(
    input wire clkDis,    // Clock input
    input wire rstB,   // Reset Button
    input wire pauseB, // Pause Button

    output reg rst,    // Debounced Reset
    output reg pause,  // Debounced Pause
);

    reg [2:0] stepRst, stepPause;
    reg clk_en_d;

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
        end 
        else 
        begin
            rst   <= ~stepRst[0]   & stepRst[1];
            pause <= ~stepPause[0] & stepPause[1];
        end
    end

endmodule
