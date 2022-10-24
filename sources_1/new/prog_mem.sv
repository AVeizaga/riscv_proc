`timescale 1ns / 1ps

//memoria para las instrucciones del programa

module prog_mem #(parameter PROG_WIDTH=10)(
    input logic clk,
    input logic[31:0] addr,
    output logic[31:0] instruction 
);
    logic[7:0] rom[0:2**PROG_WIDTH-1];
    //logic[31:0] data_reg;

    initial begin
        $readmemh("program_inst.mem",rom);
    end

    assign instruction={rom[addr],rom[addr+1],rom[addr+2],rom[addr+3]};

endmodule