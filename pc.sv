`include "def.sv"

module pc(
    input logic clk, reset,
    input logic [31:0]pc_num, 
    output logic [31:0] out_pc);
    
always @(posedge clk) begin
    out_pc <= pc_num;
end
endmodule

module pc_add4(
    input logic [31:0]num,
    output logic [31:0]inc_pc);
        
    assign inc_pc = num + 1;
endmodule

module pc_jmp(
    input logic [31:0] num1, num2, 
    output logic [31:0] jmp_addr);

    assign jmp_addr = num1 + num2;
endmodule

module pc_det (
    input logic [31:0] tar_inst, pc_inc,
    input logic ZERO, clk, reset, branch,
    output logic [31:0] pc_next);

    logic [31:0] pc_nu;
    assign pc_nu = (branch && ZERO)?tar_inst:pc_inc;
    
    always_comb begin
        case(reset)
            `true :pc_next <= 0;
            
            `false: begin
                if(clk) pc_next <= pc_nu;
             end
        endcase 
    end
    
endmodule
