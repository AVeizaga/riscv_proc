`timescale 1ns / 1ps

//ALU

module ALU(
    input logic[3:0] control,
    input logic[31:0] SrcA,SrcB,
    output logic[31:0] result,
    output logic zero
);
    always_comb begin
        case(control)
            4'b0000: //Suma
                result=SrcA+SrcB;
            4'b0001: //Resta
                result=SrcA-SrcB;
            4'b0010: //OR
                result=SrcA | SrcB;
            4'b0011: //AND
                result=SrcA & SrcB;
            4'b0100: //XOR
                result=SrcA ^ SrcB;
            4'b0101: //Shift left
                result=SrcA << SrcB[4:0];
            4'b0110: //Shift right
                result=SrcA >> SrcB[4:0];
            4'b0111: //Shift right arithmetic
                result=SrcA >>> SrcB[4:0];
            4'b1000://Less than
                result=($signed(SrcA) < $signed(SrcB)) ? 32'b1 : 32'b0;
            4'b1001://Less than unsigned
                result=(SrcA < SrcB) ? 32'b1 : 32'b0;
            default:
                result=32'bx;
        endcase;
    end

    assign zero=(result==0)? 1'b1:1'b0;

endmodule