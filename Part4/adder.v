

module adder(OUTPUT,DATA1,DATA2);

    input [31:0] DATA1,DATA2;
    output [31:0] OUTPUT;

    #2
    assign OUTPUT = DATA1 + DATA2;

endmodule