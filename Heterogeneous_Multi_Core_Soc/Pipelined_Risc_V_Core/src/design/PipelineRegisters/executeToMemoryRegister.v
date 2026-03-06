module executeToMemoryRegister(
    input         clock,
    input         reset,
    input  [31:0] pcAdder,
    input  [31:0] alu,
    input         branch,
    input         pcUpdate,
    input         memoryReadEnable,
    input         memoryWriteEnable,
    input         writeBackFromMemoryOrAlu,
    input  [31:0] readData2,
    input  [2:0]  func3,
    input         registerWriteEnable,
    input  [4:0]  rd,

    output reg [31:0] pcAdderOut,
    output reg [31:0] aluOut,
    output reg        branchOut,
    output reg        pcUpdateOut,
    output reg        memoryReadEnableOut,
    output reg        memoryWriteEnableOut,
    output reg        writeBackFromMemoryOrAluOut,
    output reg [31:0] readData2Out,
    output reg [2:0]  func3Out,
    output reg        registerWriteEnableOut,
    output reg [4:0]  rdOut
);

    always @(posedge clock) begin
        if (reset) begin
            pcAdderOut                <= 32'b0;
            aluOut                    <= 32'b0;
            branchOut                 <= 1'b0;
            pcUpdateOut               <= 1'b0;
            memoryReadEnableOut       <= 1'b0;
            memoryWriteEnableOut      <= 1'b0;
            writeBackFromMemoryOrAluOut <= 1'b0;
            readData2Out              <= 32'b0;
            func3Out                  <= 3'b0;
            registerWriteEnableOut    <= 1'b0;
            rdOut                     <= 5'b0;
        end else begin
            pcAdderOut                <= pcAdder;
            aluOut                    <= alu;
            branchOut                 <= branch;
            pcUpdateOut               <= pcUpdate;
            memoryReadEnableOut       <= memoryReadEnable;
            memoryWriteEnableOut      <= memoryWriteEnable;
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
            readData2Out              <= readData2;
            func3Out                  <= func3;
            registerWriteEnableOut    <= registerWriteEnable;
            rdOut                     <= rd;
        end
    end

endmodule
