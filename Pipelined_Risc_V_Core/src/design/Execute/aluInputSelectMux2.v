module aluInputSelectMux2(
    input  [31:0] registerData,
    input  [31:0] immediateValue,
    input  [1:0]  input2Select,
    output reg [31:0] input2Alu
);

    always @(*) begin
        case (input2Select)
            2'b00: input2Alu = registerData;
            2'b01: input2Alu = immediateValue;
            2'b10: input2Alu = 32'b1;
            default: input2Alu = 32'b0;
        endcase
    end

endmodule
