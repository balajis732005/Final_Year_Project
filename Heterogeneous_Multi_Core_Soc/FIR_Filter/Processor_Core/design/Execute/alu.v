module alu(
    input  wire [31:0] in1,
    input  wire [31:0] in2,
    input  wire [31:0] accumData,
    input  wire [4:0]  aluOperation,
    input  wire [2:0]  aluControl,
    output reg  [31:0] aluOutput,
    output reg         branch
);

    always @* begin
        aluOutput = 32'b0;
        branch    = 1'b0;

        case (aluOperation)

            ADD  : aluOutput = in1 + in2;
            SUB  : aluOutput = in1 - in2;
            AND  : aluOutput = in1 & in2;
            OR   : aluOutput = in1 | in2;
            XOR  : aluOutput = in1 ^ in2;

            SLL  : aluOutput = in1 << in2[4:0];
            SRL  : aluOutput = in1 >> in2[4:0];
            SRA  : aluOutput = $signed(in1) >>> in2[4:0];

            SLT  : aluOutput = ($signed(in1) < $signed(in2)) ? 32'd1 : 32'd0;
            SLTU : aluOutput = (in1 < in2) ? 32'd1 : 32'd0;

            BEQ  : branch = (in1 == in2) ? 1'b1 : 1'b0;
            BNE  : branch = ($signed(in1) != $signed(in2)) ? 1'b1 : 1'b0;
            BLT  : branch = ($signed(in1) < $signed(in2)) ? 1'b1 : 1'b0;
            BGE  : branch = ($signed(in1) >= $signed(in2)) ? 1'b1 : 1'b0;
            BLTU : branch = (in1 < in2) ? 1'b1 : 1'b0;
            BGEU : branch = (in1 >= in2) ? 1'b1 : 1'b0;

            VMAC : aluOutput = accumData + ((in1 * in2) >> 15);

            default: aluOutput = 32'bx;

        endcase

        case (aluControl)
            JTypeALU:        branch = 1'b1; //Alu hase been changed
            ITypeJALR_ALU:   branch = 1'b1;
        endcase

        $display($time," [ALU] RS1 : %0d",in1);
        $display($time," [ALU] RS2 : %0d",in2);
        $display($time," [ALU] AluOutput : %0d",aluOutput);

    end

endmodule
