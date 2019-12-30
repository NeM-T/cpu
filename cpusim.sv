module cpusim();
logic clk, reset;

core cpu_sim(clk, reset);

assign cpu_sim.inst_mem.rom_data[0] = 32'b0000000_00010_00001_000_00001_0110011;
assign cpu_sim.inst_mem.rom_data[1] = 32'b0000000_00010_00001_000_00001_0110011;
assign cpu_sim.inst_mem.rom_data[2] = 32'b0000000_00010_00001_000_00001_0110011;

 //   for (genvar count = 0; count < 32; count = count + 1) begin
 //       assign cpu_sim.reg_cpu.reg_data [count] = count;
 //   end 
initial begin

    $dumpvars (0, cpu_sim);
    reset = 1; clk = 0; #10;
    reset = 0; #10;
    clk = 1; #10
    clk = 0; #10
    clk = 1; #10
    clk = 0; #10
    clk = 1; #10
    clk = 0; #10
    $finish;    
end
endmodule