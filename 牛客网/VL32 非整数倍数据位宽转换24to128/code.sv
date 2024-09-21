`timescale 1ns/1ns

module width_24to128(
	input 				clk 		,   
	input 				rst_n		,
	input				valid_in	,
	input	[23:0]		data_in		,
 
 	output	reg			valid_out	,
	output  reg [127:0]	data_out
);

reg	[127:0]	data_lock;
reg	[3:0] 	cnt;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt <= 4'b0;
	end else begin
		if(valid_in) begin
			cnt <= cnt + 4'b1;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_lock <= 'd0;
	end else begin
		if(valid_in) begin
			data_lock <= {data_lock[103 : 0], data_in};
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		valid_out <= 1'b0;	
	end else begin
		if(valid_in && (cnt == 4'd5|| cnt == 4'd10|| cnt == 4'd15)) begin
			valid_out <= 1'b1;
		end else begin
			valid_out <= 1'b0;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_out <= 128'b0;
	end else begin
		if(valid_in && cnt == 4'd5) begin
			data_out <= {data_lock[119 : 0], data_in[23:16]};
		end else if (valid_in && cnt == 4'd10)begin
			data_out <= {data_lock[111 : 0], data_in[23:8]};
		end else if (valid_in && cnt == 4'd15) begin
			data_out <= {data_lock[119 : 0], data_in};
		end
	end
end



endmodule
