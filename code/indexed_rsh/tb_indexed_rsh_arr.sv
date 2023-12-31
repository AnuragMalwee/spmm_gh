//idx rsh 32bit tb

`timescale 1ns / 1ps

//`define data_width 4
//`define total_elements 16
//`define idx_width 4



module tb_indexed_rsh_arr();

logic [0:15][31:0] arr_tb, new_arr_tb;
logic[31:0] ins_val_tb; //value to be inserted
logic [3:0] idx_tb; //array idx

indexed_rsh_arr #(
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
    for (int i=0; i < 16; i++) begin
        // int offset32;
        // offset32 = 32*i;
        
        arr_tb [i] = i;
    end
end

initial begin

    for (int i=0; i < 16; i++) begin
    
        ins_val_tb = i-1;
        idx_tb = i;

        #5;

    end
    
    // ins_val_tb = '0;
    // idx_tb = 4'd3;

    // #5

    // ins_val_tb = 4'h9;
    // idx_tb = 4'd9;

    // #5

    // ins_val_tb = 4'ha;
    // idx_tb = 4'd15;

    #5
    
    $finish();
end

endmodule