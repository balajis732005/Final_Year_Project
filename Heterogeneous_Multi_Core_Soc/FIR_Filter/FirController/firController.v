module fir_controller #(
    parameter INPUT_BASE  = 32'd0,
    parameter COEFF_BASE  = 32'd64,
    parameter OUTPUT_BASE = 32'd128,  
    parameter NUM_SAMPLES = 5       
)(
    input  wire        clock,
    input  wire        reset,

    /* Interface to Processor */
    output reg         fir_start,
    input  wire        fir_done,

    /* External Register File Write Port */
    output reg         fir_rf_we,
    output reg  [4:0]  fir_rf_waddr,
    output reg  [31:0] fir_rf_wdata
);

    /* FSM States */
    typedef enum reg [3:0] {
        IDLE        = 4'd0,
        SET_INPUT   = 4'd1,
        SET_COEFF   = 4'd2,
        SET_OUTPUT  = 4'd3,
        START_PROC  = 4'd4,
        WAIT_DONE   = 4'd5,
        NEXT_SAMPLE = 4'd6,
        DONE        = 4'd7
    } state_t;

    state_t state, next_state;

    reg [31:0] sample_index;

    /* =========================
       STATE REGISTER
       ========================= */
    always @(posedge clock) begin
        if (reset) begin
            state        <= IDLE;
            sample_index <= 32'd0;
        end else begin
            state <= next_state;
        end
    end

    /* =========================
       NEXT STATE LOGIC
       ========================= */
    always @(*) begin
        next_state = state;

        case (state)

            IDLE: begin
                next_state = SET_INPUT;
            end

            SET_INPUT: begin
                next_state = SET_COEFF;
            end

            SET_COEFF: begin
                next_state = SET_OUTPUT;
            end

            SET_OUTPUT: begin
                next_state = START_PROC;
            end

            START_PROC: begin
                next_state = WAIT_DONE;
            end

            WAIT_DONE: begin
                if (fir_done)
                    next_state = NEXT_SAMPLE;
            end

            NEXT_SAMPLE: begin
                if (sample_index == NUM_SAMPLES - 1)
                    next_state = DONE;
                else
                    next_state = SET_INPUT;
            end

            DONE: begin
                next_state = DONE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    /* =========================
       OUTPUT & CONTROL LOGIC
       ========================= */
    always @(posedge clock) begin
        if (reset) begin
            fir_start     <= 1'b0;
            fir_rf_we     <= 1'b0;
            fir_rf_waddr  <= 5'd0;
            fir_rf_wdata  <= 32'd0;
            sample_index  <= 32'd0;
        end else begin

            /* Defaults */
            fir_start <= 1'b0;
            fir_rf_we <= 1'b0;

            case (state)

                /* ------------------- */
                SET_INPUT: begin
                    fir_rf_we    <= 1'b1;
                    fir_rf_waddr <= 5'd10; // x10
                    fir_rf_wdata <= INPUT_BASE + (sample_index << 2);
                end

                /* ------------------- */
                SET_COEFF: begin
                    fir_rf_we    <= 1'b1;
                    fir_rf_waddr <= 5'd11; // x11
                    fir_rf_wdata <= COEFF_BASE;
                end

                /* ------------------- */
                SET_OUTPUT: begin
                    fir_rf_we    <= 1'b1;
                    fir_rf_waddr <= 5'd12; // x12
                    fir_rf_wdata <= OUTPUT_BASE + (sample_index << 2);
                end

                /* ------------------- */
                START_PROC: begin
                    fir_start <= 1'b1;
                end

                /* ------------------- */
                WAIT_DONE: begin
                    // wait
                end

                /* ------------------- */
                NEXT_SAMPLE: begin
                    sample_index <= sample_index + 1;
                end

                /* ------------------- */
                DONE: begin
                    fir_start <= 1'b0;
                end

            endcase
        end
    end

endmodule
