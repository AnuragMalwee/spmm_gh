`timescale 1ns / 1ps

module tb_indexed_rsh_arr();

logic [0:15][31:0] arr_tb, new_arr_tb;
logic[31:0] ins_val_tb;
logic [3:0] idx_tb;

indexed_rsh #(
                    .data_width_param(32),
                    .max_elements_param(16),
                    .idx_width_param(4) )
    dut (
            .arr(arr_tb),
            .insert_value(ins_val_tb),
            .idx(idx_tb),
            .new_arr(new_arr_tb)
        );

always_comb begin
    for (int i=0; i<16; i++) begin
        // int offset32;
        // offset32 = 32*i;
        
        arr_tb [i] = i;
    end
end

initial begin
    
    ins_val_tb = '0;
    idx_tb = 4'b0011;

    #5

    ins_val_tb = 32'h9999;
    idx_tb = 4'd9;

    #5

    ins_val_tb = 32'h1234abcd;
    idx_tb = 4'd15;

    #5
    
    $finish();
end

endmodule