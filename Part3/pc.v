
// module for the program counter
// read the instruction
module pc(CLK, RESET, PC);

    // port declaration
    input CLK, RESET;
    output reg [31:0] PC;

    reg [31:0] PCreg;
    // Internal signals
    // wire [2:0] READREG1, READREG2, WRITEREG, ALUOP;
    always @(posedge CLK) 
    begin
        if (RESET == 1'b1)             // if reset change the value of pc to 0
            begin
                #1                     
                PC = 0;
                PCreg = 0;
            end
        else                          // else assign he pcreg address to the pc
            begin
                #1 PC = PCreg;
            end
    end

    always @(PC)                       //when change the pc
    begin
        #1 PCreg = PCreg + 4;          // update program counter by 4 bytes
    end

endmodule