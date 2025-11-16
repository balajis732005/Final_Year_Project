module aluInputSelectMux1(
    input  [31:0] registerData,
    input  [31:0] pc,
    input  [1:0]  input1Select,
    output reg [31:0] input1Alu
);

    always @(*) begin
        case (input1Select)
            2'b00: input1Alu = registerData;
            2'b01: input1Alu = pc;
            2'b10: input1Alu = 32'b0;
            default: input1Alu = 32'b0;
        endcase
    end

endmodule
