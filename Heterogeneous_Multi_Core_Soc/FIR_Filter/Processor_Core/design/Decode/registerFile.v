module registerFile(
    input  wire        clock,
    input  wire        reset,
    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2,
    input  wire [4:0]  rd,
    input  wire [31:0] writeData,
    input  wire        registerWrite,
    input  wire        fir_we,
    input  wire [4:0]  fir_waddr,
    input  wire [31:0] fir_wdata,
    output wire [31:0] readData1,
    output wire [31:0] readData2,
    output wire [31:0] accumData
);

    // REGISTER FILE
    reg [31:0] regFile [0:31];

    integer i;

    always @(posedge clock) begin
        if (reset == 1'b1) begin
            for (i = 0; i < 32; i = i + 1) begin
                regFile[i] <= 32'b0;
            end
        end else if (fir_we && fir_waddr != 5'd0) begin
            regFile[fir_waddr] <= fir_wdata;
            $display($time, "[FIR] RF WRITE x%0d = %0d", fir_waddr, fir_wdata);
        end else if (registerWrite && (rd != 5'd0)) begin
            regFile[rd] <= writeData;
            $display($time, " [REG] WRITE[%0d] : %0d", rd, writeData);
        end
    end

    assign readData1 = regFile[rs1];
    assign readData2 = regFile[rs2];
    assign accumData = regFile[rd];

endmodule
