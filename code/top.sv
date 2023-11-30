`timescale 1ns / 1ps

//Top module

module top(
            input wire clk_i, rst_i,
            input wire [511:0] NVA_i, NVB_i, CIA_i, CIB_i, RPA_i, RPB_i,
            output wire [511:0] NVC_o, CIC_o, RPC_o,
            output wire op_complete

            //input matrix dimensions
    );

logic [1:0] state;

// logic [3:0] NVA_idx_sig, CIA_idx_sig, RPA_idx_sig, NVB_idx_sig, CIB_idx_sig, RPB_idx_sig;
//logic [31:0] NVA_element, NVB_element, CIA_element, CIB_element, RPA_element, RPB_element;

// logic [3:0] NVC_idx_sig, CIC_idx_sig, RPC_idx_sig, subidx_c;
// logic [511:0] NVC_sig, CIC_sig, RPC_sig;

//index signals
logic [3:0] idx_a, idx_b, idx_c; //idx for NZV and CI arrays
logic [3:0] RP_idx_a, RP_idx_b, RP_idx_c; //idx for RP arrays
logic [3:0] idx_c_search, idx_c_empty; //For NVC_arr, CIC_arr, currently searched idx and first empty idx

// array buffer outputs
logic [0:15][31:0] NVA_arr, NVB_arr, NVC_arr;
logic [0:15][3:0]  CIA_arr, CIB_arr, CIC_arr, RPA_arr, RPB_arr, RPC_arr;
logic [0:15][31:0] NVC_arr_irsh;
logic [0:15][3:0] CIC_arr_irsh;

//runtime variable signals
logic [3:0][31:0] scalar_A, curr_row_sz, curr_row_B;
logic [31:0] part_result;

//counter signals
// logic [3:0] next_idx_a, next_idx_b, next_idx_c

// Buffers
arr_reg NVA_buf (   .clk_i(clk_i), .rst_i(rst_i),
                    .d_i(NVA_i),
                    //.arr_idx_i(idx_a),
                    //.q_elem_o(NVA_element),
                    .q_o(NVA_arr)
                 );

arr_reg CIA_buf (   .clk_i(clk_i), .rst_i(rst_i),
                    .d_i(CIA_i),
//                    .arr_idx_i(idx_a),
//                    .q_elem_o(CIA_element),
                    .q_o(CIA_arr)
                 );

arr_reg RPA_buf (   .clk_i(clk_i), .rst_i(rst_i),
                    .d_i(RPA_i),
//                    .arr_idx_i(RP_idx_a),
//                    .q_elem_o(RPA_element),
                    .q_o(RPA_arr)
                 );
                 
arr_reg NVB_buf (   .clk_i(clk_i), .rst_i(rst_i),
                    .d_i(NVB_i),
//                    .arr_idx_i(idx_b),
//                    .q_elem_o(NVB_element),
                    .q_o(NVB_arr)
                 );
                 
arr_reg CIB_buf (   .clk_i(clk_i), .rst_i(rst_i),
                    .d_i(CIB_i),
//                    .arr_idx_i(idx_b),
//                    .q_elem_o(CIB_element),
                    .q_o(CIB_arr)
                 );

arr_reg RPB_buf (   .clk_i(clk_i), .rst_i(rst_i),
                    .d_i(RPB_i),
//                    .arr_idx_i(idx_b),
//                    .q_elem_o(RPB_element),
                    .q_o(RPB_arr)
                 );

//FIXME
//multicast_multiplier MUL (  .scA_i(NVA_arr[NVA_idx_sig]),
//                            .rowB_i(NVB_arr[CIB_idx_sig : CIB_idx_sig + curr_row_sz])


//                        );

//indexed_right_shifter
indexed_rsh_arr irsh_NVC (
                        .arr(NVC_arr),
                        .idx(idx_c_search),
                        .insert_value(part_result),
                        .new_arr(NVC_arr_irsh)
);

indexed_rsh_arr irsh_CIC (
                        .arr(CIC_arr),
                        .idx(idx_c_search),
                        .insert_value(part_result),
                        .new_arr(CIC_arr_irsh)
);



//index logic
assign scalar_A = NVA_arr[idx_a];

assign RP_idx_b = CIA_arr[idx_a]; //colidx_a equivalent, ref: paper - algo
//assign idx_b = RPB_arr[RP_idx_b];
assign RP_idx_c = RP_idx_a; //C's RP follows A's RP

//assign curr_row_sz = RPB_arr[RPB_idx_sig + 1] - RPB_arr[RPB_idx_sig];

//scalar - scalar multiplier (normal multiplication)
assign part_result = scalar_A * NVB_arr[idx_b];

//counters




always @(posedge clk_i or posedge rst_i)

    if(rst_i) begin
        
        state <= 0;
        
        //reset indexes
        idx_a <= '0;  //also sets scalar_A, RP_idx_b
        RP_idx_a <= '0; //also sets RP_idx_c
        
        idx_b <= '0;
        //RP_idx_b <= '0;

        idx_c <= '0;
        //RP_idx_c <= '0;
        idx_c_empty <= '0;
        idx_c_search <= '0;
        RPC_arr[0] <= '0; //1st row pointer array value is always 0
        
        NVC_arr <= '0;
        CIC_arr <= '0;
        RPC_arr <= '0;
        
        //arrays are reset as well
    end
    else begin

// state machine logic for 1 scalar-scalar multiplication and write + accumulation

    case (state)  // ###### NBA (<=) execute parallel/concurrent ##### 
    
    0: //new row in A started
        begin
            // scalar_A <= NVA_arr[NVA_idx_sig];
    
            // RPB_idx_sig <= CIA_arr[CIA_idx_sig];
            // CIB_idx_sig <= RPB_arr[RPB_idx_sig];
            // curr_row_sz <= RPB_arr[RPB_idx_sig + 1] - RPB_arr[RPB_idx_sig];

           // RP_idx_a = RP_idx_a + 1; //should be done already in the last state?

            idx_a = RPA_arr[RP_idx_a]; //sequentially? comb?
            idx_b = RPB_arr[CIA_arr[idx_a]]; //req for state 1
            //updated in case 3, 1st if

            state <= 1;
        end
    
    1: //new row in B, and new element in A started
        begin

            //idx_b <= RPB_arr[CIA_arr[idx_a]]; //prereq
            
            idx_c_search <= RPC_arr[RP_idx_c]; //init idx_c_search point to fresh row-start
            //idx_c_search resets to init value, for every new row in B

            state <= 2;
        end
                // 1: //find index in C
                //     begin
                //         RPC_idx_sig <= RPB_idx_sig; //RPC, RPB redundant
                //         CIC_idx_sig <= RPB_arr[RPC_idx_sig];
                //         //subidx_c <= CIC_idx_sig; // FIXME: signal dependancy in same clock ?
                //         part_result <= scalar_A * 
                //     end
    
    2: //new element in B, and write logic for C
        begin
            //updated idx_b - prereq
            
            // index matching logic for writing in C
            if((NVC_arr[idx_c_search] == 0)) //write logic - case 4 - empty //assuming NVC_arr initialized with 0
                begin

                    //append
                    NVC_arr[idx_c_search] <= part_result;
                    CIC_arr[idx_c_search] <= CIB_arr[idx_b];

                    //exit
                    //update state 
                    idx_b <= idx_b + 1;
                    state <= state + 1;

                end
            else if(CIC_arr[idx_c_search] < CIB_arr[idx_b]) //write logic - case 1
                begin

                    //increment idx_c_search
                    idx_c_search <= idx_c_search + 1; 

                end
            else if (CIC_arr[idx_c_search] > CIB_arr[idx_b]) //write logic - case 2
                begin

                    //decrement idx_c_search - Nope, assuming each row in B starts from col 0
                    //idx_c_search <= idx_c_search - 1; 

                    //right shift NVC_arr[idx_c_search:] and CIC_arr[idx_c_search:]
                    // and fill in 'part_result' in place shifted from, no change to idx_c_search,
                    //on next clock it should go to '1st if condition' (or write case 4)

                    NVC_arr <= NVC_arr_irsh;
                    CIC_arr <= CIC_arr_irsh;

                    //exit
                    //update state
                    idx_b <= idx_b + 1;
                    state <= state + 1;

                end
            else if(CIC_arr[idx_c_search] == CIB_arr[idx_b]) //write logic - case 3
                begin

                    //accumulate
                    NVC_arr[idx_c_search] <= NVC_arr[idx_c_search] + part_result; //NBA-clocked

                    //exit
                    //update state 
                    idx_b <= idx_b + 1;
                    state <= state + 1;

                end
            
        end
    
    endcase
    
end

endmodule