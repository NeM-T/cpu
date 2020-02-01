module cpusim();
logic clk, reset;

core cpu_sim(clk, reset);

// assign cpu_sim.inst_mem.rom_data[0] = 32'b0000000_00010_00001_000_00001_0110011; //add x1, x2, x1
// assign cpu_sim.inst_mem.rom_data[1] = 32'b0000000_00010_00001_000_00001_0110011; //add x1, x2, x1
// assign cpu_sim.inst_mem.rom_data[2] = 32'b0100000_00010_00001_000_00001_0110011; //sub x1, x2, x1
// assign cpu_sim.inst_mem.rom_data[3] = 32'b0000000_00010_00001_110_00011_0110011; //or x1, x2, x3
// assign cpu_sim.inst_mem.rom_data[4] = 32'b0000000_00010_00001_111_00011_0110011; //and x1, x2, x3
// assign cpu_sim.inst_mem.rom_data[5] = 32'b0000000_00010_00001_010_00000_0100011; //sw x1
// assign cpu_sim.inst_mem.rom_data[6] = 32'b0000000_00000_00001_010_00001_0000011; //lw x1
// assign cpu_sim.inst_mem.rom_data[7] = 32'b0000000_00011_00001_000_00001_0010011; //addi x1, 3, x1


initial begin

    $dumpvars (0, cpu_sim);
    reset = 1; clk = 1; #10; clk = 0; #10; reset = 0;
    clk = 1; #10 clk = 0; #10
    clk = 1; #10 clk = 0; #10
    clk = 1; #10 clk = 0; #10
    clk = 1; #10 clk = 0; #10 
    clk = 1; #10 clk = 0; #10 
    clk = 1; #10 clk = 0; #10
    clk = 1; #10 clk = 0; #10
    clk = 1; #10 clk = 0; #10 
    $finish;    
end
endmodule
