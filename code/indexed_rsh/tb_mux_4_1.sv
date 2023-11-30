`timescale 1ns / 1ps

module tb();

logic [31:0] d0_tb, d1_tb, d2_tb, d3_tb, mux_out_tb;
logic[1:0] sel_tb;

mux_4_1 #(
                .data_width_param(32),
                .sel_width_param(2) )
    dut (
            .d0(d0_tb),
            .d1(d1_tb),
            .d2(d2_tb),
            .d3(d3_tb),
            .sel(sel_tb),
            .mux_4_1_out(mux_out_tb)
        );

always begin
    for(int i = 0; i < 4; i += 1) begin
        sel_tb = i;
        #1;
    end
    #1;
end

initial begin
        
        d0_tb = 32'd0;
        d1_tb = 32'd1;
        d2_tb = 32'd2;
        d3_tb = 32'd3;
        
        #5

        d0_tb = 32'habcd;
        d1_tb = 32'h1234;
        d2_tb = 32'ha1b1;
        d3_tb = 32'hc2d2;

        #5
        
        $finish();
end

endmodule