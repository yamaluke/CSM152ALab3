module counter_modern_tb;
    reg clk;
    reg rst;
    reg pause;
    reg sel;
    reg adj;
    

    wire [2:0] m10;
    wire [3:0] m1;
    wire [2:0] s10;
    wire [3:0] s1;
    
    

    counter counter(
        .clk(clk),
        .rst(rst),
        .pause(pause),
        .sel(sel),
        .adj(adj),
        // .led(led),
        .m10(m10),
        .m1(m1),
        .s10(s10),
        .s1(s1)
    );

    initial begin
        $monitor("Clock:%d Time: %d%d:%d%d", clk, m10, m1, s10, s1);
        clk = 0;
        // rst = 1;
        

        // #1000;
        // rst = 1;
        // #10;
        // rst = 2;

        // #200;
        // pause = 1;
        // #10;
        // pause = 0;

        // #200;
        // pause = 1;
        // #10; 
        // pause = 0;

        // #300;
        // sel = 1;
        // adj = 1;

        // #200;

        #10;
        pause = 1;
        #1;
        pause = 0;

        #100;
        pause = 1;
        #1;
        pause = 0;



        #200 $finish;
    end

    always begin
        #1 clk = ~clk;
    end
endmodule