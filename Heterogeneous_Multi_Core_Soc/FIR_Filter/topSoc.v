module soc_top (
    input wire clock,
    input wire reset
);

    /* FIR Processor wires */
    wire        fir_start;
    wire        fir_done;

    wire        fir_rf_we;
    wire [4:0]  fir_rf_waddr;
    wire [31:0] fir_rf_wdata;

    /* =========================
       FIR Controller
       ========================= */
    fir_controller #(
        .INPUT_BASE (32'h0000_1000),
        .COEFF_BASE (32'h0000_2000),
        .OUTPUT_BASE(32'h0000_3000),
        .NUM_SAMPLES(16)
    ) fir_ctrl (
        .clock(clock),
        .reset(reset),

        .fir_start(fir_start),
        .fir_done (fir_done),

        .fir_rf_we    (fir_rf_we),
        .fir_rf_waddr (fir_rf_waddr),
        .fir_rf_wdata (fir_rf_wdata)
    );

    /* =========================
       Processor Core
       ========================= */
    processor cpu (
        .clock(clock),
        .reset(reset),

        .fir_start(fir_start),
        .fir_done (fir_done),

        .fir_rf_we    (fir_rf_we),
        .fir_rf_waddr (fir_rf_waddr),
        .fir_rf_wdata (fir_rf_wdata)
    );

endmodule
