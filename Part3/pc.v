module pc(PC, RESET, CLK);
    input RESET, CLK;
    output PC;

    initial 
    begin
        CLK = 1b'1;
    end

    always @(Reset) 
    begin
        if (Reset == 1b'1) 
        begin
            PC = 32b'0000_0000_0000_0000_0000_0000_0000_0000;    
        end    
    end

    always
        #1 CLK = ~CLK;
endmodule