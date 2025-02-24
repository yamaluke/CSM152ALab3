module debouncer(
    input wire clk,    // Expected to be a stable clock (e.g., 500Hz)
    input wire rstB,
    input wire pauseB,
    input wire selB,
    input wire adjB,

    output reg rst,
    output reg pause,
    output reg sel,
    output reg adj
);

    reg [4:0] stepRst;
    reg [4:0] stepPause;
    reg [4:0] stepSel;
    reg [4:0] stepAdj;

    reg prevRstB, prevPauseB, prevSelB, prevAdjB;

    initial 
    begin
        stepRst   <= 5'b00000;
        stepPause <= 5'b00000;
        stepSel   <= 5'b00000;
        stepAdj   <= 5'b00000;

        prevRstB  <= 0;
        prevPauseB <= 0;
        prevSelB   <= 0;
        prevAdjB   <= 0;
    end

    always @(posedge clk) 
    begin
        // Shift registers to debounce inputs
        stepRst   <= {stepRst[3:0], rstB};
        stepPause <= {stepPause[3:0], pauseB};
        stepSel   <= {stepSel[3:0], selB};
        stepAdj   <= {stepAdj[3:0], adjB};

        // Rising edge detection (debounced)
        rst   <= (stepRst[4:1] == 4'b0000 && stepRst[0] == 1); // Transition from 0 -> 1
        pause <= (stepPause[4:1] == 4'b0000 && stepPause[0] == 1);
        sel   <= (stepSel[4:1] == 4'b0000 && stepSel[0] == 1);
        adj   <= (stepAdj[4:1] == 4'b0000 && stepAdj[0] == 1);

        // Store previous values
        prevRstB  <= rstB;
        prevPauseB <= pauseB;
        prevSelB   <= selB;
        prevAdjB   <= adjB;
    end
endmodule
