`timescale 1ns / 1ps

//sumador para el siguiente PC

module sumador_PC(
    input logic[31:0] PC_in,
    output logic[31:0] PC_next
    );

    assign PC_next=PC_in+4;

endmodule
