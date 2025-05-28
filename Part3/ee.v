/*********************************/
/* CO224 - Computer Architecture */
/* Lab 05 - Part 3               */
/* CPU Module                    */
/*********************************/

`include "alu.v"
`include "reg_file.v"
`include "control_unit.v"
`include "mux.v"
`include "two_s_comple.v"

module top_level_cpu(PC, INSTRUCTION, CLK, RESET);

    // Input Port Declaration
    input [31:0] INSTRUCTION;
    input CLK, RESET;

    // Output Port Declaration
    output reg [31:0] PC;

    // Connections for Register File
    wire [2:0] READREG1, READREG2, WRITEREG;
    wire [7:0] REGOUT1, REGOUT2;
    reg WRITEENABLE;

    // Connections for ALU
    wire [7:0] OPERAND1, OPERAND2, ALURESULT;
    reg [2:0] ALUOP;

    // Connections for negation MUX
    wire [7:0] negatedOp;
    wire [7:0] registerOp;
    reg signSelect;

    // Connections for immediate value MUX
    wire [7:0] IMMEDIATE;
    reg immSelect;

    // PC value stored inside CPU
    reg [31:0] PCreg;

    // Current OPCODE stored in CPU
    reg [7:0] OPCODE;

    // Instantiation of CPU modules
    reg_file my_reg(ALURESULT, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);

    alu my_alu(REGOUT1, OPERAND2, ALURESULT, ALUOP);

    two_s_comple my_twosComp(REGOUT2, negatedOp);

    mux negationMUX(REGOUT2, negatedOp, signSelect, registerOp);

    mux immediateMUX(registerOp, IMMEDIATE, immSelect, OPERAND2);

    //-----------------------
    // Control Logic for CPU
    //-----------------------

    // PC Update
    always @ (posedge CLK)
    begin
        if (RESET == 1'b1)
        begin
            #1
            PC = 0;
            PCreg = 0;
        end
        else #1 PC = PCreg;
    end

    // PC+4 Adder
    always @ (PC)
    begin
        #1 PCreg = PCreg + 4;
    end

    // Relevant portions of INSTRUCTION are mapped to the respective units
    assign READREG1 = INSTRUCTION[15:8];
    assign IMMEDIATE = INSTRUCTION[7:0];
    assign READREG2 = INSTRUCTION[7:0];
    assign WRITEREG = INSTRUCTION[23:16];

    // Decoding the instruction
    always @ (INSTRUCTION)
    begin
        OPCODE = INSTRUCTION[31:24];

        #1

        case (OPCODE)
            // loadi instruction
            8'b00000000: begin
                ALUOP = 3'b000;
                immSelect = 1'b1;
                signSelect = 1'b0;
                WRITEENABLE = 1'b1;
            end

            // mov instruction
            8'b00000001: begin
                ALUOP = 3'b000;
                immSelect = 1'b0;
                signSelect = 1'b0;
                WRITEENABLE = 1'b1;
            end

            // add instruction
            8'b00000010: begin
                ALUOP = 3'b001;
                immSelect = 1'b0;
                signSelect = 1'b0;
                WRITEENABLE = 1'b1;
            end

            // sub instruction
            8'b00000011: begin
                ALUOP = 3'b001;
                immSelect = 1'b0;
                signSelect = 1'b1;
                WRITEENABLE = 1'b1;
            end

            // and instruction
            8'b00000100: begin
                ALUOP = 3'b010;
                immSelect = 1'b0;
                signSelect = 1'b0;
                WRITEENABLE = 1'b1;
            end

            // or instruction
            8'b00000101: begin
                ALUOP = 3'b011;
                immSelect = 1'b0;
                signSelect = 1'b0;
                WRITEENABLE = 1'b1;
            end

        endcase
    end

endmodule