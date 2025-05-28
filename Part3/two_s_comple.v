module two_s_comple(DATA2, OUTPUT);
    input [7:0] DATA2;
    output [7:0] OUTPUT;

    assign #1 OUTPUT = ~DATA2 + 1;
endmodule
