module decodeToExecuteRegister (
    input        clock,
    input        reset,
    input  [31:0] pc,
    input  [31:0] readData1,
    input  [31:0] readData2,
    input  [31:0] accumData,
    input  [31:0] immediateValue,
    input  [2:0]  func3,
    input  [6:0]  func7,
    input         pcUpdate,
    input         memoryReadEnable,
    input         memoryWriteEnable,
    input         registerWriteEnable,
    input  [1:0]  aluSrc1,
    input  [1:0]  aluSrc2,
    input  [2:0]  aluOperation,
    input         pcAdderSrc,
    input         writeBackFromMemoryOrAlu,
    input  [4:0]  rd,
    input  [4:0]  rs1,
    input  [4:0]  rs2,

    output reg [31:0] pcOut,
    output reg [31:0] readData1Out,
    output reg [31:0] readData2Out,
    output reg [31:0] accumDataOut,
    output reg [31:0] immediateValueOut,
    output reg [2:0]  func3Out,
    output reg [6:0]  func7Out,
    output reg        pcUpdateOut,
    output reg        memoryReadEnableOut,
    output reg        memoryWriteEnableOut,
    output reg        registerWriteEnableOut,
    output reg [1:0]  aluSrc1Out,
    output reg [1:0]  aluSrc2Out,
    output reg [2:0]  aluOperationOut,
    output reg        pcAdderSrcOut,
    output reg        writeBackFromMemoryOrAluOut,
    output reg [4:0]  rdOut,
    output reg [4:0]  rs1Out,
    output reg [4:0]  rs2Out
);

    always @(posedge clock) begin
        if (reset) begin
            pcOut                     <= 32'b0;
            readData1Out              <= 32'b0;
            readData2Out              <= 32'b0;
            accumDataOut              <= 32'b0;
            immediateValueOut         <= 32'b0;
            func3Out                  <= 3'b0;
            func7Out                  <= 7'b0;
            pcUpdateOut               <= 1'b0;
            memoryReadEnableOut       <= 1'b0;
            memoryWriteEnableOut      <= 1'b0;
            registerWriteEnableOut    <= 1'b0;
            aluSrc1Out                <= 2'b00;
            aluSrc2Out                <= 2'b00;
            aluOperationOut           <= 3'b000;
            pcAdderSrcOut             <= 1'b0;
            writeBackFromMemoryOrAluOut <= 1'b0;
            rdOut                     <= 5'b0;
            rs1Out                    <= 5'b0;
            rs2Out                    <= 5'b0;
        end else begin
            pcOut                     <= pc;
            readData1Out              <= readData1;
            readData2Out              <= readData2;
            accumDataOut              <= accumData;
            immediateValueOut         <= immediateValue;
            func3Out                  <= func3;
            func7Out                  <= func7;
            pcUpdateOut               <= pcUpdate;
            memoryReadEnableOut       <= memoryReadEnable;
            memoryWriteEnableOut      <= memoryWriteEnable;
            registerWriteEnableOut    <= registerWriteEnable;
            aluSrc1Out                <= aluSrc1;
            aluSrc2Out                <= aluSrc2;
            aluOperationOut           <= aluOperation;
            pcAdderSrcOut             <= pcAdderSrc;
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
            rdOut                     <= rd;
            rs1Out                    <= rs1;
            rs2Out                    <= rs2;
        end
    end

endmodule
