`timescale 1ns / 1ps

module multicast_multiplier(
                            input wire [31:0] scA_i,
                            input wire [127:0] rowB_i,
                            output wire [127:0] rowC_o
    );


logic [31:0] scA_sig;
integer rowB_arr[0:3], rowC_arr [0:3];

assign scA_sig = scA_i;

assign rowC_o[127:96] = rowB_i[127:96] * scA_sig;
assign rowC_o[95:64]  = rowB_i[95:64] * scA_sig; 
assign rowC_o[63:32]  = rowB_i[63:32] * scA_sig;
assign rowC_o[31:0]   = rowB_i[31:0] * scA_sig;

endmodule