`timescale 1ns / 1ps

// top wrapper module for 'indexed right-shift and insert'

module indexed_rsh_mod #(
    parameter data_width_param = 32,
    parameter idx_width_param = 4,
    parameter sel_width_param = 2 //sel always = 2 for 4:1 mux
)
(
    input wire [data_width_param - 1 : 0] curr_arr_val,
    input wire [data_width_param - 1 : 0] ins_val,
    input wire [data_width_param - 1 : 0] arr_prev_val,
    
    input wire [idx_width_param - 1 : 0] idx,
    input wire [idx_width_param - 1 : 0] const_ref,
    
    output reg [data_width_param - 1 : 0] new_arr_val
);

//signals
logic [1:0] comparator_out_sig;

comparator #(
                .ip_width_param(idx_width_param) )
    cmp (
            .d0(idx),
            .d1_ref(const_ref),
            .comparator_out(comparator_out_sig)
        );

mux_4_1 #(
            .data_width_param(data_width_param),
            .sel_width_param(sel_width_param) )  //sel always = 2 for 4:1 mux
    mux (
            .d0(0), //not used
            .d1(curr_arr_val),
            .d2(ins_val),
            .d3(arr_prev_val),
            
            .sel(comparator_out_sig),
            .mux_4_1_out(new_arr_val)
);

endmodule