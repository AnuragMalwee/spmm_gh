`timescale 1ns / 1ps

module mux_4_1
#(
    parameter data_width_param = 32,
    parameter sel_width_param = 2
)
(
    input wire [data_width_param - 1 : 0] d0,
    input wire [data_width_param - 1 : 0] d1,
    input wire [data_width_param - 1 : 0] d2,
    input wire [data_width_param - 1 : 0] d3,
    input wire [sel_width_param - 1 : 0] sel,
    output reg [data_width_param - 1 : 0] mux_4_1_out
);

//reg [31:0] d0, d1, d2, d3;

always_comb begin
    
    case (sel)
        
        2'b00: mux_4_1_out = d0;
        2'b01: mux_4_1_out = d1; 
        2'b10: mux_4_1_out = d2;
        3'b11: mux_4_1_out = d3;
        default: mux_4_1_out = '0;
    
    endcase
end
endmodule