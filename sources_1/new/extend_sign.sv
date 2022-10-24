`timescale 1ns / 1ps

//extensor de signo para los immediatos

module extend_sign(
    input logic[31:0] in,
    input logic[2:0] ctrl,
    output logic[31:0] out
    );

    always_comb begin
        case(ctrl)
            3'b000: //tipo I
                out={{20{in[31]}},in[31:20]};
            3'b001: //tipo S
                out={{20{in[31]}},in[31:25],in[11:7]};
            3'b010: //Tipo B
                out={{20{in[31]}},in[7],in[30:25],in[11:8],1'b0};
            3'b011: //tipo J
                out={{12{in[31]}},in[19:12],in[20],in[30:21],1'b0};
            3'b100: //tipo U
                out={in[31:12],12'b0};
            default:
                out=32'bx;
        endcase
    end
endmodule
