`timescale 1ns/1ns

module width_8to16(
	input 				   clk 		,   
	input 				   rst_n		,
	input				      valid_in	,
	input	   [7:0]		   data_in	,
 
 	output	reg			valid_out,
	output   reg [15:0]	data_out
);

reg				cnt;
reg		[7:0] 	data_lock;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt <= 1'b0;
	end else begin
		if(valid_in) begin
			cnt <= cnt + 1'b1;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_lock <= 'b0;
	end else begin
		if(valid_in && !cnt) begin
			data_lock <= data_in;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		valid_out <= 1'b0;
	end else begin
		if(valid_in && cnt) begin
			valid_out <= 1'b1;
		end else begin
			valid_out <= 1'b0;
		end
	end
end
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_out <= 1'b0;
	end else begin
		if(valid_in && cnt) begin
			data_out <= {data_lock, data_in};
		end
	end
end

endmodule
