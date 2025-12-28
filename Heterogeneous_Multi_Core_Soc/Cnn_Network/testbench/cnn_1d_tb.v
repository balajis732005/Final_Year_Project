module tb_cnn_ecg;

    reg  signed [15:0] ecg_in [0:31];
    wire [7:0] class_out;

    cnn_ecg uut (
        .ecg_in(ecg_in),
        .class_out(class_out)
    );

    initial begin
        // --------------------------------
        // FIR-filtered ECG sample segment
        // --------------------------------
        ecg_in[0]=16'd10;  ecg_in[1]=16'd15;  ecg_in[2]=16'd20;  ecg_in[3]=16'd18;
        ecg_in[4]=16'd10;  ecg_in[5]=16'd5;   ecg_in[6]=16'd0;   ecg_in[7]=-16'd5;
        ecg_in[8]=-16'd10; ecg_in[9]=-16'd8;  ecg_in[10]=16'd0;  ecg_in[11]=16'd5;
        ecg_in[12]=16'd10; ecg_in[13]=16'd12; ecg_in[14]=16'd15; ecg_in[15]=16'd20;
        ecg_in[16]=16'd18; ecg_in[17]=16'd15; ecg_in[18]=16'd12; ecg_in[19]=16'd10;
        ecg_in[20]=16'd8;  ecg_in[21]=16'd5;  ecg_in[22]=16'd2;  ecg_in[23]=16'd0;
        ecg_in[24]=-16'd2; ecg_in[25]=-16'd5; ecg_in[26]=-16'd8; ecg_in[27]=-16'd10;
        ecg_in[28]=-16'd5; ecg_in[29]=16'd0;  ecg_in[30]=16'd5;  ecg_in[31]=16'd10;

        #10;

        // --------------------------------
        // CNN RESULT DISPLAY (Screenshot Ready)
        // --------------------------------
        $display("\n=================================================");
        $display("          ECG CNN ANALYSIS REPORT");
        $display("=================================================");
        $display("Detection Results:");
        $display("-------------------------------------------------");
        $display(" Normal ECG        : %s", class_out[0] ? "DETECTED" : "NO");
        $display(" PVC               : %s", class_out[1] ? "DETECTED" : "NO");
        $display(" Tachycardia       : %s", class_out[2] ? "DETECTED" : "NO");
        $display(" Bradycardia       : %s", class_out[3] ? "DETECTED" : "NO");
        $display(" ST Elevation      : %s", class_out[4] ? "DETECTED" : "NO");
        $display(" ST Depression     : %s", class_out[5] ? "DETECTED" : "NO");
        $display(" High R-Wave       : %s", class_out[6] ? "DETECTED" : "NO");
        $display(" Low R-Wave        : %s", class_out[7] ? "DETECTED" : "NO");
        $display("-------------------------------------------------");

        // Final medical interpretation
        if (class_out[0])
            $display(" Final Diagnosis   : NORMAL ECG");
        else
            $display(" Final Diagnosis   : ABNORMAL ECG");

        $display("=================================================\n");

        $finish;
    end
endmodule
