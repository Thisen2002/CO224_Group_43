
// module for the mux1 and mux 2
module mux(DATA1, DATA2, SELECT, OUTPUT);
//port declaration
    input [7:0] DATA1, DATA2;
    input SELECT;
    output reg [7:0] OUTPUT;

    always @(DATA1,DATA2,SELECT) 
    begin
        if (SELECT == 1'b1)
            OUTPUT = DATA1;
        else
            OUTPUT = DATA2;
    end
endmodule
