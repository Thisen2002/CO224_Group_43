/*
Group 43
Thisen Lakdinu, Shashika Sathsarani
Microprocessor implementation part-2.
Date:-20/05/2025
*/

module reg_file (
    IN, OUT1, OUT2, 
    INADDRESS, OUT1ADDRESS, OUT2ADDRESS, 
    WRITE, CLK, RESET
);

    // Port Declarations
    input [2:0] OUT2ADDRESS, OUT1ADDRESS, INADDRESS;  // 3-bit addresses for 8 registers (0 to 7)
    input [7:0] IN;                                   // 8-bit data input
    input WRITE, CLK, RESET;                          // Control signals: Write Enable, Clock, and Reset

    output [7:0] OUT1, OUT2;                          // 8-bit data outputs

    // Register bank: 8 registers, each 8 bits wide
    reg [7:0] REGISTER[7:0];

    // Output assignments with delay of 2 time units
    assign #2 OUT1 = REGISTER[OUT1ADDRESS];  // Reads content of register specified by OUT1ADDRESS
    assign #2 OUT2 = REGISTER[OUT2ADDRESS];  // Reads content of register specified by OUT2ADDRESS

    // Always block triggered at the positive edge of the clock
    always @ (posedge CLK)
    begin
        if (RESET == 1'b1) // When RESET is high, clear all registers
        begin
            #1 REGISTER[0] = 8'b00000000;
               REGISTER[1] = 8'b00000000;
               REGISTER[2] = 8'b00000000;
               REGISTER[3] = 8'b00000000;
               REGISTER[4] = 8'b00000000;
               REGISTER[5] = 8'b00000000;
               REGISTER[6] = 8'b00000000;
               REGISTER[7] = 8'b00000000;
            // Note: A loop could be used here, but manually writing ensures deterministic behavior
        end
        else if (WRITE == 1'b1) // If WRITE is enabled, write data to specified register
        begin
            #1 REGISTER[INADDRESS] = IN;
        end
    end

    // Initial block to monitor and print the register values during simulation
    initial 
    begin
        $monitor("Time:-%0d\nReg1:-%8d\nReg2:-%8d\nReg3:-%8d\nReg4:-%8d\nReg5:-%8d\nReg6:-%8d\nReg7:-%8d\nReg8:-%8d\n", 
            $time, 
            REGISTER[0], REGISTER[1], REGISTER[2], REGISTER[3], 
            REGISTER[4], REGISTER[5], REGISTER[6], REGISTER[7]);
    end   

endmodule
