module memoryToWriteBackRegister(
    input         clock,
    input         reset,
    input         writeBackFromMemoryOrAlu,
    input  [31:0] memoryReadData,
    input  [31:0] aluData,
    input         registerWriteEnable,
    input  [4:0]  rd,

    output reg        writeBackFromMemoryOrAluOut,
    output reg [31:0] memoryReadDataOut,
    output reg [31:0] aluDataOut,
    output reg        registerWriteEnableOut,
    output reg [4:0]  rdOut
);

    always @(posedge clock) begin
        if (reset) begin
            writeBackFromMemoryOrAluOut <= 1'b0;
            memoryReadDataOut           <= 32'b0;
            aluDataOut                  <= 32'b0;
            registerWriteEnableOut      <= 1'b0;
            rdOut                       <= 5'b0;
        end
        else begin
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
            memoryReadDataOut           <= memoryReadData;
            aluDataOut                  <= aluData;
            registerWriteEnableOut      <= registerWriteEnable;
            rdOut                       <= rd;
        end
    end

endmodule
