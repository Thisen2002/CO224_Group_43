module left(INPUT, SHIFT, OUT);
    input  [7:0] INPUT;
    input  [2:0] SHIFT;        // 3 bits are enough for 0–7 shift amount
    output reg [7:0] OUT;

    always @(INPUT or SHIFT) begin
        
        case(SHIFT)
            3'd0: OUT = INPUT;
            3'd1: OUT = {INPUT[6:0], 1'b0};
            3'd2: OUT = {INPUT[5:0], 2'b00};
            3'd3: OUT = {INPUT[4:0], 3'b000};
            3'd4: OUT = {INPUT[3:0], 4'b0000};
            3'd5: OUT = {INPUT[2:0], 5'b00000};
            3'd6: OUT = {INPUT[1:0], 6'b000000};
            3'd7: OUT = {INPUT[0],   7'b0000000};
            default: OUT = 8'b00000000;
        endcase
    end
endmodule

module right(INPUT, SHIFT, OUT);
    input  [7:0] INPUT;
    input  signed [2:0] SHIFT;
    output reg [7:0] OUT;

   always @(*) begin
        case(SHIFT)
            3'd0: OUT = INPUT;
            3'd1: OUT = {1'b0, INPUT[7:1]};
            3'd2: OUT = {2'b00, INPUT[7:2]};
            3'd3: OUT = {3'b000, INPUT[7:3]};
            3'd4: OUT = {4'b0000, INPUT[7:4]};
            3'd5: OUT = {5'b00000, INPUT[7:5]};
            3'd6: OUT = {6'b000000, INPUT[7:6]};
            3'd7: OUT = {7'b0000000, INPUT[7]};
            default: OUT = 8'b00000000;
        endcase
    end

endmodule

module arithmetic_right(INPUT, SHIFT, OUT);
    input  [7:0] INPUT;
    input  [2:0] SHIFT;      // Shift amount: 0 to 7
    output [7:0] OUT;
    reg [7:0] OUT;

    always @(*) begin
        case(SHIFT)
            3'd0: OUT = INPUT;
            3'd1: OUT = {INPUT[7],     INPUT[7:1]};
            3'd2: OUT = {INPUT[7],     INPUT[7],     INPUT[7:2]};
            3'd3: OUT = {INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7:3]};
            3'd4: OUT = {INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7:4]};
            3'd5: OUT = {INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7:5]};
            3'd6: OUT = {INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7:6]};
            3'd7: OUT = {INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7],     INPUT[7]};
            default: OUT = 8'bxxxxxxxx; // undefined
        endcase
    end
endmodule

module rotate_right(INPUT, SHIFT, OUT);
    input  [7:0] INPUT;
    input  [2:0] SHIFT;  // 0–7 only
    output [7:0] OUT;
    reg [7:0] OUT;

    always @(*) begin
        case (SHIFT)
            3'd0: OUT = INPUT;
            3'd1: OUT = {INPUT[0], INPUT[7:1]};
            3'd2: OUT = {INPUT[1:0], INPUT[7:2]};
            3'd3: OUT = {INPUT[2:0], INPUT[7:3]};
            3'd4: OUT = {INPUT[3:0], INPUT[7:4]};
            3'd5: OUT = {INPUT[4:0], INPUT[7:5]};
            3'd6: OUT = {INPUT[5:0], INPUT[7:6]};
            3'd7: OUT = {INPUT[6:0], INPUT[7]};
            default: OUT = 8'bxxxxxxxx;
        endcase
    end
endmodule
