`timescale 1ns / 1ps

//extensor de signo para los loads

module sign_extend_data_mem(
    input logic[31:0] in_data,
    input logic[2:0] ctrl,
    output logic[31:0] out_data
    );

    always_comb begin
        case(ctrl)
            3'b000: //word
                out_data=in_data;
            3'b001: //half
                out_data={{16{in_data[15]}},in_data[15:0]};
            3'b010: //byte
                out_data={{24{in_data[7]}},in_data[7:0]};
            3'b011: //half unsigned
                out_data={{16{1'b0}},in_data[15:0]};
            3'b100: //byte unsigned
                out_data={{24{1'b0}},in_data[7:0]};
            default:
                out_data=32'bx;
        endcase
    end

endmodule
