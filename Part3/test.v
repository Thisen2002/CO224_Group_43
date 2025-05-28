`include "top_level_2.v"
//`timescale 1ns/1ps

module top_level_cpu_tb;

    // Inputs
    reg CLK;
    reg RESET;
    reg [31:0] INSTRUCTION;

    // Outputs
    wire [31:0] PC;

    // Instantiate the Unit Under Test (UUT)
    top_level_cpu uut (
        .INSTRUCTION(INSTRUCTION),
        .RESET(RESET),
        .CLK(CLK),
        .PC(PC)
    );

    // Clock generation
    always begin
        #5 CLK = ~CLK;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t PC=%0d INSTR=%h RESET=%b fi=%8b", $time, PC, INSTRUCTION, RESET, uut.alu_inst.RESULT);
    end

    // Test cases
    initial begin
        // Initialize Inputs
        CLK = 0;
        RESET = 1;
        INSTRUCTION = 0;

        // Apply Reset
        #10;
        RESET = 0;
        
        // Test 1: Load immediate value (8'hAA) into register 1
        // Format: OPCODE(8) | DEST(8) | SRC1(8) | IMM(8)
        // OPCODE = 8'bxxxxx1x1 (WRITEENABLE=1, IMM=1)
        #10 INSTRUCTION = 32'b00001011_00000001_00000000_10101010;
        
        // Test 2: Load immediate value (8'h55) into register 2
        #10 INSTRUCTION = 32'b00001011_00000010_00000000_01010101;
        
        // Test 3: ADD register 1 and register 2, store in register 3
        // OPCODE = 8'b00100001 (ALUOP=ADD, WRITEENABLE=1)
        #10 INSTRUCTION = 32'b00100001_00000011_00000001_00000010;
        
        // Test 4: SUBTRACT (using two's complement) register 2 from register 1, store in register 4
        // OPCODE = 8'b00100011 (ALUOP=ADD, WRITEENABLE=1, SIGN=1)
        #10 INSTRUCTION = 32'b00100011_00000100_00000001_00000010;
        
        // Test 5: AND register 1 and register 2, store in register 5
        // OPCODE = 8'b01000001 (ALUOP=AND, WRITEENABLE=1)
        #10 INSTRUCTION = 32'b01000001_00000101_00000001_00000010;
        
        // Test 6: OR register 1 and register 2, store in register 6
        // OPCODE = 8'b01100001 (ALUOP=OR, WRITEENABLE=1)
        #10 INSTRUCTION = 32'b01100001_00000110_00000001_00000010;
        
        // Test 7: Forward operation (just copy register 1 to register 7)
        // OPCODE = 8'b00000001 (ALUOP=FORWARD, WRITEENABLE=1)
        #10 INSTRUCTION = 32'b00000001_00000111_00000001_00000000;
        
        // Add more tests as needed
        
        // Finish simulation
        #50 $finish;
    end

    // Dump VCD for waveform viewing
    initial begin
        $dumpfile("cpu_waveform.vcd");
        $dumpvars(0, top_level_cpu_tb);
    end

endmodule