`timescale 1ns / 1ps

module tb();

  logic [0:15][31:0] tb_arr_sig, tb_new_arr_sig, tb_val;
logic [3:0] tb_idx_sig;
logic clk;

indexed_rsh dut (
                    .arr(tb_arr_sig),
                    .idx(tb_idx_sig),
                    .insert_value(tb_val),
                    .new_arr(tb_new_arr_sig)
                );

always
    begin
        clk = 0;
        #5;
        
        #5 clk = ~clk;
    end

//assign arr
//genvar i;
always_comb begin
    for (int i=0; i<16; i++) begin
        int offset32;
        offset32 = 32*i;
        
        // for (int j=0; j<32; j++) begin
        tb_arr_sig [i][31:0] = i;
        //end
    end
end
  
initial
    begin
        
        tb_val = '0;
        tb_idx_sig = 3;
        #30;

        tb_idx_sig = 10;

        #30;
    end

initial begin
  $dumpfile("tb_op.vcd");
  $dumpvars(0, tb);
  end

endmodule

