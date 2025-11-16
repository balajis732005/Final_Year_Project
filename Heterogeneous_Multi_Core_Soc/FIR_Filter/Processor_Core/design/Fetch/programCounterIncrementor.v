module programCounterIncrementor (
  input  wire [31:0] pcCurrent,
  output reg  [31:0] pcNext
);

  always @(*) begin
    pcNext = pcCurrent + 1;
  end

endmodule
