`timescale 1ns / 1ps

//memoria para los datos del programa

module data_mem#(parameter PROG_WIDTH=10)(
    input logic we,
    input logic[1:0] ctrl_store,
    input logic[PROG_WIDTH-1:0] A,
    input logic[31:0] WD,
    output logic[31:0] data_out
);

    logic[7:0] data[0:2**PROG_WIDTH-1];
    logic[31:0] data_reg;

    initial //load inicial del programa
        $readmemh("program_data.mem",data);

    always_comb begin
        if(we) begin //escritura
            case(ctrl_store)
                2'b00: //word
                    {data[A],data[A+1],data[A+2],data[A+3]}=WD;
                2'b01: //half
                    {data[A+2],data[A+3]}=WD[15:0];
                2'b10: //byte
                    {data[A+3]}=WD[7:0];
                //default:
                default:
                    {data[A],data[A+1],data[A+2],data[A+3]}=WD;
            endcase
        end
        data_reg={data[A],data[A+1],data[A+2],data[A+3]}; //lectura
    end

    assign data_out=data_reg;
endmodule