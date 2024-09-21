`timescale 1ns/1ns

module s_to_p(
	input 				clk 		,   
	input 				rst_n		,
	input				valid_a		,
	input	 			data_a		,
 
 	output	reg 		ready_a		,
 	output	reg			valid_b		,
	output  reg [5:0] 	data_b
);

reg 	[5:0] 		data_reg; 
reg		[2:0]       data_cnt;



always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_reg <= 'b0;
	end else begin
		if(valid_a) begin
			data_reg <= {data_a, data_reg[5:1]};
		end
	end
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_cnt <= 'b0; 
	end else begin
		if(valid_a) begin
			data_cnt <= (data_cnt == 3'd5 ) ? 'd0 : data_cnt + 3'd1;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		valid_b <= 'b0;
	end else begin
		if(data_cnt == 3'd5 && valid_a) begin
			valid_b <= 1'b1;
		end else begin
			valid_b <= 1'b0;
		end
	end
end
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		ready_a <= 'b0;
	end else begin
		ready_a <= 1'b1;
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_b <= 'b0;
	end else begin
		if(data_cnt == 3'd5 && valid_a) begin
			data_b <= {data_a, data_reg[5:1]};
		end 
	end
end

endmodule
