`include "def.sv" 

module decode(
input logic [31:0] INST,
output logic mem_read, mem_write, reg_write, out_ctr, alu_in_ctr, 
output logic [1:0] alu_ctr, OP_mode);

always_comb begin
    mem_read <= `false; mem_write <= `false; reg_write <= `false;
    out_ctr <= `false; alu_in_ctr <= `false;
    case (INST[6:0]) 
       `OPCODE_B: begin //branch
            alu_ctr <= `ALU_SUB;
            OP_mode <= `OBJ_B;
        end
        
       `OPCODE_I: begin //LW
            alu_ctr <= `ALU_ADD;
            alu_in_ctr <= `true;
            out_ctr <= `true;
            OP_mode <= `OBJ_I;
            mem_read <=`true;
            reg_write <= `true;
        end
        
       `OPCODE_R: begin //ADD,SUB,OR,AND
            OP_mode <= `OBJ_R;
            reg_write <= `true;
            
                case (INST[14:12]) 
                   `R_ADD_SUB:begin
                        if(INST[30]) alu_ctr <= `ALU_SUB;
                        else alu_ctr <= `ALU_ADD;
                    end
                    
                   `R_OR:
                        alu_ctr <= `ALU_OR;
                        
                   `R_AND:
                        alu_ctr <= `ALU_AND;
                
                    default: ;
                endcase
        end
        
       `OPCODE_S: begin //SW
            OP_mode <= `OBJ_S;
            alu_ctr <= `ALU_ADD;
            mem_write <= `true;
            alu_in_ctr <= `true;
        end
        
        default: ;
    endcase 
end
endmodule