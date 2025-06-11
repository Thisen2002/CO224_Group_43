module shift_2(OUTPUT, INPUT);
    input [31:0] INPUT;
    output [31:0] OUTPUT;

    // Shift the input left by 2 bits
    assign OUTPUT = INPUT << 2;
endmodule