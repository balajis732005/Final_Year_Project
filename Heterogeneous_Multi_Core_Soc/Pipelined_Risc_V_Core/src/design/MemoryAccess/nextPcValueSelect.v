module nextPcValueSelect(
    input  pcUpdate, 
    input  branchAlu, 
    output reg pcSelectOut
);

    always @(*) begin
        pcSelectOut = pcUpdate & branchAlu;   // Jump only if both are 1
    end

endmodule
