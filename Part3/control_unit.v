
// control unit for the alu
// use 8 bit of opcode to find the operations

module control_unit(OPCODE, IMM, SIGN, WRITEENABLE, ALUOP);
    input[7:0] OPCODE;                             // extract from instructions
    output reg IMM, SIGN;                          // input selecters for the mux1 and mux2
    output reg WRITEENABLE;                        // write enable for the register
    output reg [2:0] ALUOP;                        // selector input for the ALU


    // ...existing code...
    always @(OPCODE) begin
        // Default values
        #1
        case (OPCODE)
            8'b0000_0000: begin // LOADI            READREG2
                IMM = 1'b1;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b000; // ADD (for immediate)
            end
            8'b0000_0001: begin // MOV              READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b000; // ADD (pass-through)
            end
            8'b0000_0010: begin // ADD              READREG2, READREG1
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b001; // ADD
            end
            8'b0000_0011: begin // SUB              READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b1;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b001; // SUB
            end
            8'b0000_0100: begin // AND              READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b010; // AND
            end
            8'b0000_0101: begin // OR               READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b011; // OR
            end
        endcase
    end  

endmodule