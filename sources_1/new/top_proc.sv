`timescale 1ns / 1ps


module top_proc(
        input logic clk,rst
        ,output logic[31:0] res,
        output logic[9:0] al_r
    );

    //param para el tamaño de las memorias
    localparam PROG_WIDTH=10;

    //señales para la unidad de control
    logic zero;
    logic PC_src;
    logic[2:0] result_src;
    logic mem_write;
    logic[3:0] ALU_control;
    logic ALU_src;
    logic[2:0] imm_src;
    logic reg_write;
    logic[1:0] ctrl_data_mem;
    logic[2:0] ctrl_sign_ext_data;

    //señales para el PC
    logic[31:0] PC_reg;
    logic[31:0] PC_next;

    logic[31:0] out_sum_PC_target,out_sum_4;
    sumador sumador_PC_target(SrcB,PC_reg,out_sum_PC_target);

    mux mux_PC_src(PC_src,out_sum_PC_target,out_sum_4,PC_next);
    sumador_PC sumador_pc(PC_reg,out_sum_4);
    PC prog_counter(clk,rst,PC_next,PC_reg);

    

    control_unit control(inst[6:0],inst[14:12],inst[31:25],zero,alu_res[0],PC_src,result_src,mem_write,ALU_control,ALU_src,imm_src,reg_write,ctrl_data_mem,ctrl_sign_ext_data);

    logic[31:0] inst;
    prog_mem #(PROG_WIDTH)instruction_memory(clk,PC_reg,inst);

    logic[31:0] RD1,RD2;
    logic[31:0] SrcB;
    logic[31:0] WD3;
    reg_file regs_f(clk,reg_write,inst[19:15],inst[24:20],inst[11:7],WD3,RD1,RD2);
    extend_sign extensor(inst,imm_src,SrcB);

    logic[31:0] out_alu_src_mux;
    mux mux_alu_src(ALU_src,SrcB,RD2,out_alu_src_mux);

    logic[31:0] alu_res;
    ALU alu(ALU_control,RD1,out_alu_src_mux,alu_res,zero);

    logic[9:0] temp;
    assign temp=alu_res[9:0];

    logic[31:0] out_data_mem;
    data_mem #(PROG_WIDTH)data_memory(mem_write,ctrl_data_mem,temp,RD2,out_data_mem);

    logic[31:0] out_data_mem_sign_ext;
    sign_extend_data_mem ext_data_mem(out_data_mem,ctrl_sign_ext_data,out_data_mem_sign_ext);

    mux4 mux_data_res_src(result_src,alu_res,out_data_mem_sign_ext,out_sum_4,out_sum_PC_target,SrcB,WD3);
    assign res=PC_reg;
    assign al_r=temp;

endmodule
