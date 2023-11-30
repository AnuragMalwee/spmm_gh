// Right shifts the arrays from given index, and inserts given value.

`timescale 1ns / 1ps

module indexed_rsh(
                        input wire [511:0] arr,
                        input wire [3:0] idx,
                        input wire [31:0] insert_value,
                        output wire [511:0] new_arr
                    );

logic [0:15][31:0] arr_sig, new_arr_sig;
//logic [31:0] ins_val;

assign arr_sig = arr;
assign new_arr = new_arr_sig;

// genvar i;
// generate
//     for (i=0; i < 16; i = i + 1)
//         begin
//             always_comb
//                 if(idx == i)
//                     new_arr_sig [0:15][31:0]  = {arr_sig[0:i-1][31:0], insert_value, arr_sig[i:14][31:0]};
//         end
// endgenerate



genvar i, j, offset32;
generate
    
    for (i=0; i <= 15; i++) begin
        //int offset32;
        offset32 = 32*i; 
        
            for (j=0; j <= 31; j++) begin
                always_comb begin
                if (i < idx) begin
                    new_arr_sig[offset32 + j] = arr_sig[offset32 + j];
                end else if (i == idx) begin
                    new_arr_sig[offset32 + j] = insert_value[j];
                end else begin
                    new_arr_sig[offset32 + j] = arr_sig[offset32 + j - 32];
                end
                end
            end
    end
endgenerate


endmodule