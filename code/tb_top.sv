`timescale 1ns / 1ps

module tb_top();

logic clk_tb, rst_tb, start_tb;
logic [3:0] rows_A_tb;

logic [0:15][31:0] NVA_tb, NVB_tb, NVC_tb;
logic [0:15][3:0]  CIA_tb, CIB_tb, CIC_tb; 
logic [0:15][3:0] RPA_tb, RPB_tb, RPC_tb;

logic op_complete_tb, computing_tb;

top
#(
        .data_width_param(32),
        .max_elements_param(16),
        .idx_width_param(4) )
    dut (
            .clk_i(clk_tb),
            .rst_i(rst_tb),
            .start_i(start_tb),

            .rows_A_i(rows_A_tb),
            
            .NVA_i(NVA_tb),
            .CIA_i(CIA_tb),
            .RPA_i(RPA_tb),
            
            .NVB_i(NVB_tb),
            .CIB_i(CIB_tb),
            .RPB_i(RPB_tb),
            
            .NVC_o(NVC_tb),
            .CIC_o(CIC_tb),
            .RPC_o(RPC_tb),
            
            .computing_o(computing_tb),
            .op_complete_o(op_complete_tb)
        );

//input initializations
always_comb begin
//     for (int i=0; i<16; i++) begin

//         case(i)

//         0

//         endcase
        
//         NVA_tb [i] = i;
//         CIA_tb [i] = i;
//         RPA_tb [i] = i;

//         NVB_tb [i] = i;
//         CIB_tb [i] = i;
//         RPB_tb [i] = i;

//     end

NVA_tb [0:6] = {32'h1, 32'h5, 32'h7, 32'h9, 32'h4, 32'h2, 32'h6};
NVA_tb [7:15] = '0;

CIA_tb [0:6] = {4'd2, 4'd1, 4'd2, 4'd0, 4'd3, 4'd0, 4'd1};
CIA_tb [7:15] = '0;

RPA_tb [0:4] = {4'd0, 4'd1, 4'd3, 4'd5, 4'd7};
RPA_tb [5:15] = '0;

rows_A_tb [3:0] = 4'd4;


NVB_tb [0:7] = {32'h1, 32'h3, 32'h1, 32'h2, 32'h2, 32'h1, 32'h5, 32'h7};
NVB_tb [8:15] = '0;

CIB_tb [0:7] = {4'd0, 4'd2, 4'd3, 4'd0, 4'd2, 4'd1, 4'd2, 4'd3};
CIB_tb [8:15] = '0;

RPB_tb [0:4] = {4'd0, 4'd3, 4'd3, 4'd5, 4'd8};
RPB_tb [5:15] = '0;

end

//clk
always begin
    clk_tb = 1'b0;
    #5;
    clk_tb = 1'b1;
    #5;
 end

//input test cases
initial begin

        rst_tb = 1'b1;
        #10;
        rst_tb = 1'b0;
        #10;
        start_tb = 1'b1;
        #10;
        start_tb = 1'b0;
        #10;
        #500;

        $finish();
end




endmodule