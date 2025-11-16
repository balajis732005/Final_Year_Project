module aluControl(
    input  [2:0] aluControl,
    input  [2:0] func3,
    input  [6:0] func7,
    output reg [4:0] aluControlOut
);

    always @(*) begin
        case(aluControl)

            // LOAD - STORE [I-TYPE AND S-TYPE]
            LoadStoreType: begin
                aluControlOut = 5'b00000; // ADD - LOAD/STORE
            end

            // J-TYPE
            JTypeALU: begin
                aluControlOut = 5'b00000; // ADD - JAL
            end

            // I-TYPE_JALR
            ITypeJALR_ALU: begin
                aluControlOut = 5'b00000; // ADD - JALR
            end

            // U-TYPE
            UTypeALU: begin
                aluControlOut = 5'b00000; // ADD - LUI
            end

            // U-TYPE_AUIPC
            UTypeAUIPC_ALU: begin
                aluControlOut = 5'b00000; // ADD - AUIPC
            end

            // B-TYPE
            BTypeALU: begin
                case(func3)
                    3'b000 : aluControlOut = 5'b01010; // BEQ
                    3'b001 : aluControlOut = 5'b01011; // BNE
                    3'b100 : aluControlOut = 5'b01100; // BLT
                    3'b101 : aluControlOut = 5'b01101; // BGE
                    3'b110 : aluControlOut = 5'b01110; // BLTU
                    3'b111 : aluControlOut = 5'b01111; // BGEU
                    default: aluControlOut = 5'bxxxxx;
                endcase
            end

            // R-TYPE
            RTypeALU: begin
                case(func3)
                    3'b000: aluControlOut = 
                        (func7 == 7'b0100000) ? 5'b00001 : 5'b00000; // SUB/ADD
                    3'b111: aluControlOut = 
                        (func7 == 7'b0000001) ? 5'b10000 : 5'b00010; // VMAC/AND
                    3'b110: aluControlOut = 5'b00011; // OR
                    3'b100: aluControlOut = 5'b00100; // XOR
                    3'b001: aluControlOut = 5'b00101; // SLL
                    3'b101: aluControlOut =
                        (func7 == 7'b0100000) ? 5'b00111 : 5'b00110; // SRA/SRL
                    3'b010: aluControlOut = 5'b01000; // SLT
                    3'b011: aluControlOut = 5'b01001; // SLTU
                    default: aluControlOut = 5'bxxxx;
                endcase
            end

            // I-TYPE
            ITypeALU: begin
                case(func3)
                    3'b000: aluControlOut = 5'b00000; // ADDI
                    3'b111: aluControlOut = 5'b00010; // ANDI
                    3'b110: aluControlOut = 5'b00011; // ORI
                    3'b100: aluControlOut = 5'b00100; // XORI
                    3'b001: aluControlOut = 5'b00101; // SLLI
                    3'b101: aluControlOut = (func7 == 7'b0100000) ? 5'b00111 : 5'b00110; // SRAI/SRLI
                    3'b010: aluControlOut = 5'b01000; // SLTI
                    3'b011: aluControlOut = 5'b01001; // SLTIU
                    default: aluControlOut = 5'bxxxx;
                endcase
            end

            default: begin
                aluControlOut = 5'bxxxxx;
            end
        endcase
    end

endmodule
