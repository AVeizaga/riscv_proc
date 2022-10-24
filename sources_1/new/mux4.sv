`timescale 1ns / 1ps

module mux4(
    input logic[2:0] sel,
    input logic[31:0] in0,in1,in2,in3,in4,
    output logic[31:0] out
    );

    always_comb begin
        case(sel)
            0: out=in0;
            1: out=in1;
            2: out=in2;
            3: out=in3;
            4: out=in4;
            default: out=32'bx;
        endcase
    end
endmodule
