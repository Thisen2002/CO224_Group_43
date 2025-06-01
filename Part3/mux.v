module mux(DATA1, DATA2, SELECT, OUTPUT);
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
