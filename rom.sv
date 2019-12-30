module rom(
input logic [31:0] rom_addr, 
output logic [31:0] rom_out);

logic [31:0]rom_data [32'hf:0];

assign rom_out = rom_data[rom_addr];
endmodule