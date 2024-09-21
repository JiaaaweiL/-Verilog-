`timescale 1ns/1ns

module sequence_test2(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//

parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

reg [2:0] state, next_state;


always @(posedge clk or negedge rst) begin
	if(!rst)
		state <= S0;
	else 
		state <= next_state;
end


always @(*) begin
	case(state)
		S0:	next_state = data ? S1 : S0; 
		S1: next_state = data ? S1 : S2; 
		S2: next_state = data ? S3 : S0; 
		S3: next_state = data ? S4 : S2; 
		S4:	next_state = data ? S1 : S2; 
	default: next_state = S0; 
	endcase
end


always @(posedge clk or negedge rst) begin
	if(!rst)
		flag <= 1'b0;
	else begin
		if(state == S4)
			flag <= 1'b1;
		else
			flag <= 1'b0;
	end

end

//*************code***********//
endmodule
