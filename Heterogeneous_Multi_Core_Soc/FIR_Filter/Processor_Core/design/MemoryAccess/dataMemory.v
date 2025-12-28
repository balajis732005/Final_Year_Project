module dataMemory(
    input         clock, 
    input         reset, 
    input         memoryReadEnable, 
    input         memoryWriteEnable, 
    input  [2:0]  func3,
    input  [31:0] memoryAddress, 
    input  [31:0] writeData, 
    output reg [31:0] readData
);

    // 1KB x 32-bit MEMORY
    reg [31:0] dataMem [0:1023];
    
    reg [31:0] rawRead;
    reg [31:0] modifiedWriteData;

    integer i;

    /* =====================================================
       MANUAL PRELOAD : INPUTS + COEFFICIENTS + OUTPUT
       ===================================================== */
    initial begin
        // Clear entire memory
        for (i = 0; i < 1024; i = i + 1)
            dataMem[i] = 32'd0;

        /* -------- INPUT SAMPLES {1,2,3,4,5} -------- */
        dataMem[0] = 32'd1;
        dataMem[1] = 32'd2;
        dataMem[2] = 32'd3;
        dataMem[3] = 32'd4;
        dataMem[4] = 32'd5;

        /* -------- COEFFICIENTS (0.25 in Q15) -------- */
        dataMem[16] = 32'd8192; // 0.25
        dataMem[17] = 32'd8192;
        dataMem[18] = 32'd8192;

        /* -------- OUTPUT REGION (INITIAL ZERO) ------ */
        dataMem[32] = 32'd0;
        dataMem[33] = 32'd0;
        dataMem[34] = 32'd0;
        dataMem[35] = 32'd0;
        dataMem[36] = 32'd0;

        $display("Data memory manually initialized");
    end

    /* ================= READ LOGIC ================= */
    always @(*) begin
        if (memoryReadEnable) begin
            rawRead = dataMem[memoryAddress[11:2]];
            case (func3)
                3'b000: readData = {{24{rawRead[7]}}, rawRead[7:0]};     
                3'b001: readData = {{16{rawRead[15]}}, rawRead[15:0]};   
                3'b100: readData = {{24{1'b0}}, rawRead[7:0]};           
                3'b101: readData = {{16{1'b0}}, rawRead[15:0]};          
                default: readData = rawRead;                             
            endcase
        end else begin
            readData = 32'b0;
        end
    end

    /* ================= WRITE LOGIC ================= */
    always @(posedge clock) begin
        if (reset) begin
            for (i = 0; i < 1024; i = i + 1)
                dataMem[i] <= 32'b0;
        end 
        else if (memoryWriteEnable) begin
            modifiedWriteData = writeData;
            case (func3)
                3'b000: modifiedWriteData = {24'b0, writeData[7:0]};
                3'b001: modifiedWriteData = {16'b0, writeData[15:0]};
                default: modifiedWriteData = writeData;
            endcase

            dataMem[memoryAddress[11:2]] <= modifiedWriteData;

            $display($time," [DATAMEM] WRITE[%0d] : %0d",
                     memoryAddress, modifiedWriteData);
        end
    end

endmodule
