`timescale 1ns / 1ps

//flip flop para el PC

module PC(
    input logic clk,rst,
    input logic[31:0] PC_next,
    output logic[31:0] PC_out
    );

    logic[31:0] state_reg,state_next;

    always_ff @(posedge clk) begin
        if(rst)
            state_reg<=0;
        else
            state_reg<=state_next;
    end

    always_comb begin
        state_next=PC_next;
    end

    assign PC_out=state_reg;

endmodule
