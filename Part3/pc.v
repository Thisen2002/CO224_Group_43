module pc(CLK, RESET, PC);
    input CLK, RESET;
    output reg [31:0] PC;

    reg [31:0] PCreg;
    // Internal signals
    // wire [2:0] READREG1, READREG2, WRITEREG, ALUOP;
    always @(posedge CLK) 
    begin
        if (RESET == 1'b1) 
            begin
                #1
                PC <= 0;
                PCreg <= 0;
            end
        else 
            begin
                #1 PC = PCreg;
            end
    end

    always @(PC) 
    begin
        #1 PCreg = PCreg + 4;
    end

endmodule