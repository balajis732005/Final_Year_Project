module instructionMemory (
  input  wire        clock,
  input  wire        reset,
  input  wire [31:0] instructionAddress,
  output reg  [31:0] instruction
);

  reg [31:0] instMem [0:1023];

  initial begin
    $display("Loading instruction memory...");
    $readmemb("C:\\Final_Year_Project\\Pipelined_Risc_V_Core\\src\\design\\Instructions\\instructions.mem", instMem);
  end

  always @(posedge clock) begin
    if (reset == 1'b1) begin
      instruction <= 32'bx;
    end 
    else begin
      instruction <= instMem[instructionAddress[9:0]];
    end
  end

endmodule
