//module for the 32 bit mux (for beq and jump)
module mux_32(DATA1, DATA2, SELECT, OUTPUT);

//port declaration
    input [31:0] DATA1, DATA2;
    input SELECT;
    output reg [31:0] OUTPUT;
    //initial OUTPUT = 0; // Initialize OUTPUT to 0

    always @(DATA1,DATA2,SELECT) 
    begin
        if (SELECT == 1'b1)
            OUTPUT = DATA1;       // pc value for branch or jump
        else
            OUTPUT = DATA2;       // pc for next instruction
    end
endmodule

// pc value for branch or jump