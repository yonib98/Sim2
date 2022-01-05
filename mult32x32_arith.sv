// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic a_sel,           // Select one 2-byte word from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [1:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

logic [15:0] a_out;
logic [15:0] b_out;
logic [31:0] mult_result;
logic [63:0] shift_result;
logic [63:0] shift_result_0;
logic [63:0] shift_result_16;
logic [63:0] shift_result_32;
// Put your code here
// ------------------
always_comb begin
	case(a_sel)
	1'b0: a_out=a[15:0];
	1'b1: a_out=a[31:16];
	endcase
	case(b_sel)
	1'b0: b_out=b[15:0];
	1'b1: b_out=b[31:16];
	endcase
	mult_result=a_out*b_out;
	shift_result_0=mult_result;
	shift_result_16={{16{1'b0}},mult_result[31:0],{16{1'b0}}};
	shift_result_32={mult_result[31:0],{32{1'b0}}};
	
	case(shift_sel)
	2'd0:shift_result=shift_result_0;
	2'd1:shift_result=shift_result_16;
	2'd2:shift_result=shift_result_32;
	endcase
end
always_ff @(posedge clk,posedge reset) begin
	if(reset==1'b1) begin
		product<={64{1'b0}};
		end
	else begin
		if(upd_prod==1'b1) begin
			product<=product+shift_result;
			end
		if(clr_prod==1'b1) begin
			product<={64{1'b0}};
			end
	end
end
		

// End of your code

endmodule
