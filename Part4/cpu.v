`include "reg_file.v"
`include "control_unit.v"
`include "mux.v"
`include "alu.v"
`include "two_s_comple.v"
`include "pc.v"
//new
`include "shift_2.v"
`include "signextent.v"
`include "logic_choice.v"
`include "mux_32.v"
`include "adder.v"

module cpu(INSTRUCTION, RESET, CLK, PC);
    input RESET, CLK;
    input [31:0] INSTRUCTION;
    output  [31:0] PC;

    // Internal signals
    wire [2:0] READREG1, READREG2, WRITEREG, ALUOP;
    wire [7:0] IMMEDIATE, REGOUT1, REGOUT2, IN2_S, OUT2_S, OUT_SIGN, OUT_IMM, ALURESULT;
    wire WRITEENABLE, IMM, SIGN;
    wire [7:0] OPCODE;
    reg [31:0] PCreg;

    //new
    
    wire [7:0] OFFSET;
    wire [31:0] EXT_OUT, SHIFT_OUT, PC_NEW, MUX_32_IN;
    wire ZERO_OUT, JUMP_OUT, BEQ_OUT, LOGIC_OUT;

    // Instruction decoding
    assign OPCODE = INSTRUCTION[31:24];
    assign READREG1 = INSTRUCTION[15:8];
    assign WRITEREG = INSTRUCTION[23:16];
    assign READREG2 = INSTRUCTION[7:0];
    assign IMMEDIATE = INSTRUCTION[7:0];
    assign OFFSET = INSTRUCTION[23:16];

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
        .SELECT(ALUOP),
        .ZERO(ZERO_OUT)
    );

    control_unit control_inst (
        .OPCODE(OPCODE),
        .IMM(IMM),
        .SIGN(SIGN),
        .WRITEENABLE(WRITEENABLE),
        .ALUOP(ALUOP),
        .J(JUMP_OUT),
        .BEQ(BEQ_OUT)
    );

    pc pc1(
        .CLK(CLK),
        .RESET(RESET),
        .PC(MUX_32_IN),
        .NEW_PC(PC)
    );

    //part4
    signextent signextent_inst (
        .INPUT(OFFSET),
        .OUTPUT(EXT_OUT)
    );

    shift_2 shift_2_inst (
        .INPUT(EXT_OUT),
        .OUTPUT(SHIFT_OUT)
    );

    adder adder_inst (
        .DATA1(MUX_32_IN),
        .DATA2(SHIFT_OUT),
        .OUTPUT(PC_NEW)
    );

    mux_32 mux_32_inst (
        .DATA1(PC_NEW), // Next PC value
        .DATA2(MUX_32_IN), // Jump address
        .SELECT(LOGIC_OUT),
        .OUTPUT(PC)
    );

    logic_choice logic_inst (
        .OUTPUT(LOGIC_OUT),
        .J(JUMP_OUT),
        .BEQ(BEQ_OUT),
        .ZERO(ZERO_OUT)
    );


    

    // // PC update logic
    // always @(posedge CLK) 
    // begin
    //     if (RESET == 1'b1) 
    //         begin
    //             #1
    //             PC = 0;
    //             PCreg = 0;
    //         end
    //     else #1 PC = PCreg;
    // end

    // always @(PC) 
    // begin
    //     #1 PCreg = PCreg + 4;
    // end
endmodule