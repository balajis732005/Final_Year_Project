module writeBackMux(
    input  [31:0] aluData,
    input  [31:0] memoryData,
    input         writeBackFromMemoryOrAlu,
    output reg [31:0] dataBack
);

    always @(*) begin
        if (writeBackFromMemoryOrAlu == 1'b0)
            dataBack = aluData;
        else
            dataBack = memoryData;
    end

endmodule
