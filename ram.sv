module ram (
input logic clk, read_ram, write_ram,
input logic [31:0] ram_addr, ram_write_data,
output logic [31:0] ram_out);

logic [31:0] ram_data[32'hf:0];

integer count;

initial begin
    for (count = 0; count < 16; count = count + 1) begin
        ram_data [count] <= count;//0;
    end 
end

always_comb begin
    if (clk == 1 & read_ram == 1) ram_out <= ram_data[ram_addr];
    if (clk == 0 & write_ram == 1) ram_data[ram_addr] <= ram_write_data;
end

endmodule 