/*
Group 43
Thisen Lakdinu, Shashika sathsarani
Microprocessor implementation part-1 test case.
Date:-20/05/2025
*/

/*
Refer "Documnetation file for details about the code implementation."
*/

`include "alu.v"        //both files has to be in a one folder so we can import it using this syntax.

module testbench();
    reg[7:0] DATA1, DATA2;      //Act as like a veriable to store the data
    reg[2:0] SELECT;
    wire[7:0] RESULT;           //hellp to carryout the signal

    alu a3(DATA1, DATA2, RESULT, SELECT);       //

    initial 
    begin
        $monitor("Time:=%0d DATA1:-%b DATA2:-%b RESULT:-%b SELECT:-%b",$time,DATA1, DATA2, RESULT, SELECT);     //Give outputs to the terminal.
        $dumpfile("ALU.vcd");                                                       //vcd file generate.
        $dumpvars(0, testbench);                                                    //only testbench varibles will be recorded.

        DATA1 = 8'b00000011; DATA2 = 8'b00000001; SELECT = 3'b000;                  //Testing the module
        #10 DATA1 = 8'b00000011; DATA2 = 8'b00000001; SELECT = 3'b001;
        #20 DATA1 = 8'b00000011; DATA2 = 8'b00000001; SELECT = 3'b010;
        #30 DATA1 = 8'b00000011; DATA2 = 8'b00000001; SELECT = 3'b011;
        #40 DATA1 = 8'b00000010; DATA2 = 8'b00000101; SELECT = 3'b001;
        
    end

endmodule