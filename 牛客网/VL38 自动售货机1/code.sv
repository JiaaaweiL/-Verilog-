`timescale 1ns/1ns
module seller1(
	input wire clk  ,
	input wire rst  ,
	input wire d1 ,
	input wire d2 ,
	input wire d3 ,
	
	output reg out1,
	output reg [1:0]out2
);
//*************code***********//

parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6;

reg 	[2:0]	state, next_state;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		state <= S0;
	end else begin
		state <= next_state;
	end
end


always @(*) begin
	case(state)
		S0: begin //0
			if(d1)
				next_state = S1;
			else if (d2)
				next_state = S2;
			else if (d3)
				next_state = S4;
			else
				next_state = next_state;////?????
		end 

		S1: begin //0.5
			if(d1)
				next_state = S2;
			else if (d2)
				next_state = S3;
			else if (d3)
				next_state = S5;
			else
				next_state = next_state;////?????
		end
	
		S2: begin //1
			if(d1)
				next_state = S3;
			else if (d2)
				next_state = S4;
			else if (d3)
				next_state = S6;
			else
				next_state = next_state;////?????
		end
		
		S3: begin //1.5
				next_state = S0;
		end

		S4: begin //2
			next_state = S0;
		end

		S5: begin //2.5
			next_state = S0;
		end
		S6: begin //3
			next_state = S0;
		end
	default: next_state = S0;
	endcase
end

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		out1 <= 'b0;
		out2 <= 'b0;
	end else begin
		if(next_state == S3) begin
			out1 <= 1'b1;
			out2 <= 2'b0;
		end else if (next_state == S4) begin
			out1 <= 1'b1;
			out2 <= 2'd1;
		end else if (next_state == S5) begin
			out1 <= 1'b1;
			out2 <= 2'd2;
		end else if (next_state == S6) begin
			out1 <= 1'b1;
			out2 <= 2'd3;
		end else begin
			out1 <= 1'b0;
			out2 <= 2'b0;
		end
	end
end

//*************code***********//
endmodule
