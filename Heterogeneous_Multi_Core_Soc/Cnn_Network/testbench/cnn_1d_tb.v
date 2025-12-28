module tb_cnn_ecg;

    reg [15:0] ecg_in [0:31];
    wire [7:0] class_out;

    cnn_ecg uut (.ecg_in(ecg_in), .class_out(class_out));

    integer i;

    initial begin
        // Example FIR-filtered ECG samples
        ecg_in[0]=16'd10; ecg_in[1]=16'd15; ecg_in[2]=16'd20; ecg_in[3]=16'd18;
        ecg_in[4]=16'd10; ecg_in[5]=16'd5;  ecg_in[6]=16'd0;  ecg_in[7]=-16'd5;
        ecg_in[8]=-16'd10; ecg_in[9]=-16'd8; ecg_in[10]=16'd0; ecg_in[11]=16'd5;
        ecg_in[12]=16'd10; ecg_in[13]=16'd12; ecg_in[14]=16'd15; ecg_in[15]=16'd20;
        ecg_in[16]=16'd18; ecg_in[17]=16'd15; ecg_in[18]=16'd12; ecg_in[19]=16'd10;
        ecg_in[20]=16'd8; ecg_in[21]=16'd5;  ecg_in[22]=16'd2;  ecg_in[23]=16'd0;
        ecg_in[24]=-16'd2; ecg_in[25]=-16'd5; ecg_in[26]=-16'd8; ecg_in[27]=-16'd10;
        ecg_in[28]=-16'd5; ecg_in[29]=16'd0;  ecg_in[30]=16'd5;  ecg_in[31]=16'd10;

        #10;
        $display("ECG Segment Analysis:");
        $display("Normal: %s",   class_out[0] ? "YES":"NO");
        $display("PVC: %s",      class_out[1] ? "YES":"NO");
        $display("Tachycardia: %s", class_out[2] ? "YES":"NO");
        $display("Bradycardia: %s", class_out[3] ? "YES":"NO");
        $display("ST Elevation: %s", class_out[4] ? "YES":"NO");
        $display("ST Depression: %s", class_out[5] ? "YES":"NO");
        $display("High R-wave: %s", class_out[6] ? "YES":"NO");
        $display("Low R-wave: %s", class_out[7] ? "YES":"NO");

        $finish;
    end
endmodule
