/*
Group 43
Thisen Lakdinu, Shashika sathsarani
Microprocessor implementation part-1 test case.
Date:-20/05/2025
*/


// DATA1 and DATA2 are the inputs
// module for function add and sub
module addunit (DATA1, DATA2, RESULT);
    input[7:0] DATA1, DATA2;
    output[7:0] RESULT;
    
    assign #2 RESULT =  DATA1 + DATA2;
endmodule

//module for function forwarad
module forward (DATA2, RESULT);
    input[7:0] DATA2;
    output[7:0] RESULT;

    assign  #1 RESULT = DATA2;
endmodule

//module for function and
module andunit (DATA1, DATA2, RESULT);
    input[7:0] DATA1, DATA2;
    output[7:0] RESULT;

    assign #1 RESULT = DATA1 & DATA2;
endmodule

//module for function or
module orunit (DATA1, DATA2, RESULT);
    input[7:0] DATA1, DATA2;
    output[7:0] RESULT;

    assign #1 RESULT = DATA1 | DATA2;
endmodule

//module for alu unit
module alu (DATA1, DATA2, RESULT, SELECT);
    input[7:0] DATA1, DATA2;
    input[2:0] SELECT;
    output reg[7:0] RESULT;
    wire [7:0] forward_out, add_out, and_out, or_out;

    forward fwd (.DATA2(DATA2), .RESULT(forward_out));               //instance for forkward
    addunit add (.DATA1(DATA1), .DATA2(DATA2), .RESULT(add_out));    //instance for add
    andunit andg (.DATA1(DATA1), .DATA2(DATA2), .RESULT(and_out));   //instance for and
    orunit org (.DATA1(DATA1), .DATA2(DATA2), .RESULT(or_out));      //instance for or


    //multiplexer for selector input
    always @(forward_out or add_out or and_out or or_out or SELECT) 
    begin
        if (SELECT == 3'b000)           //forward
            //forward fwd (.DATA2(DATA2), .RESULT(RESULT));
            RESULT = forward_out;
        else if (SELECT == 3'b001)     //add
            RESULT = add_out;
        else if (SELECT == 3'b010)     //and
            RESULT = and_out;
        else if (SELECT == 3'b011)     //or
            RESULT = or_out;
    end
endmodule