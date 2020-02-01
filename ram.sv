module ram (
input logic clk, read_ram, write_ram,
input logic [31:0] ram_addr, ram_write_data,
output logic [31:0] ram_out);

logic [31:0] ram_data[31:0];

integer count;

initial begin
    for (count = 0; count < 16; count = count + 1) begin
        ram_data [count] <= count;//0;
    end 
end
 
    assign ram_out = (clk && read_ram)?ram_data[ram_addr]:0;
    
    always @(negedge clk) begin
        ram_data[ram_addr] <= (write_ram)?ram_write_data:ram_data[ram_addr];
    end
    
endmodule 