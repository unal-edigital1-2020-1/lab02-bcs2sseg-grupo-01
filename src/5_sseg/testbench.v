`timescale 1ns / 1ps

module testbench;
    
	reg [15:0] num;
	reg clk;

	wire [6:0] SSeg;
	wire [4:0] an;
	wire enable;

	sseg_5display uut ( .num(num), .clk(clk), .SSeg(SSeg), .an(an), .enable(enable) );
	
	always #1 clk = ~clk;
	
	initial begin
		
		clk = 0;
		num = 16'd17185;
    
    end
    
endmodule