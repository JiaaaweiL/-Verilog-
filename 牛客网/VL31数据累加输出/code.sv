`timescale 1ns/1ns

module valid_ready(
	input 				clk 		,   
	input 				rst_n		,
	input		[7:0]	data_in		,
	input				valid_a		,
	input	 			ready_b		,
 
 	output		 		ready_a		,
 	output	reg			valid_b		,
	output  reg [9:0] 	data_out
);

reg		[1:0] 	data_cnt;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_cnt <= 2'b0; 
	end else begin
		if(valid_a && ready_a) begin
			data_cnt <= (data_cnt == 2'd3) ? 2'd0 : data_cnt + 2'd1;
		end
	end
end

always @(posedge clk or negedge rst_n ) begin
	if(!rst_n) begin
		valid_b <= 'b0;
	end else begin
		if(data_cnt == 2'd3 && valid_a && ready_a) begin
			valid_b <= 1'b1;
		end else if (ready_b && valid_b)begin
			valid_b <= 1'b0;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_out <= 10'b0;
	end else begin
		if(valid_a && ready_a && valid_b) begin
			data_out <= data_in;
		end else if(valid_a && ready_a) begin
			data_out <= data_out + data_in;
		end
	end
end

assign ready_a = !valid_b | ready_b;

endmodule
