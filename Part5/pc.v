// module for the program counter
// read the instruction
module pc(CLK, RESET, NEW_PC, PC);

    // port declaration
    input CLK, RESET;
    input [31:0] NEW_PC;         // New PC value to jump to if nonzero
    output reg [31:0] PC;

    reg [31:0] PCreg;

    always @(posedge CLK) 
    begin
        if (RESET) begin
            #1 PCreg = 0;
            PC = 0;
        end
        else if (NEW_PC != PCreg) begin
            #1 PCreg = NEW_PC;
            PC = PCreg;
        end
        else begin
            #1 PCreg = PCreg + 4;
            PC = PCreg;
        end
    end
endmodule