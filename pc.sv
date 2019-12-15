module pc(
    input logic clk, reset,
    input logic [31:0]pc_num, 
    output logic [31:0] out_pc);
    
always @(posedge clk) begin
    out_pc <= pc_num;
end

always @(posedge reset) begin
    out_pc <= 0;
end
endmodule

module pc_add4(
    input logic [31:0]num,
    output logic [31:0]inc_pc);
        
    assign inc_pc = num + 4;
endmodule

module pc_jmp(
    input logic [31:0] num1, num2, 
    output logic [31:0] jmp_addr);

    assign jmp_addr = num1 + num2;
endmodule