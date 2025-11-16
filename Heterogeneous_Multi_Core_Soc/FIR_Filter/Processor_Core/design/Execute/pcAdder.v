module pcAdder(
    input  [31:0] pcOrReg,
    input  [31:0] imm,
    output reg [31:0] newPc
);

    always @(*) begin
        newPc = pcOrReg + (imm << 1);
    end

endmodule
