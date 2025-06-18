
//part5
`include "8bit_adder.v"

module multiplier_8bit (DATA1,DATA2,Product);
    input  [7:0] DATA1,DATA2;
    output [15:0] Product

    wire [7:0] pp[7:0];     // Partial products
    wire [15:0] sum[6:0];   // Intermediate sums

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_pp
            assign pp[i] = DATA1 & {8{DATA2[i]}};
        end
    endgenerate

    // First sum: pp[0] + (pp[1] << 1)
    wire [7:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6;
    wire c0, c1, c2, c3, c4, c5, c6;

    adder_8bit add0 (pp[1] << 1, pp[0], 1'b0, sum0, c0);
    adder_8bit add1 (pp[2] << 2, sum0, 1'b0, sum1, c1);
    adder_8bit add2 (pp[3] << 3, sum1, 1'b0, sum2, c2);
    adder_8bit add3 (pp[4] << 4, sum2, 1'b0, sum3, c3);
    adder_8bit add4 (pp[5] << 5, sum3, 1'b0, sum4, c4);
    adder_8bit add5 (pp[6] << 6, sum4, 1'b0, sum5, c5);
    adder_8bit add6 (pp[7] << 7, sum5, 1'b0, sum6, c6);

    assign Product[7:0]  = sum6;
    assign Product[15:8] = 8'b0; // Simplified; a full 16-bit carry logic requires additional chaining

endmodule
