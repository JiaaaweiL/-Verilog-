`timescale 1ns/1ns

module width_8to12(
	input 				   clk 		,   
	input 			      rst_n		,
	input				      valid_in	,
	input	[7:0]			   data_in	,
 
 	output  reg			   valid_out,
	output  reg [11:0]   data_out
);
reg		[7:0] 	data_lock;
reg		[1:0]	cnt;


always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt <= 2'b0;
	end else begin
		if(valid_in) begin
			cnt <= (cnt == 2'd2) ? 2'b0 : cnt + 2'd1;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_lock <= 8'd0;
	end else begin
		if(valid_in) begin
			data_lock <= data_in;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		valid_out <= 1'b0;
	end else begin
		if(valid_in && cnt == 2'd1) begin
			valid_out <= 1'b1;
		end else if (valid_in && cnt == 2'd2) begin
			valid_out <= 1'b1;
		end else begin
			valid_out <= 1'b0;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_out <= 12'b0;
	end else begin
		if(valid_in && cnt == 2'd1) begin
			data_out <= {data_lock, data_in[7:4]};
		end else if (valid_in && cnt == 2'd2) begin
			data_out <= {data_lock[3:0], data_in};
		end 
	end
end

endmodule
