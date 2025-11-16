`include "design/processor.v"

module processor_tb;

    reg clock;
    reg reset;

    processor processorDut (
        .clock(clock),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clock = 1'b0;
    end

    always begin
        #5 clock = ~clock;
    end

    // Reset logic + finish
    initial begin
        reset = 1'b1;
        #10 reset = 1'b0;
        #200 $finish;
    end

    // Dumpfile for GTKWave
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, processorDut);
    end

endmodule
