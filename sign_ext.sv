`include "def.sv"

module sign_ext(
input logic [1:0] mode,
input logic [31:0] INST,
output logic [31:0] ext_out);

always_comb begin
ext_out[31] <= INST[31];

case (mode)
   `OBJ_B:begin //branch
        ext_out[11]   <= INST[7];
        ext_out[10:5] <= INST[30:25];
        ext_out[4:1]  <= INST[11:8];
    end
   
   `OBJ_I: ext_out[10:0] <= INST[30:20]; //lw
   
   `OBJ_R: ext_out <= 0; //add,sub,or,not

   `OBJ_S:begin //sw
        ext_out[10:5] <= INST[30:25];
        ext_out[4:0]  <= INST[11:7];
    end
   
    default: ;
endcase
end
endmodule