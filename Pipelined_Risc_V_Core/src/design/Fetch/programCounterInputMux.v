module programCounterInputMux (
  input  wire [31:0] pcIncrement,
  input  wire [31:0] pcJump,
  input  wire        pcIncrementOrJump,
  output reg  [31:0] pcInput
);

  always @(*) begin
    pcInput = (pcIncrementOrJump == 1'b0) ? pcIncrement : pcJump;
  end

endmodule
