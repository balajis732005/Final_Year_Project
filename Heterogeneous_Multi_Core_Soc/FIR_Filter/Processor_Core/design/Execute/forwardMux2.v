module forwardMux2(
    input  [31:0] readData2,
    input  [31:0] prevDataExecuteToMemory,
    input  [31:0] prevDataMemoryToWriteBack,
    input  [1:0]  forwardSelect2,
    output reg [31:0] aluForwardInput2
);

    always @(*) begin
        case (forwardSelect2)
            2'b00: aluForwardInput2 = readData2;
            2'b01: aluForwardInput2 = prevDataExecuteToMemory;
            2'b10,
            2'b11: aluForwardInput2 = prevDataMemoryToWriteBack;
            default: aluForwardInput2 = 32'b0;
        endcase
    end

endmodule
