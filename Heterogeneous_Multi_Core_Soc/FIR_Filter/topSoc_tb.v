module tb_soc;

    reg clock;
    reg reset;

    soc_top dut (
        .clock(clock),
        .reset(reset)
    );

    // clock
    always #5 clock = ~clock;

    initial begin
        clock = 0;
        reset = 1;

        #20;
        reset = 0;

        #4000;
        $finish;
    end

endmodule
