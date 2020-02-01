module core(
    input logic CLK, reset, 
    output logic [3:0]out_cpu);
    
    logic [31:0] pc_n, pc_out, inst;
    pc pc_cpu(pc_n, pc_out);
        
    rom inst_mem(pc_out/4, inst);
    
    logic [31:0]pc_4;
    pc_add4 pc_4_cpu(pc_out, pc_4);
    
    logic m_write, m_read, r_write, out_c, alu_in, branch;
    logic [1:0] alu_mode;
    logic [31:0] ext_num;
    decode decode_cpu(inst, reset, m_read, m_write, r_write, out_c, alu_in, branch, alu_mode, ext_num);
        
    logic [31:0] jmp_inst;
    pc_jmp jmp_cpu(pc_out, ext_num, jmp_inst);


    logic ZERO;    
    pc_det pc_next(jmp_inst, pc_4, ZERO, CLK, reset, branch, pc_n);    
    
    
    logic [31:0] reg1, reg2, w_data;
    register reg_cpu(CLK, r_write, inst[19:15], inst[24:20], inst[11:7], w_data, reg1, reg2);    
    logic [31:0] alu_in2 ;
    assign alu_in2 = (alu_in)? ext_num: reg2;
    
    logic [31:0] alu_out;

    alu alu_cpu(reg1, alu_in2, alu_mode, alu_out, ZERO);
    
    logic [31:0] mem_out;
    ram memory_cpu(CLK, m_read, m_write, alu_out, reg2, mem_out);
    
    assign w_data = (out_c)?mem_out:alu_out;  
    
    /*(* dont_toutch = "true" *)*/ out cpu_o(w_data, out_cpu);
endmodule

module out(
    input logic [31:0] cpu_out,
    output logic [3:0]out_t);

    assign out_t = cpu_out[3:0];
endmodule
