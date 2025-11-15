module fetchToDecodeRegister (
    input        clock,
    input        reset,
    input  [31:0] pc,
    input  [31:0] instruction,
    output reg [31:0] pcOut,
    output reg [31:0] instOut
);

    always @(posedge clock) begin
        if (reset) begin
            pcOut   <= 32'b0;
            instOut <= 32'b0;
        end 
        else begin
            pcOut   <= pc;
            instOut <= instruction;
        end
    end

endmodule
