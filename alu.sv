`include "def.sv"
module alu(
    input logic [31:0] aluin1, aluin2, 
    input logic [1:0] aluctr,
    output logic [31:0] aluout, 
    output logic zero);
 
 
    always_comb begin
    
        case(aluctr)
        
           `ALU_ADD : aluout <= aluin1 + aluin2;
            
           `ALU_SUB : aluout <= aluin1 - aluin2;
           
           `ALU_AND : aluout <= aluin1 & aluin2;
           
           `ALU_OR  : aluout <= aluin1 | aluin2;
            default: aluout <= 0;
        endcase 
        
        zero <= aluout & 0;
    end 
endmodule 