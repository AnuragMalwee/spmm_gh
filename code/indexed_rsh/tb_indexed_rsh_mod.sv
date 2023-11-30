`timescale 1ns / 1ps

module tb_indexed_rsh_mod();

logic [31:0] curr_arr_val_tb, arr_prev_val_tb, ins_val_tb, new_arr_val_tb;
logic [3:0] idx_tb, const_ref_tb;

indexed_rsh_mod #(
                    .data_width_param(32),
                    .idx_width_param(4),
                    .sel_width_param(2) )
    dut (
            .curr_arr_val(curr_arr_val_tb),
            .ins_val(ins_val_tb),
            .arr_prev_val(arr_prev_val_tb),
            .idx(idx_tb),
            .const_ref(const_ref_tb),
            .new_arr_val(new_arr_val_tb)
        );

initial begin
        
        curr_arr_val_tb = 32'd100;
        ins_val_tb = 32'd300;
        arr_prev_val_tb = 32'd99;

        idx_tb = 4'b0101;
        const_ref_tb = 4'b1010;
       
        #5

        curr_arr_val_tb = 32'd1111;
        ins_val_tb = 32'd3333;
        arr_prev_val_tb = 32'd9999;

        idx_tb = 4'b1001;
        const_ref_tb = 4'b1001;

        #5

        curr_arr_val_tb = 32'd4050;
        ins_val_tb = 32'd4070;
        arr_prev_val_tb = 32'd4090;

        idx_tb = 4'b1111;
        const_ref_tb = 4'b1001;

        #5
        
        $finish();
end

endmodule