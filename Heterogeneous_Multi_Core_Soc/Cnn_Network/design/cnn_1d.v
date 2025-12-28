module cnn_ecg #(
    parameter N = 32  // input samples
)(
    input  wire [15:0] ecg_in [0:N-1],   // FIR filtered ECG
    output reg  [7:0] class_out          // 8-bit detection output
);

    // ----------------------
    // Conv1: 3 filters, kernel size 3
    // ----------------------
    reg signed [15:0] conv1_weights [0:2][0:2];

    initial begin
        // Filter 0
        conv1_weights[0][0] = 16'd500; conv1_weights[0][1] = 16'd1000; conv1_weights[0][2] = -16'd300;
        // Filter 1
        conv1_weights[1][0] = 16'd700; conv1_weights[1][1] = -16'd400; conv1_weights[1][2] = 16'd600;
        // Filter 2
        conv1_weights[2][0] = 16'd200; conv1_weights[2][1] = 16'd300;  conv1_weights[2][2] = 16'd400;
    end

    reg signed [15:0] conv1_out [0:2][0:N-3]; // 30 outputs

    integer i,f,j;

    // ----------------------
    // MaxPool 1: pool size 2
    // ----------------------
    reg signed [15:0] pool1_out [0:2][0:14];  // 15 outputs

    // ----------------------
    // Conv2: 2 filters, kernel size 3
    // ----------------------
    reg signed [15:0] conv2_weights [0:1][0:2][0:2]; // 2 filters x 3 channels x 3 kernel
    reg signed [15:0] conv2_out [0:1][0:12]; // 13 outputs

    initial begin
        // Filter 0
        conv2_weights[0][0][0]=16'd100; conv2_weights[0][0][1]=16'd200; conv2_weights[0][0][2]=16'd150;
        conv2_weights[0][1][0]=16'd50;  conv2_weights[0][1][1]=16'd100; conv2_weights[0][1][2]=16'd80;
        conv2_weights[0][2][0]=16'd30;  conv2_weights[0][2][1]=16'd60;  conv2_weights[0][2][2]=16'd90;

        // Filter 1
        conv2_weights[1][0][0]=16'd70;  conv2_weights[1][0][1]=16'd120; conv2_weights[1][0][2]=16'd90;
        conv2_weights[1][1][0]=16'd40;  conv2_weights[1][1][1]=16'd80;  conv2_weights[1][1][2]=16'd60;
        conv2_weights[1][2][0]=16'd20;  conv2_weights[1][2][1]=16'd40;  conv2_weights[1][2][2]=16'd30;
    end

    // ----------------------
    // Pool2: pool size 2
    // ----------------------
    reg signed [15:0] pool2_out [0:1][0:6];  // 7 outputs

    // ----------------------
    // Fully connected weights (8 outputs)
    // ----------------------
    reg signed [15:0] fc_weights [0:7][0:6]; // 8 outputs x 7 inputs
    initial begin
        // Example arbitrary weights for demonstration
        for(i=0;i<7;i=i+1) begin
            fc_weights[0][i]=16'd100 + i*10; // Normal
            fc_weights[1][i]=16'd80  + i*12; // PVC
            fc_weights[2][i]=16'd90  + i*8;  // Tachycardia
            fc_weights[3][i]=16'd70  + i*9;  // Bradycardia
            fc_weights[4][i]=16'd60  + i*15; // ST Elevation
            fc_weights[5][i]=16'd65  + i*11; // ST Depression
            fc_weights[6][i]=16'd50  + i*14; // High R-wave
            fc_weights[7][i]=16'd55  + i*10; // Low R-wave
        end
    end

    reg signed [31:0] fc_sum [0:7]; // accumulator for FC
    reg signed [31:0] threshold [0:7]; // thresholds for detection

    initial begin
        // Simple thresholds for detection
        threshold[0]=32'd1000; threshold[1]=32'd900; threshold[2]=32'd950; threshold[3]=32'd900;
        threshold[4]=32'd800;  threshold[5]=32'd850; threshold[6]=32'd700; threshold[7]=32'd750;
    end

    // ----------------------
    // CNN Forward
    // ----------------------
    always @(*) begin
        // Conv1 + ReLU
        for(f=0; f<3; f=f+1) begin
            for(i=0;i<N-2;i=i+1) begin
                conv1_out[f][i]=0;
                for(j=0;j<3;j=j+1)
                    conv1_out[f][i] = conv1_out[f][i] + ecg_in[i+j]*conv1_weights[f][j];
                if(conv1_out[f][i]<0) conv1_out[f][i]=0;
            end
        end

        // MaxPool1 size 2
        for(f=0; f<3; f=f+1) begin
            for(i=0;i<15;i=i+1) begin
                pool1_out[f][i] = (conv1_out[f][2*i] > conv1_out[f][2*i+1]) ? conv1_out[f][2*i] : conv1_out[f][2*i+1];
            end
        end

        // Conv2 + ReLU
        for(f=0; f<2; f=f+1) begin
            for(i=0;i<13;i=i+1) begin
                conv2_out[f][i]=0;
                for(j=0;j<3;j=j+1) begin
                    conv2_out[f][i] = conv2_out[f][i] + pool1_out[j][i]*conv2_weights[f][j][0]
                                                    + pool1_out[j][i+1]*conv2_weights[f][j][1]
                                                    + pool1_out[j][i+2]*conv2_weights[f][j][2];
                end
                if(conv2_out[f][i]<0) conv2_out[f][i]=0;
            end
        end

        // MaxPool2 size 2
        for(f=0; f<2; f=f+1) begin
            for(i=0;i<7;i=i+1) begin
                pool2_out[f][i] = (conv2_out[f][2*i] > conv2_out[f][2*i+1]) ? conv2_out[f][2*i] : conv2_out[f][2*i+1];
            end
        end

        // Fully connected
        for(f=0; f<8; f=f+1) begin
            fc_sum[f]=0;
            for(i=0;i<7;i=i+1)
                fc_sum[f] = fc_sum[f] + pool2_out[(f<2)?f:0][i]*fc_weights[f][i]; // simple mapping
            // Apply threshold
            if(fc_sum[f] > threshold[f])
                class_out[f]=1'b1;
            else
                class_out[f]=1'b0;
        end
    end

endmodule
