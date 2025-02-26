// module debouncer_modern_tb;
//     reg clk,    // Clock input
//     reg rstB,   // Reset Button
//     reg pauseB, // Pause Button

//     wire rst,    // Debounced Reset
//     wire pause,   // Debounced Pause
//     wire [2:0] m10,
//     wire [3:0] m1,
//     wire [2:0] s10,
//     wire [3:0] s1
    
//     debouncer debouncer(
//         .clk(clk),    // Clock input
//         .rstB(rstB),   // Reset Button
//         .pauseB(pauseB), // Pause Button

//         .rst(rst),    // Debounced Reset
//         .pause(pause),   // Debounced Pause
//         .m10(m10),
//         .m1(m1),
//         .s10(s10),
//         .s1(s1)
//     )

//     initial begin
//         $monitor("rstB: %d pauseB:%d rst:%d pause:%d Time: %d%d:%d%d", clk, m10, m1, s10, s1);
//         clk = 0;
//         // rst = 1;
        

//         // #1000;
//         // rst = 1;
//         // #10;
//         // rst = 2;

//         // #200;
//         // pause = 1;
//         // #10;
//         // pause = 0;

//         // #200;
//         // pause = 1;
//         // #10; 
//         // pause = 0;

//         // #300;
//         // sel = 1;
//         // adj = 1;

//         // #200;

//         #10;
//         pause = 1;
//         #1;
//         pause = 0;

//         #100;
//         pause = 1;
//         #1;
//         pause = 0;



//         #200 $finish;
//     end

//     always begin
//         #1 clk = ~clk;
//     end
// endmodule