module forwardUnit(
    input        registerWriteEnableExecuteToMemory,
    input        registerWriteEnableMemoryToWriteBack,
    input  [4:0] prevRdExecuteToMemory,
    input  [4:0] prevRdMemoryToWriteBack,
    input  [4:0] presentRs1,
    input  [4:0] presentRs2,
    output reg [1:0] forwardSelect1,
    output reg [1:0] forwardSelect2
);

    always @(*) begin
        // default
        forwardSelect1 = 2'b00;
        forwardSelect2 = 2'b00;

        // EX → ID forwarding
        if (registerWriteEnableExecuteToMemory && (prevRdExecuteToMemory != 5'd0)) begin
            if (prevRdExecuteToMemory == presentRs1)
                forwardSelect1 = 2'b01;
            if (prevRdExecuteToMemory == presentRs2)
                forwardSelect2 = 2'b01;
        end

        // MEM → ID forwarding
        if (registerWriteEnableMemoryToWriteBack && (prevRdMemoryToWriteBack != 5'd0)) begin
            if (prevRdMemoryToWriteBack == presentRs1)
                forwardSelect1 = 2'b10;
            if (prevRdMemoryToWriteBack == presentRs2)
                forwardSelect2 = 2'b10;
        end
    end

endmodule
