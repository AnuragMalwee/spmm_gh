`timescale 1ns / 1ps

module tb_comparator();

logic [3:0] d0_tb, d1_ref_tb;
logic [1:0] comp_out_tb;

comparator #(
                .data_width_param(4) )
    dut (
            .d0(d0_tb),
            .d1_ref(d1_ref_tb),
            .comparator_out(comp_out_tb)
        );

// always begin
//     for(int i = 0; i < 4; i += 1) begin
//         sel_tb = i;
//         #1;
//     end
//     #1;
// end

initial begin
        d0_tb = 4'b0000;
        d1_ref_tb = 4'b0000;
        
        #5
        
        d0_tb = 4'b0000;
        d1_ref_tb = 4'b1000;
        
        #5

        d0_tb = 4'b1001;
        d1_ref_tb = 4'b1011;

        #5

        d0_tb = 4'b1011;
        d1_ref_tb = 4'b1011;

        #5

        d0_tb = 4'b1111;
        d1_ref_tb = 4'b1011;

        #5
        
        $finish();
end

endmodule