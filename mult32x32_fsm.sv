// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    output logic busy,            // Multiplier busy indication
    output logic a_sel,           // Select one 2-byte word from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [1:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);
typedef enum {idle_st,B,C,D,E} sm_type;
sm_type current_state;
sm_type next_state;

always_ff @(posedge clk,posedge reset) begin
	if(reset==1'b1)begin
		current_state<=idle_st;
	end
	else begin
		current_state<=next_state;
	end
end

always_comb begin
	a_sel=1'b0;
	b_sel=1'b0;
	busy=1'b1;
	shift_sel[1]=1'b0;
	shift_sel[0]=1'b0;
	upd_prod=1'b1;
	clr_prod=1'b0;
	case (current_state)
		idle_st:begin
			if (start==1'b1) begin
				next_state=B;
				clr_prod=1'b1;
				upd_prod=1'b0;
				busy=1'b0;
			end
			else begin
				next_state=idle_st;
				upd_prod=1'b0;
				busy=1'b0;
			end
		end
		B: begin
			next_state=C;
			b_sel=1'b1;
			shift_sel[0]=1'b1;
			end
		C: begin
			next_state=D;
			a_sel=1'b1;
			shift_sel[0]=1'b1;
			end
		D: begin
			next_state=E;
			a_sel=1'b1;
			b_sel=1'b1;
			shift_sel[1]=1;
			end
		E: begin
			next_state=idle_st;
			end
	endcase
end
			
	
	
// Put your code here
// ------------------

// End of your code

endmodule
