module debouncerCount(
    input wire clk,    // 500Hz
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

    integer rstCount, pauseCount, selCount, adjCount;

    initial 
    begin
        stepRst <= 5'b00000;
        stepPause <= 5'b00000;
        stepSel <= 5'b00000;
        stepAdj <= 5'b00000;

        rstCount <= 0;
        pauseCount <= 0;
        selCount <= 0;
        adjCount <= 0;

        prevRstB <= 0;
        prevPauseB <= 0;
        prevSelB <= 0;
        prevAdjB <= 0;
    end

    always @(posedge clk) 
    begin
        // Shift registers to store past values
        stepRst   <= {stepRst[3:0], rstB};
        stepPause <= {stepPause[3:0], pauseB};
        stepSel   <= {stepSel[3:0], selB};
        stepAdj   <= {stepAdj[3:0], adjB};

        // Detect rising edges
        if (!prevRstB && rstB) rstCount <= rstCount + 1;
        if (!prevPauseB && pauseB) pauseCount <= pauseCount + 1;
        if (!prevSelB && selB) selCount <= selCount + 1;
        if (!prevAdjB && adjB) adjCount <= adjCount + 1;

        // Output a stable high signal when the count reaches 3 (adjust as needed)
        rst   <= (rstCount >= 3) ? 1 : 0;
        pause <= (pauseCount >= 3) ? 1 : 0;
        sel   <= (selCount >= 3) ? 1 : 0;
        adj   <= (adjCount >= 3) ? 1 : 0;

        // Store previous values
        prevRstB  <= rstB;
        prevPauseB <= pauseB;
        prevSelB   <= selB;
        prevAdjB   <= adjB;
    end
endmodule
