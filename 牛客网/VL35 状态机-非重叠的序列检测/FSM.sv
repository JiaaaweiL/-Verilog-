`timescale 1ns/1ns

module sequence_test1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;

reg	[2:0] state, next_state;


always @(posedge clk or negedge rst) begin
	if(!rst) begin
		state <= 'b0;
	end else begin
		state <= next_state;
	end
end


always @(*) begin
	case(state)
		S0:	next_state = data ? S1 : S0; 
		S1:	next_state = !data ? S2 : S0; 
		S2:	next_state = data ? S3 : S0; 
		S3:	next_state = data ? S4 : S0; 
		S4:	next_state = data ? S0 : S0; 
		
		default:next_state =  S0; 
	endcase
end

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		flag <= 1'b0;
	end else begin
		if(state == S4 && data) begin
			flag <= 1'b1;
		end else  begin
			flag <= 1'b0;
		end
	end
end

//*************code***********//
endmodule
