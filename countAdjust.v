module clock_adjust(
    input wire clk,
    // input wire rst,
    input wire sel,
    input wire adj,

    input wire [2:0] m10i,
    input wire [3:0] m1i,
    input wire [2:0] s10i,
    input wire [3:0] s1i,
    
    output reg led,
    output reg [2:0] m10,
    output reg [3:0] m1,
    output reg [2:0] s10,
    output reg [3:0] s1
);

always@(posedge clk)
begin
   if(adj)
   begin
        m10 = m10i;
        m1 = m1i;
        s10 = s1i;
        s1 = s1i;

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

end

endmodule