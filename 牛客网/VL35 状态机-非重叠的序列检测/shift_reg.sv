`timescale 1ns/1ns

module sequence_test1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//

reg	[3 : 0]	data_lock;


always@(posedge clk or negedge rst) begin
	if(!rst) begin
		data_lock <= 4'b0;
	end else begin
		if(!flag) begin
			data_lock <= {data_lock[2:0], data};
		end
	end
end


always @(posedge clk or negedge rst) begin
	if(!rst) begin
		flag <= 1'b0;
	end else begin
		if((data_lock == 4'b1011) && data) begin
			flag <= 1'b1;
		end else begin
			flag <= 1'b0;
		end
	end
end



//*************code***********//
endmodule
