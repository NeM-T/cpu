`include "def.sv" 

module decode(
input logic [31:0] INST,
input logic reset, 
output logic mem_read, mem_write, reg_write, out_ctr, alu_in_ctr,  branch, 
output logic [1:0] alu_ctr,
output logic [31:0] ext_out);

always_comb begin
    mem_read <= `false; mem_write <= `false; reg_write <= `false;
    branch <= `false; out_ctr <= `false; alu_in_ctr <= `false; 
    
    if (reset) ext_out <= 0;
    
    if (reset == 0) begin
        ext_out[31:12] <= ({20{INST[31]}});
        
        case (INST[6:0]) 
           `OPCODE_B: begin //branch beq
                alu_ctr <= `ALU_SUB;
                branch <= `true;
                ext_out[10:5] <= INST[30:25];
                ext_out[11] <= INST[7];
                ext_out[4:1] <= INST[11:8];
                ext_out[0] <= INST[31];
            end
            
           `OPCODE_I: begin //LW
                alu_ctr <= `ALU_ADD;
                alu_in_ctr <= `true;
                out_ctr <= `true;
                mem_read <=`true;
                reg_write <= `true;
                ext_out[11:0] <= INST[31:20];
            end
            
           `OPCODE_II: begin //addi
            alu_ctr <= `ALU_ADD;
            alu_in_ctr <= `true;
                   
            end 
            
           `OPCODE_R: begin //ADD,SUB,OR,AND
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
                alu_ctr <= `ALU_ADD;
                mem_write <= `true;
                alu_in_ctr <= `true;
                ext_out[11:5] <= INST[31:25];
                ext_out[4:0] <= INST[11:7];
            end
            
            default: ;
        endcase 
    end
end
endmodule