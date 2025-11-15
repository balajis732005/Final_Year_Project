module forwardMux1(
    input  [31:0] readData1,
    input  [31:0] prevDataExecuteToMemory,
    input  [31:0] prevDataMemoryToWriteBack,
    input  [1:0]  forwardSelect1,
    output reg [31:0] aluForwardInput1
);

    always @(*) begin
        case (forwardSelect1)
            2'b00: aluForwardInput1 = readData1;
            2'b01: aluForwardInput1 = prevDataExecuteToMemory;
            2'b10,
            2'b11: aluForwardInput1 = prevDataMemoryToWriteBack;
            default: aluForwardInput1 = 32'b0;
        endcase
    end

endmodule
