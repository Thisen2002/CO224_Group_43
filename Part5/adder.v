//part4 
//dder for calculate thr next pc values for branch and jump instructions

module adder(OUTPUT,DATA1,DATA2);

    input signed [31:0] DATA1,DATA2;
    output reg signed [31:0] OUTPUT;
    always @(*) 
    begin
        #2 OUTPUT = DATA1 + DATA2;
    end
endmodule