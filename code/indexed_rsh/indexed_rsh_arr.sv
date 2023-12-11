`timescale 1ns / 1ps

module indexed_rsh_arr #(
    parameter data_width_param = 32,
    parameter max_elements_param = 16,
    parameter idx_width_param = 4
)
(
    input wire [(data_width_param * max_elements_param - 1) : 0] arr, // 511:0 size here
    input wire [(idx_width_param - 1 ):0] idx,
    input wire [(data_width_param - 1):0] insert_value,
    output reg [(data_width_param * max_elements_param - 1):0] new_arr
);

logic [0 : (max_elements_param - 1)][(data_width_param - 1) : 0] arr_sig, new_arr_sig;
//logic [31:0] ins_val;

assign arr_sig = arr;
assign new_arr = new_arr_sig;

genvar i;
generate
    indexed_rsh_mod #(
                            .data_width_param(data_width_param),
                            .idx_width_param(idx_width_param),
                            .sel_width_param(2) ) //sel always = 2 for 4:1 mux
        idx_rsh_unit_0 (
                        .curr_arr_val(arr_sig[0]),
                        .ins_val(insert_value),
                        .arr_prev_val('0),
                        .idx(idx),
                        .const_ref('0),
                        .new_arr_val(new_arr_sig[0])
                        );
        
    for(i=1; i < max_elements_param; i = i+1) begin
        
        indexed_rsh_mod #(
                            .data_width_param(data_width_param),
                            .idx_width_param(idx_width_param),
                            .sel_width_param(2) ) //sel always = 2 for 4:1 mux
        idx_rsh_unit_i (
                        .curr_arr_val(arr_sig[i]),
                        .ins_val(insert_value),
                        .arr_prev_val(arr_sig[i-1]),
                        .idx(idx),
                        .const_ref(i),
                        .new_arr_val(new_arr_sig[i])
        );
    end
endgenerate

endmodule