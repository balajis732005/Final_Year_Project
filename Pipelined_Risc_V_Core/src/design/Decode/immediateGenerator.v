module immediateGenerator(
    input  wire [31:0] instruction,
    output reg  [31:0] immediateValue
);

    wire [6:0] opcode;
    assign opcode = instruction[6:0];

    always @* begin
        case (opcode)

            // I-TYPE
            IType,
            ITypeLoad,
            ITypeJALR: begin
                immediateValue = {{20{instruction[31]}}, instruction[31:20]};
            end

            // S-TYPE
            SType: begin
                immediateValue = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end

            // B-TYPE
            BType: begin
                immediateValue = {{20{instruction[31]}},
                                   instruction[31],
                                   instruction[7],
                                   instruction[30:25],
                                   instruction[11:8]};
            end

            // U-TYPE
            UType,
            UTypeAUIPC: begin
                immediateValue = {12'b0, instruction[31:12]};
            end

            // J-TYPE
            JType: begin
                immediateValue = {{12{instruction[31]}},
                                   instruction[31],
                                   instruction[19:12],
                                   instruction[20],
                                   instruction[30:21]};
            end

        endcase
    end

endmodule
