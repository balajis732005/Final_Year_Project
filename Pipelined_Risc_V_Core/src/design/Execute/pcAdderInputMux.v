module pcAdderInputMux(
    input  [31:0] pc,
    input  [31:0] regis,
    input         select,
    output reg [31:0] out
);

    always @(*) begin
        out = (select == 1'b0) ? pc : regis;
    end

endmodule
