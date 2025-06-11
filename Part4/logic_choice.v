module logic(OUTPUT, J, BEQ, ZERO);
    input J, BEQ, ZERO;
    output OUTPUT;

    // Logic to determine the output based on J and BEQ
    assign OUTPUT = (J | (BEQ & ZERO));
    // If J is true, OUTPUT is true; if BEQ is true and ZERO is true, OUTPUT is also true
    // Otherwise, OUTPUT is false
endmodule