`include "reg_file.v"
`include "control_unit.v"
`include "mux.v"
`include "alu.v"
`include "control_unit.v"
`include "two_s_comple.v"

module top_level_cpu(INSTRUCTION, RESET, CLK, PC);
    input RESET, CLK;
    input[31:0] INSTRUCTION;

    output[31:0] PC;

    wire[2:0] READREG2, READREG1, WRITEREG, ALUOP;
    wire[7:0] OPCODE, IMMEDIATE, REGOUT2, REGOUT2, ALURESULT;
    wire WRITEENABLE;

    
    reg_file reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);
    mux mux1(DATA1, DATA2, SELECT, OUTPUT);
    mux mux2(DATA1, DATA2, SELECT, OUTPUT);
    alu alu(DATA1, DATA2, RESULT, SELECT);
    control_unit control_unit(OPCODE, IMM, SIGN, WRITEENABLE, ALUOP);
    
    assign READREG1 = INSTRUCTION[15:8];
	assign IMMEDIATE = INSTRUCTION[7:0];
	assign READREG2 = INSTRUCTION[7:0];
	assign WRITEREG = INSTRUCTION[23:16];
    assign OPCODE = INSTRUCTION[31:24];

    always @ ( posedge CLK)
	begin
		if (RESET == 1'b1) 
		begin
			#1
			PC = 0;		
			PCreg = 0;
		end
		else #1 PC = PCreg;		
	end

    always @ (PC)
	begin
		 #1 PCreg = PCreg + 4;
	end

    always @(INSTRUCTION) 
    begin
        #1
        control_unit(OPCODE, IMM, SIGN, WRITEENABLE, ALUOP);
    end



endmodule