// 32X32 Multiplier test template
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
mult32x32 mult_test(
		.clk(clk),
		.reset(reset),
		.start(start),
		.a(a),
		.b(b),
		.busy(busy),
		.product(product)
		);
initial begin
	clk=1'b1;
	reset=1'b1;
	start=1'b0;
	a={32{1'b0}};
	b={32{1'b0}};
	#40
	reset=1'b0;
	#10
	a=318963022;
	b=319093902;
	start=1'b1;
	#60
	start=1'b0;
	end
always begin
	#10
	clk=~clk;
	end
// End of your code

endmodule
