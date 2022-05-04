// Teszt 8 bites számláló DE0 FPGA boardhoz

module counter( 
	input			clk,
	input			reset_n,
	input			enable,
	input			direction,			//ez nem kell
	input[7:0]		parallel_in,	// ez sem
	input			load_n,				// ez sem
	output reg[7:0]	cout
);

reg[25:0] delay_counter;
reg	enable_increment;
reg dir;

always @(posedge clk)
begin: PRE_SCALER
	if (delay_counter == 50000000)
	begin
		delay_counter <= 0;
		enable_increment <= 1;
	end
	else
	begin
		delay_counter <= delay_counter + 1'b1;
		enable_increment <= 0;
	end		
end

always @(posedge clk or negedge reset_n)
begin: COUNTER
	if (reset_n == 0) 
		cout <= 8'b0;
	else 
		if (enable) 
		begin
			if (load_n == 0)
				cout <= parallel_in;
			else if (enable_increment) 
			begin
				if(cout[6] == 1)begin
				end
				if(cout[1] == 1)begin
				end
				if (dir == 1)	// balra
					cout <= {cout[6:0] + 1'b0}
				else
					cout <= {1'b0, cout[7:1]};
			end
		end
end
endmodule

