`timescale 1ns / 1ps

module reg_file(
    input logic clk,regwrite,   //clk y WE
    input logic[4:0] A1,A2,A3,  //direcciones para los registros
    input logic[31:0] WD3,      //data para la escritura
    output logic[31:0] RD1,RD2  //datos de salida
);
    logic[31:0] regs[0:31];
    //logic[31:0] data_reg1,data_reg2;

    initial
        $readmemh("regs.mem",regs);

    always_ff @(posedge clk) begin
        if(regwrite && A3!=0)
            regs[A3]<=WD3;
    end

    always_comb begin
        RD1=regs[A1];
        RD2=regs[A2];
    end

endmodule