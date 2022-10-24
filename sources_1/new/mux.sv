`timescale 1ns / 1ps

//mux generico de 2 entradas

module mux(
    input logic sel,
    input logic[31:0] in0,in1,
    output logic[31:0] out
    );

    always_comb begin
        if(sel)
            out=in0;
        else
            out=in1;
    end

endmodule
