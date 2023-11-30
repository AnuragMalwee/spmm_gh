`timescale 1ns / 1ps

module comparator #(
    parameter ip_width_param = 4
)
(
    input wire [ip_width_param - 1 : 0] d0,     //idx
    input wire [ip_width_param - 1 : 0] d1_ref, //i
    output reg [1 : 0] comparator_out
);

always_comb begin

    if (d1_ref < d0)
        comparator_out = 2'b01;
    else if (d1_ref == d0)
        comparator_out = 2'b10;
    else if (d1_ref > d0)
        comparator_out = 2'b11;
    else
        comparator_out = '0;
        
end
    
endmodule