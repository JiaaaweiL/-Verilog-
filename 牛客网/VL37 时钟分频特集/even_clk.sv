`timescale 1ns/1ns

module even_div
    (
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out2,
    output    wire clk_out4,
    output    wire clk_out8
    );
//*************code***********//

reg     clk_2, clk_4, clk_8;



always @(posedge clk_in or negedge rst) begin
    if(!rst)
        clk_2 <= 1'b0;
    else
        clk_2 <= ~clk_2;
end

always @(posedge clk_2 or negedge rst) begin
    if(!rst)
        clk_4 <= 1'b0;
    else
        clk_4 <= ~clk_4;
end

always @(posedge clk_4 or negedge rst) begin
    if(!rst)
        clk_8 <= 1'b0;
    else
        clk_8 <= ~clk_8;
end

assign clk_out2 = clk_2;
assign clk_out4 = clk_4;
assign clk_out8 = clk_8;

//*************code***********//
endmodule
