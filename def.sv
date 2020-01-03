`define ALU_AND       2'b00
`define ALU_OR        2'b01
`define ALU_ADD       2'b10
`define ALU_SUB       2'b11

`define OPCODE_B      7'b1100011  //branch
`define OPCODE_I      7'b0000011  //lw
`define OPCODE_II     7'b0010011  //addi
`define OPCODE_R      7'b0110011  //add,sub,or,and
`define OPCODE_S      7'b0100011  //sw

`define R_ADD_SUB 3'b000
`define R_OR      3'b110
`define R_AND     3'b111

`define true          1'b1
`define false         1'b0