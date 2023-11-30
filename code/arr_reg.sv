`timescale 1ns / 1ps

//Multibit input is organised into 16x 32 bit registers 
// mapping - 511:0 ~ 15:0

module arr_reg(
                input logic clk_i,
                input logic rst_i,
                
                input logic [511:0] d_i, //32bit x 16 elements in matrix.
                
               // input logic [3:0] arr_idx_i,
                
                output logic [511:0] q_o
               // output logic [31:0] q_elem_o
                );


logic [511:0] q_sig;  

always_ff @(posedge clk_i or posedge rst_i)
    if(rst_i)
        q_sig <= '0;
    else
        q_sig <= d_i;
//end

assign q_o = q_sig;

//slector logic

//always_comb begin

//    case (arr_idx_i)
        
    
//        4'b0000 : q_elem_o = q_sig[511:480];
        
//        4'b0001: q_elem_o = q_sig[479:448];
        
//        4'b0010: q_elem_o = q_sig[447:416];
        
//        4'b0011: q_elem_o = q_sig[415:384];
        
//        4'b0100: q_elem_o = q_sig[383:352];
        
//        4'b0101: q_elem_o = q_sig[351:320];
        
//        4'b0110: q_elem_o = q_sig[319:288];//
        
//        4'b0111: q_elem_o = q_sig[287:256]; //
        
//        4'b1000: q_elem_o = q_sig[255:224];
        
//        4'b1001: q_elem_o = q_sig[223:192];
        
//        4'b1010: q_elem_o = q_sig[191:160];
        
//        4'b1011: q_elem_o = q_sig[159:128];
        
//        4'b1100: q_elem_o = q_sig[127:96];
        
//        4'b1101: q_elem_o = q_sig[95:64];
        
//        4'b1110: q_elem_o = q_sig[63:32];
        
//        4'b1111: q_elem_o = q_sig[31:0];
        
//        default : q_elem_o = 0;
//      endcase
//end
endmodule        