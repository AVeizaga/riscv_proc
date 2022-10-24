`timescale 1ns / 1ps

//sumador generico

module sumador(
    input logic[31:0] in0,in1,
    output logic[31:0] out
    );
    assign out=in0+in1;
endmodule
