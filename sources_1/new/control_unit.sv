`timescale 1ns / 1ps

//Unidad de control
//Toma parte de la instruccion y decodifica las señales de control

module control_unit(
    input logic[6:0] op,
    input logic[2:0] funct3,
    input logic[6:0] funct7,
    input logic zero,
    input logic conditional,
    output logic PC_src,                 //source para el proximo PC
    output logic[2:0] result_src,        //source para WD
    output logic mem_write,              //WE para data memory
    output logic[3:0] ALU_control,       //control para las operaciones de la ALU
    output logic ALU_src,                //source para el segundo puerto de la ALU
    output logic[2:0] imm_src,           //tipo de immediato
    output logic reg_write,              //WE para los registros
    output logic[1:0] ctrl_data_mem,     //control para los distintos stores
    output logic[2:0] ctrl_sign_ext_data //control para los distintos loads
    );

    logic branch; //señal para los branchings
    logic jump;   //señal para los jump

    //Falta trabajar en esta parte
    //logica para branchings y jumps
    always_comb begin
        if(branch) begin
            if(funct3[2]==0) begin
                if(funct3[0]==0)
                    PC_src=zero;
                else
                    PC_src=~zero;
            end
            else begin
                if(funct3[0]==0)
                    PC_src=conditional;
                else
                    PC_src=~conditional;
            end
        end
        else begin
            PC_src=jump;
        end
    end

    always_comb begin
        branch=0;
        result_src=0;
        mem_write=0;
        ALU_control=4'b0000;
        ALU_src=0;
        imm_src=3'b000;
        reg_write=0;
        ctrl_data_mem=2'b00;
        ctrl_sign_ext_data=3'b000;
        jump=0;

        case(op)
            7'b0000011: //Loads con immediatos
                case(funct3)
                    3'b000: //(lb) load byte
                        begin
                        //branch=0;
                        result_src=1;
                        //mem_write=0;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        //ctrl_data_mem=2'b00;
                        ctrl_sign_ext_data=3'b010;
                        end
                    3'b001: //(lh) load half
                        begin
                        //branch=0;
                        result_src=1;
                        //mem_write=0;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        //ctrl_data_mem=2'b00;
                        ctrl_sign_ext_data=3'b001;
                        end
                    3'b010: //(lw) load word
                        begin
                        //branch=0;
                        result_src=1;
                        //mem_write=0;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b100: //(lbu) load byte unsigned
                        begin
                        //branch=0;
                        result_src=1;
                        //mem_write=0;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        //ctrl_data_mem=2'b00;
                        ctrl_sign_ext_data=3'b011;
                        end
                    3'b101: //(lhu) load half unsigned
                        begin
                        //branch=0;
                        result_src=1;
                        //mem_write=0;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        //ctrl_data_mem=2'b00;
                        ctrl_sign_ext_data=3'b100;
                        end
                    default:
                        branch=0;
                endcase
            7'b0010011: //Operaciones con immediatos
                case(funct3)
                    3'b000: //(addi) add immediate
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b001: //(slli) shift lef logical immediate
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0101;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b010: //(slti) set less than immediate
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b011: //(sltiu) set less than immediate unsigned
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1001;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b100: //(xori) xor immediate
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0100;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b101: //(srli) y (srai)
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        //ALU_control=3'b000;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        if(funct7[5]) //(srai) shift right arithmetic immediate
                            ALU_control=4'b0111;
                        else //(srli) shift right logical immediate
                            ALU_control=4'b0110;
                        end
                    3'b110: //(ori) or immediate
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0010;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b111: //(andi) and immediate
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0011;
                        ALU_src=1;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    default:
                        branch=0;
                        
                endcase
            7'b0010111: //(auipc) add upper immediate to PC
                begin
                //branch=0;
                result_src=4;
                //mem_write=0;
                //ALU_control=4'b0000;
                ALU_src=1;
                imm_src=3'b100;
                reg_write=1;
                //ctrl_data_mem=2'b00;
                //ctrl_sign_ext_data=3'b000;
                end
            7'b0100011: //stores   // Por completar
                case(funct3)
                    3'b000: //(sb) store byte
                        begin
                        //branch=0;
                        //result_src=0;
                        mem_write=1;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        imm_src=3'b001;
                        //reg_write=0;
                        ctrl_data_mem=2'b10;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b001: //(sh) store half
                        begin
                        //branch=0;
                        //result_src=0;
                        mem_write=1;
                        //ALU_control=4'b0000;
                        ALU_src=1;
                        imm_src=3'b001;
                        //reg_write=0;
                        ctrl_data_mem=2'b01;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b010: //(sw) store word
                        begin
                        //branch=0;
                        //result_src=0;
                        mem_write=1;
                        //ALU_control7=4'b0000;
                        ALU_src=1;
                        imm_src=3'b001;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    default:
                        branch=0;
                endcase
            7'b0110011:
                case(funct3)
                    3'b000: //(add) y (sub)
                        begin
                        if(funct7[5]) //(sub) substraction
                            begin
                            //branch=0;
                            //result_src=0;
                            //mem_write=0;
                            ALU_control=4'b0001;
                            //ALU_src=0;
                            //imm_src=2'b00;
                            reg_write=1;
                            end
                        else //(add) addition
                            begin
                            //branch=0;
                            //result_src=0;
                            //mem_write=0;
                            ALU_control=4'b0000;
                            //ALU_src=0;
                            //imm_src=2'b00;
                            reg_write=1;
                            end
                        end
                    3'b001: //(sll) shift lef logical
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0101;
                        //ALU_src=0;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b010: //(slt) set less than
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1000;
                        //ALU_src=0;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b011: //(sltu) set less than unsigned
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1001;
                        //ALU_src=0;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b100: //(xor) xor
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0100;
                        //ALU_src=0;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b101: //(srl) y (sra)
                        begin
                        if(funct7[5]) //(sra) shift right arithmetic
                            begin
                            //branch=0;
                            //result_src=0;
                            //mem_write=0;
                            ALU_control=4'b0111;
                            //ALU_src=0;
                            //imm_src=2'b00;
                            reg_write=1;
                            end
                        else //(srl) shift right logical
                            begin
                            //branch=0;
                            //result_src=0;
                            //mem_write=0;
                            ALU_control=4'b0110;
                            //ALU_src=0;
                            //imm_src=2'b00;
                            reg_write=1;
                            end
                        end
                    3'b110: //(or) or
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0010;
                        //ALU_src=0;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    3'b111: //(and) and
                        begin
                        //branch=0;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0011;
                        //ALU_src=0;
                        //imm_src=2'b00;
                        reg_write=1;
                        end
                    default:
                        branch=0;
                        
                endcase
            7'b0110111: //(lui) load upper immediate
                begin
                //branch=0;
                result_src=3;
                //mem_write=0;
                //ALU_control=4'b0000;
                //ALU_src=0;
                imm_src=3'b100;
                reg_write=1;
                //ctrl_data_mem=2'b00;
                //ctrl_sign_ext_data=3'b000;
                end
            7'b1100011: // Branchings
                case(funct3)
                    3'b000: //(beq) branch if equal
                        begin
                        branch=1;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0001;
                        //ALU_src=0;
                        imm_src=3'b010;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b001: //(bne) branch if not equal
                        begin
                        branch=1;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b0001;
                        //ALU_src=0;
                        imm_src=3'b010;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b100: //(blt) branch if less than
                        begin
                        branch=1;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1000;
                        //ALU_src=0;
                        imm_src=3'b010;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b101: //(bge) branch if greater than
                        begin
                        branch=1;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1000;
                        //ALU_src=0;
                        imm_src=3'b010;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b110: //(bltu) branch if less than unsigned
                        begin
                        branch=1;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1001;
                        //ALU_src=0;
                        imm_src=3'b010;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    3'b111: //(bgeu) branch if greater than unsigned
                        begin
                        branch=1;
                        //result_src=0;
                        //mem_write=0;
                        ALU_control=4'b1001;
                        //ALU_src=0;
                        imm_src=3'b010;
                        //reg_write=0;
                        //ctrl_data_mem=2'b00;
                        //ctrl_sign_ext_data=3'b000;
                        end
                    default:
                        branch=0;
                endcase
            7'b1100111: //(jalr) jump and link register // Por completar
                begin
                //branch=0;
                result_src=2;
                //mem_write=0;
                ALU_control=4'b0000;
                //ALU_src=0;
                //imm_src=3'b000;
                reg_write=1;
                //ctrl_data_mem=2'b00;
                //ctrl_sign_ext_data=3'b000;
                jump=1;
                //-----------------control para la suma entre rd1 y el imm
                end
            7'b1101111: //(jal) jump and link
                begin
                //branch=0;
                result_src=2;
                //mem_write=0;
                ALU_control=4'b0000;
                //ALU_src=0;
                imm_src=3'b011;
                reg_write=1;
                //ctrl_data_mem=2'b00;
                //ctrl_sign_ext_data=3'b000;
                jump=1;
                end
            default:
                branch=0;
                
        endcase
    end

endmodule
