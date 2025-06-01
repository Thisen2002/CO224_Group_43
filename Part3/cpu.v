`include "reg_file.v"
`include "control_unit.v"
`include "mux.v"
`include "alu.v"
`include "two_s_comple.v"

module cpu(INSTRUCTION, RESET, CLK, PC);
    input RESET, CLK;
    input [31:0] INSTRUCTION;
    output reg [31:0] PC;

    // Internal signals
    wire [2:0] READREG1, READREG2, WRITEREG, ALUOP;
    wire [7:0] IMMEDIATE, REGOUT1, REGOUT2, IN2_S, OUT2_S, OUT_SIGN, OUT_IMM, ALURESULT;
    wire WRITEENABLE, IMM, SIGN;
    wire [7:0] OPCODE;
    reg [31:0] PCreg;

    // Instruction decoding
    assign OPCODE = INSTRUCTION[31:24];
    assign READREG1 = INSTRUCTION[15:8];
    assign WRITEREG = INSTRUCTION[23:16];
    assign READREG2 = INSTRUCTION[7:0];
    assign IMMEDIATE = INSTRUCTION[7:0];

    // Module instantiations
    reg_file reg_file_inst (
        .IN(ALURESULT),
        .OUT1(REGOUT1),
        .OUT2(REGOUT2),
        .INADDRESS(WRITEREG),
        .OUT1ADDRESS(READREG1),
        .OUT2ADDRESS(READREG2),
        .WRITE(WRITEENABLE),
        .CLK(CLK),
        .RESET(RESET)
    );

    mux mux1 (
        .DATA1(OUT2_S),
        .DATA2(REGOUT2),
        .SELECT(SIGN),
        .OUTPUT(OUT_SIGN)
    );

    two_s_comple twos_inst (
        .DATA2(REGOUT2),
        .OUTPUT(OUT2_S)
    );

    mux mux2 (
        .DATA1(IMMEDIATE),
        .DATA2(OUT_SIGN),
        .SELECT(IMM),
        .OUTPUT(OUT_IMM)
    );

    alu alu_inst (
        .DATA1(REGOUT1),
        .DATA2(OUT_IMM),
        .RESULT(ALURESULT),
        .SELECT(ALUOP)
    );

    control_unit control_inst (
        .OPCODE(OPCODE),
        .IMM(IMM),
        .SIGN(SIGN),
        .WRITEENABLE(WRITEENABLE),
        .ALUOP(ALUOP)
    );

    // PC update logic
    always @(posedge CLK) 
    begin
        if (RESET == 1'b1) 
            begin
                #1
                PC = 0;
                PCreg = 0;
            end
        else #1 PC = PCreg;
    end

    always @(PC) 
    begin
        #1 PCreg = PCreg + 4;
    end
endmodule