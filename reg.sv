module register(
input logic clk, write_reg,
input logic [4:0] read_reg1, read_reg2, write_reg_addr,
input logic [31:0] write_reg_data,
output logic [31:0] out_reg1, out_reg2);

logic [31:0] reg_data [31:0];

for (genvar count = 0; count < 32; count = count + 1) begin
    assign reg_data [count] = 32'b0;
end 

always @ (posedge clk)begin
    out_reg1 <= reg_data[read_reg1];
    out_reg2 <= reg_data[read_reg2];
    
    if (write_reg) reg_data[write_reg_addr] <= write_reg_data;
end 
endmodule 