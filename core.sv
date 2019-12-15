`include "def.sv"

module core(
    input logic clk, reset);
    
    logic [31:0] pc_n, pc_out, inst;
    pc pc_cpu(clk, reset, pc_n, pc_out);
    
    rom inst_mem(pc_out, inst);
    
    logic [31:0]pc_4;
    pc_add4 pc_4_cpu(pc_out, pc_4);
    
    logic [31:0] jmp_inst, ext_num;
    pc_jmp jmp_cpu(pc_out, ext_num, jmp_inst);
    
    logic m_write, m_read, r_write, out_c, alu_in;
    logic [1:0] alu_mode, opcode;
    decode decode_cpu(inst, m_read, m_write, r_write, out_c, alu_in, alu_mode, opcode);
    
    logic [31:0] reg1, reg2, w_data;
    register reg_cpu(clk, r_write, inst[19:15], inst[24:20], inst[11:7], w_data, reg1, reg2);
    
    sign_ext exter(opcode, inst, ext_num);
    
    logic [31:0] alu_in2 ;
    assign alu_in2 = (alu_in)? ext_num: reg2;
    
    logic [31:0] alu_out;
    logic ZERO;
    alu alu_cpu(reg1, alu_in2, alu_mode, alu_out, ZERO);
    
    logic [31:0]pc_next;
    assign pc_next = ((opcode == `OBJ_B) & (ZERO))?jmp_inst:pc_4;
    
    logic [31:0] mem_out;
    ram memory_cpu(clk, m_read, m_write, alu_out, reg2, mem_out);
    
    assign w_data = (out_c)?mem_out:alu_out;
    
    
endmodule
