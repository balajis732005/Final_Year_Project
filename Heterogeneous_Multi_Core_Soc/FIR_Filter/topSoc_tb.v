module tb_soc;

    reg clock;
    reg reset;

    soc_top dut (
        .clock(clock),
        .reset(reset)
    );

    // ---------------- CLOCK ----------------
    always #5 clock = ~clock;

    // ---------------- MAIN SEQUENCE ----------------
    initial begin
        clock = 0;
        reset = 1;

        // Apply reset
        #20;
        reset = 0;

        // Wait until FIR computation is done
        wait (dut.cpu.fir_done == 1'b1);

        #10;
        $display("\n================ FIR OUTPUT =================");
        $display("y[0] = %0d", dut.cpu.dataMemoryDut.dataMem[32]);
        $display("y[1] = %0d", dut.cpu.dataMemoryDut.dataMem[33]);
        $display("y[2] = %0d", dut.cpu.dataMemoryDut.dataMem[34]);
        $display("y[3] = %0d", dut.cpu.dataMemoryDut.dataMem[35]);
        $display("y[4] = %0d", dut.cpu.dataMemoryDut.dataMem[36]);
        $display("============================================\n");

        #20;
        $finish;
    end

endmodule
