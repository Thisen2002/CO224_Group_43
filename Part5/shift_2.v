module shift_2(OUTPUT, INPUT);
    input signed [31:0] INPUT;
    output signed [31:0] OUTPUT;

    // Shift the input left by 2 bits
    assign OUTPUT = INPUT <<< 2;
endmodule