
// control unit for the alu
// use 8 bit of opcode to find the operations

module control_unit(J, BEQ, BNEQ, OPCODE, IMM, SIGN, WRITEENABLE, ALUOP);
    input[7:0] OPCODE;                             // extract from instructions
    output reg IMM, SIGN;                          // input selecters for the mux1 and mux2
    output reg WRITEENABLE;                        // write enable for the register
    output reg J;                                  // control signal for jump
    output reg BEQ, BNEQ;                          // control signal for branch
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
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b0000_0001: begin // MOV              READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b000; // ADD (pass-through)
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b0000_0010: begin // ADD              READREG2, READREG1
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b001; // ADD
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b0000_0011: begin // SUB              READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b1;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b001; // SUB
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b0000_0100: begin // AND              READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b010; // AND
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b0000_0101: begin // OR               READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b011; // OR
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end


            // patr 4 branch and jump instructions

            8'b00000110:  begin
                J = 1'b1;          //Set JUMP control signal to 1
                BEQ = 1'b0;        //Set BRANCH control signal to zero
                WRITEENABLE = 1'b0;   //Disable writing to register
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b00000111:  begin     //BEQ
                ALUOP = 3'b001;          //Set ALU to ADD
                IMM = 1'b0;        //Set MUX to select register input
                SIGN = 1'b1;       //Set sign select MUX to negative sign
                J = 1'b0;             //Set JUMP control signal to zero
                BEQ = 1'b1;           //Set BRANCH control signal to 1
                WRITEENABLE = 1'b0;      //Enable writing to register
                BNEQ = 1'b0; // Enable branch if not equal
            end
            8'b00001000: begin // BNEQ              READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b1;
                WRITEENABLE = 1'b0; // No write to register
                ALUOP = 3'b001; // SUB for comparison
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // Enable branch if equal
                BNEQ = 1'b1; // Enable branch if not equal
            end



            //part5
            
            8'b0000_1001: begin // multiply two registers    READREG1, READREG2
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b110; // ADD (for immediate)
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
            end

            8'b0000_1010: begin // sll instruction
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b100; // Lshift (for immediate)
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end

            8'b0000_1011: begin // srl instruction
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b101; // ADD (for immediate)
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end

            8'b0000_1100: begin // sra instruction
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b101; // ADD (for immediate)
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end

            8'b0000_1101: begin // ror instruction
                IMM = 1'b0;
                SIGN = 1'b0;
                WRITEENABLE = 1'b1;
                ALUOP = 3'b111; // ADD (for immediate)
                J = 1'b0; // J is not used in this case
                BEQ = 1'b0; // BEQ is not used in this case
                BNEQ = 1'b0; // Enable branch if not equal
            end
        endcase
    end  

endmodule