// part4
// sign extend the pc offset of branch and jump instructions
module signextent(OUTPUT, INPUT);
    input [7:0] INPUT;
    output [31:0] OUTPUT;

    // Sign extend the 8-bit input to a 32-bit output
    assign OUTPUT = { {24{INPUT[7]}}, INPUT };
endmodule