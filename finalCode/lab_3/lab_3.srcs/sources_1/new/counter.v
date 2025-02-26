module counter(
    //for counter
    input wire clkAdj, //feed 2hz
//    output reg rst,
    output reg pause,
    input wire sel,
    input wire adj,

    // for debouncing
    input wire clkDis,    // Clock input
    input wire rstB,   // Reset Button
    input wire pauseB, // Pause Button

    output reg [2:0] m10,
    output reg [3:0] m1,
    output reg [2:0] s10,
    output reg [3:0] s1
    );

    reg clk1 = 1;
    reg rst = 0;
    reg reset = 0;

    reg [2:0] stepRst, stepPause;
    reg pauseFlip = 0;
    
    initial 
    begin
        m10 <= 3'b000;
        m1 <= 4'b0000;
        s10 <= 3'b000;
        s1 <= 4'b0000;
    end

    always @(posedge clkAdj) 
    begin
//        reset <= 0;
        if(pause)
        begin
        end
        else if(reset) 
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
            reset <= rstB;
            stepPause <= {pauseB, stepPause[2:1]};
        end
    end

    // Rising edge detection (Debounced)
    always @(posedge clkDis)
    begin
        if (rst == 1) 
        begin
            rst   <= 1'b0;
            pause <= 1'b0;
            pauseFlip <= 0;
//            m10 <= 3'b000;
//            m1 <= 4'b0000;
//            s10 <= 3'b000;
//            s1 <= 4'b0000;
        end 
        else if (pauseFlip)
        begin
            pause <= ~pause;
            pauseFlip <= 1'b0;
        end
        else 
        begin
            rst   <= ~stepRst[0]   & stepRst[1];
//            rst <= 0;
            pauseFlip <= ~stepPause[0] & stepPause[1];
        end
    end

endmodule