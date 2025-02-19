module debouncer(
    input wire clk, //feed 500hz?
    input wire rstB,
    input wire pauseB,
    input wire selB,
    input wire adjB,

    output reg rst,
    output reg pause,
    output reg sel,
    output reg adj
    );

    // logic clk1 = 1;

    reg[4:0] stepRst;
    reg[4:0] stepPause;
    reg[4:0] stepSel;
    reg[4:0] stepAdj;

    integer rstCount;
    integer pauseCount;
    integer selCount;
    integer adjCount;
    
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
    end

    always @(posedge clk) 
    begin

        if(rstB)
        begin
            if(stepRst[4] == 0)
            begin
                rstCount <= rstCount + 1;
            end
        end
        else
        begin
            if(stepRst[4] == 1)
            begin
                rstCount <= rstCount - 1;
            end
        end
        if(rstCount >= 3)
        begin
            rst <= 1;
        end
        else
        begin
            rst <= 0;
        end


        if(pauseB)
        begin
            if(stepPause[4] == 0)
            begin
                pauseCount <= pauseCount + 1;
            end
        end
        else
        begin
            if(stepPause[4] == 1)
            begin
                pauseCount <= pauseCount - 1;
            end
        end
        if(pauseCount >= 3)
        begin
            pause <= 1;
        end
        else
        begin
            pause <= 0;
        end


        if(selB)
        begin
            if(stepSel[4] == 0)
            begin
                selCount <= selCount + 1;
            end
        end
        else
        begin
            if(stepSel[4] == 1)
            begin
                selCount <= selCount - 1;
            end
        end
        if(selCount >= 3)
        begin
            sel <= 1;
        end
        else
        begin
            sel <= 0;
        end

        
        if(adjB)
        begin
            if(stepAdj[4] == 0)
            begin
                adjCount <= adjCount + 1;
            end
        end
        else
        begin
            if(stepAdj[4] == 1)
            begin
                adjCount <= adjCount - 1;
            end
        end
        if(adjCount >= 3)
        begin
            adj <= 1;
        end
        else
        begin
            adj <= 0;
        end

        stepRst <= {stepRst[3:0], rstB};
        stepPause <= {stepPause[3:0], pauseB};
        stepSel <= {stepSel[3:0], selB};
        stepAdj <= {stepAdj[3:0], adjB};

    end
endmodule
