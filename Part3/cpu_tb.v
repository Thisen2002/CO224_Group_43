// Computer Architecture (CO224) - Lab 05
// Design: Testbench of Integrated CPU of Simple Processor
// Author: Isuru Nawinne

`include "cpu.v"

module cpu_tb;

    reg CLK, RESET;
    wire [31:0] PC;
    wire [31:0] INSTRUCTION;

    

    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */

    // ✅ Instruction memory (8-bit wide, 1024 locations)
    reg [7:0] instr_mem [1023:0];

    // ✅ Instruction fetching logic (with delay)
    assign #2 INSTRUCTION = {instr_mem[PC+3], instr_mem[PC+2], instr_mem[PC+1], instr_mem[PC]};

    initial
    begin
        // ✅ Load instruction memory from file
        $readmemb("instr_mem.mem", instr_mem);

        // Optional: Manually load instructions instead of file
        // {instr_mem[3], instr_mem[2], instr_mem[1], instr_mem[0]} = 32'b00000000000001000000000000000101;
    end

    /* 
    -----
     CPU
    -----
    */
    cpu mycpu(INSTRUCTION, RESET, CLK, PC);
    integer i;
    initial
    begin
        // ✅ Generate waveform data
        $dumpfile("cpu_wavedata.vcd");
        $dumpvars(0, cpu_tb);
        
        for (i = 0; i < 8; i = i + 1)
        begin
            $dumpvars(1, cpu_tb.mycpu.reg_file_inst.REGISTER[i]);
        end

        CLK = 1'b0;
        RESET = 1'b0;

        // ✅ Pulse the RESET signal
        RESET = 1'b1;
        #5;
        RESET = 1'b0;

        // ✅ End simulation after 500 time units
        #500
        $finish;
    end

    // ✅ Clock generation (toggle every 4 time units)
    always
        #4 CLK = ~CLK;

endmodule
