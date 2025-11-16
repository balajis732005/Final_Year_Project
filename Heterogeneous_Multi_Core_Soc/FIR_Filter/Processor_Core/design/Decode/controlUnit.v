module controlUnit(
    input  wire [6:0] opcode,                  
    output reg        pcUpdate,                
    output reg        memoryReadEnable,        
    output reg        memoryWriteEnable,       
    output reg        registerWriteEnable,     
    output reg  [1:0] aluSrc1,                 
    output reg  [1:0] aluSrc2,                 
    output reg  [2:0] aluOperation,            
    output reg        pcAdderSrc,              
    output reg        writeBackFromAluOrMemory 
);

    always @* begin

        // DEFAULTS
        pcUpdate                 = 1'b0;
        memoryReadEnable         = 1'b0;
        memoryWriteEnable        = 1'b0;
        registerWriteEnable      = 1'b0;
        aluSrc1                  = 2'b00;
        aluSrc2                  = 2'b00;
        aluOperation             = 3'b000;
        pcAdderSrc               = 1'b0;
        writeBackFromAluOrMemory = 1'b0;

        // INSTRUCTION DECODE
        case (opcode)

            // R-TYPE
            RType: begin
                registerWriteEnable = 1'b1;
                aluSrc1            = 2'b00;
                aluSrc2            = 2'b00;
                aluOperation       = 3'b010;
            end

            // I-TYPE
            IType: begin
                registerWriteEnable = 1'b1;
                aluSrc1            = 2'b00;
                aluSrc2            = 2'b01;
                aluOperation       = 3'b011;
            end

            // I-TYPE LOAD
            ITypeLoad: begin
                memoryReadEnable         = 1'b1;
                registerWriteEnable      = 1'b1;
                aluSrc1                  = 2'b00;
                aluSrc2                  = 2'b01;
                aluOperation             = 3'b000;
                writeBackFromAluOrMemory = 1'b1;
            end

            // S-TYPE
            SType: begin
                memoryWriteEnable = 1'b1;
                aluSrc1           = 2'b00;
                aluSrc2           = 2'b01;
                aluOperation      = 3'b000;
            end

            // B-TYPE
            BType: begin
                pcUpdate     = 1'b1;
                aluSrc1      = 2'b00;
                aluSrc2      = 2'b00;
                aluOperation = 3'b001;
                pcAdderSrc   = 1'b0;
            end

            // J-TYPE
            JType: begin
                pcUpdate     = 1'b1;
                registerWriteEnable = 1'b1;
                aluSrc1      = 2'b01;
                aluSrc2      = 2'b10;
                aluOperation = 3'b100;
                pcAdderSrc   = 1'b0;
            end

            // I-TYPE JALR
            ITypeJALR: begin
                pcUpdate     = 1'b1;
                registerWriteEnable = 1'b1;
                aluSrc1      = 2'b01;
                aluSrc2      = 2'b10;
                aluOperation = 3'b101;
                pcAdderSrc   = 1'b1;
            end

            // U-TYPE
            UType: begin
                registerWriteEnable = 1'b1;
                aluSrc1             = 2'b10;
                aluSrc2             = 2'b01;
                aluOperation        = 3'b110;
            end

            // U-TYPE AUIPC
            UTypeAUIPC: begin
                registerWriteEnable = 1'b1;
                aluSrc1             = 2'b01;
                aluSrc2             = 2'b01;
                aluOperation        = 3'b111;
            end

            // VMAC TYPE
            VmacType: begin
                registerWriteEnable = 1'b1;
                aluSrc1            = 2'b00;
                aluSrc2            = 2'b00;
                aluOperation       = 3'b010;
            end

        endcase
    end

endmodule
