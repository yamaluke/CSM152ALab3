module display(
    input wire clkDis,
    input wire clkAdj,
    input wire [2:0] m10,
    input wire [3:0] m1,
    input wire [2:0] s10,
    input wire [3:0] s1,
    input wire adj,
    input wire sel,
    output reg [6:0] seg,
    output reg [3:0] an
);

    reg [1:0] digit_select;  // For digit multiplexing (0: m10, 1: m1, 2: s10, 3: s1)

    // Blinking logic
    reg [8:0] blink_counter;  // 9-bit counter (can count from 0 to 511)
    reg blink_state;  // 1 = display on, 0 = display off

    // Blink logic - Blink every 125 clock cycles for ~4 Hz blink (every 0.25s at 1Hz clock)
    always @(posedge clkDis) begin
        blink_counter <= blink_counter + 1;  // Increment counter
        
        // Blink every 250 clock cycles (~4 Hz blink)
        if (blink_counter == 125) begin
            blink_counter <= 0;  // Reset the counter
            blink_state <= ~blink_state;  // Toggle the blink state (on/off)
        end
    end

    // Multiplexing 7-segment decoder
    always @(posedge clkDis) begin
        case (digit_select)
            2'b00: begin
                // Display minutes tens digit (m10)
                an = 4'b0111;  // Only m10 is active
                if (adj && ~sel) begin
                    if (~blink_state) begin
                        seg = 7'b1111111;  // Blink (turn off)
                    end else begin
                        case (m10)
                            3'b000: seg = 7'b1000000;
                            3'b001: seg = 7'b1111001;
                            3'b010: seg = 7'b0100100;
                            3'b011: seg = 7'b0110000;
                            3'b100: seg = 7'b0011001;
                            3'b101: seg = 7'b0010010;
                            default: seg = 7'b1111111; // Default off state
                        endcase
                    end
                end else begin
                    case (m10)
                        3'b000: seg = 7'b1000000;
                        3'b001: seg = 7'b1111001;
                        3'b010: seg = 7'b0100100;
                        3'b011: seg = 7'b0110000;
                        3'b100: seg = 7'b0011001;
                        3'b101: seg = 7'b0010010;
                        default: seg = 7'b1111111; // Default off state
                    endcase  // Display off when minStop is active
                end
            end
            2'b01: begin
                // Display minutes ones digit (m1)
                an = 4'b1011;  // Only m1 is active
                if (adj && ~sel) begin
                    if (~blink_state) begin
                        seg = 7'b1111111;  // Blink (turn off)
                    end else begin
                        case (m1)
                            4'b0000: seg = 7'b1000000;
                            4'b0001: seg = 7'b1111001;
                            4'b0010: seg = 7'b0100100;
                            4'b0011: seg = 7'b0110000;
                            4'b0100: seg = 7'b0011001;
                            4'b0101: seg = 7'b0010010;
                            4'b0110: seg = 7'b0000010;
                            4'b0111: seg = 7'b1111000;
                            4'b1000: seg = 7'b0000000;
                            4'b1001: seg = 7'b0010000;
                            default: seg = 7'b1111111; // Default off state
                        endcase
                    end
                end else begin
                    case (m1)
                        4'b0000: seg = 7'b1000000;
                        4'b0001: seg = 7'b1111001;
                        4'b0010: seg = 7'b0100100;
                        4'b0011: seg = 7'b0110000;
                        4'b0100: seg = 7'b0011001;
                        4'b0101: seg = 7'b0010010;
                        4'b0110: seg = 7'b0000010;
                        4'b0111: seg = 7'b1111000;
                        4'b1000: seg = 7'b0000000;
                        4'b1001: seg = 7'b0010000;
                        default: seg = 7'b1111111; // Default off state
                    endcase  // Display off when minStop is active
                end
            end
            2'b10: begin
                // Display seconds tens digit (s10)
                an = 4'b1101;  // Only s10 is active
                if (adj && sel) begin
                    if (~blink_state) begin
                        seg = 7'b1111111;  // Blink (turn off)
                    end else begin
                        case (s10)
                            3'b000: seg = 7'b1000000;
                            3'b001: seg = 7'b1111001;
                            3'b010: seg = 7'b0100100;
                            3'b011: seg = 7'b0110000;
                            3'b100: seg = 7'b0011001;
                            3'b101: seg = 7'b0010010;
                            default: seg = 7'b1111111; // Default off state
                        endcase
                    end
                end else begin
                    case (s10)
                        3'b000: seg = 7'b1000000;
                        3'b001: seg = 7'b1111001;
                        3'b010: seg = 7'b0100100;
                        3'b011: seg = 7'b0110000;
                        3'b100: seg = 7'b0011001;
                        3'b101: seg = 7'b0010010;
                        default: seg = 7'b1111111; // Default off state
                    endcase  // Display off when secStop is active
                end
            end
            2'b11: begin
                // Display seconds ones digit (s1)
                an = 4'b1110;  // Only s1 is active
                if (adj && sel) begin
                    if (~blink_state) begin
                        seg = 7'b1111111;  // Blink (turn off)
                    end else begin
                        case (s1)
                            4'b0000: seg = 7'b1000000;
                            4'b0001: seg = 7'b1111001;
                            4'b0010: seg = 7'b0100100;
                            4'b0011: seg = 7'b0110000;
                            4'b0100: seg = 7'b0011001;
                            4'b0101: seg = 7'b0010010;
                            4'b0110: seg = 7'b0000010;
                            4'b0111: seg = 7'b1111000;
                            4'b1000: seg = 7'b0000000;
                            4'b1001: seg = 7'b0010000;
                            default: seg = 7'b1111111; // Default off state
                        endcase
                    end
                end else begin
                    case (s1)
                        4'b0000: seg = 7'b1000000;
                        4'b0001: seg = 7'b1111001;
                        4'b0010: seg = 7'b0100100;
                        4'b0011: seg = 7'b0110000;
                        4'b0100: seg = 7'b0011001;
                        4'b0101: seg = 7'b0010010;
                        4'b0110: seg = 7'b0000010;
                        4'b0111: seg = 7'b1111000;
                        4'b1000: seg = 7'b0000000;
                        4'b1001: seg = 7'b0010000;
                        default: seg = 7'b1111111; // Default off state
                    endcase   // Display off when secStop is active
                end
            end
        endcase
        
        // Cycle through the digits (m10, m1, s10, s1) with multiplexing
        digit_select <= digit_select + 1;
        if (digit_select > 2'b11) digit_select <= 2'b00;  // Reset digit select after 3 digits
    end

endmodule
