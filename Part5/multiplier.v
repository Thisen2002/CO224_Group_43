module Fulladder(A, B, C, SUM, CARRY);
    input A, B, C;
    output SUM, CARRY;

    assign SUM = (A ^ B ^ C);
    assign CARRY = (A & B) | (C & (A ^ B));
endmodule

module multiplier( INPUT1, INPUT2, OUT);
    input  [7:0] INPUT1;
    input  [7:0] INPUT2;
    output [7:0] OUT;


    // Carry bits for intermediate sums
    wire [5:0] C0;
    wire [4:0] C1;
    wire [3:0] C2;
    wire [2:0] C3;
    wire [1:0] C4;
    wire       C5;

    // Intermediate sums
    wire [5:0] sum0;
    wire [4:0] sum1;
    wire [3:0] sum2;
    wire [2:0] sum3;
    wire [1:0] sum4;
    wire       sum5;

    // Bus to store OUTPUT before output
    wire [7:0] OUTPUT;

    // Dummy wires for unused carry outputs
    wire dummy0, dummy1, dummy2, dummy3, dummy4, dummy5, dummy6;

    // First bit of OUTPUT can be directly set
    assign OUTPUT[0] = INPUT1[0] & INPUT2[0];

    // Layer 0
    Fulladder FA0_0 (.A(INPUT1[0] & INPUT2[1]), .B(INPUT1[1] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[1]), .CARRY(C0[0]));
    Fulladder FA0_1 (.A(INPUT1[0] & INPUT2[2]), .B(INPUT1[1] & INPUT2[1]), .C(C0[0]),     .SUM(sum0[0]),   .CARRY(C0[1]));
    Fulladder FA0_2 (.A(INPUT1[0] & INPUT2[3]), .B(INPUT1[1] & INPUT2[2]), .C(C0[1]),     .SUM(sum0[1]),   .CARRY(C0[2]));
    Fulladder FA0_3 (.A(INPUT1[0] & INPUT2[4]), .B(INPUT1[1] & INPUT2[3]), .C(C0[2]),     .SUM(sum0[2]),   .CARRY(C0[3]));
    Fulladder FA0_4 (.A(INPUT1[0] & INPUT2[5]), .B(INPUT1[1] & INPUT2[4]), .C(C0[3]),     .SUM(sum0[3]),   .CARRY(C0[4]));
    Fulladder FA0_5 (.A(INPUT1[0] & INPUT2[6]), .B(INPUT1[1] & INPUT2[5]), .C(C0[4]),     .SUM(sum0[4]),   .CARRY(C0[5]));
    Fulladder FA0_6 (.A(INPUT1[0] & INPUT2[7]), .B(INPUT1[1] & INPUT2[6]), .C(C0[5]),     .SUM(sum0[5]),   .CARRY(dummy0));

    // Layer 1
    Fulladder FA1_0 (.A(sum0[0]), .B(INPUT1[2] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[2]), .CARRY(C1[0]));
    Fulladder FA1_1 (.A(sum0[1]), .B(INPUT1[2] & INPUT2[1]), .C(C1[0]),     .SUM(sum1[0]),   .CARRY(C1[1]));
    Fulladder FA1_2 (.A(sum0[2]), .B(INPUT1[2] & INPUT2[2]), .C(C1[1]),     .SUM(sum1[1]),   .CARRY(C1[2]));
    Fulladder FA1_3 (.A(sum0[3]), .B(INPUT1[2] & INPUT2[3]), .C(C1[2]),     .SUM(sum1[2]),   .CARRY(C1[3]));
    Fulladder FA1_4 (.A(sum0[4]), .B(INPUT1[2] & INPUT2[4]), .C(C1[3]),     .SUM(sum1[3]),   .CARRY(C1[4]));
    Fulladder FA1_5 (.A(sum0[5]), .B(INPUT1[2] & INPUT2[5]), .C(C1[4]),     .SUM(sum1[4]),   .CARRY(dummy1));

    // Layer 2
    Fulladder FA2_0 (.A(sum1[0]), .B(INPUT1[3] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[3]), .CARRY(C2[0]));
    Fulladder FA2_1 (.A(sum1[1]), .B(INPUT1[3] & INPUT2[1]), .C(C2[0]),     .SUM(sum2[0]),   .CARRY(C2[1]));
    Fulladder FA2_2 (.A(sum1[2]), .B(INPUT1[3] & INPUT2[2]), .C(C2[1]),     .SUM(sum2[1]),   .CARRY(C2[2]));
    Fulladder FA2_3 (.A(sum1[3]), .B(INPUT1[3] & INPUT2[3]), .C(C2[2]),     .SUM(sum2[2]),   .CARRY(C2[3]));
    Fulladder FA2_4 (.A(sum1[4]), .B(INPUT1[3] & INPUT2[4]), .C(C2[3]),     .SUM(sum2[3]),   .CARRY(dummy2));

    // Layer 3
    Fulladder FA3_0 (.A(sum2[0]), .B(INPUT1[4] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[4]), .CARRY(C3[0]));
    Fulladder FA3_1 (.A(sum2[1]), .B(INPUT1[4] & INPUT2[1]), .C(C3[0]),     .SUM(sum3[0]),   .CARRY(C3[1]));
    Fulladder FA3_2 (.A(sum2[2]), .B(INPUT1[4] & INPUT2[2]), .C(C3[1]),     .SUM(sum3[1]),   .CARRY(C3[2]));
    Fulladder FA3_3 (.A(sum2[3]), .B(INPUT1[4] & INPUT2[3]), .C(C3[2]),     .SUM(sum3[2]),   .CARRY(dummy3));

    // Layer 4
    Fulladder FA4_0 (.A(sum3[0]), .B(INPUT1[5] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[5]), .CARRY(C4[0]));
    Fulladder FA4_1 (.A(sum3[1]), .B(INPUT1[5] & INPUT2[1]), .C(C4[0]),     .SUM(sum4[0]),   .CARRY(C4[1]));
    Fulladder FA4_2 (.A(sum3[2]), .B(INPUT1[5] & INPUT2[2]), .C(C4[1]),     .SUM(sum4[1]),   .CARRY(dummy4));

    // Layer 5
    Fulladder FA5_0 (.A(sum4[0]), .B(INPUT1[6] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[6]), .CARRY(C5));
    Fulladder FA5_1 (.A(sum4[1]), .B(INPUT1[6] & INPUT2[1]), .C(C5),        .SUM(sum5),      .CARRY(dummy5));

    // Layer 6
    Fulladder FA6_0 (.A(sum5),    .B(INPUT1[7] & INPUT2[0]), .C(1'b0),      .SUM(OUTPUT[7]), .CARRY(dummy6));

    // Assign OUTPUT to OUT
    assign OUT = OUTPUT;

endmodule
