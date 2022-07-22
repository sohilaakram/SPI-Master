module Clock_Divider 
#(parameter WIDTH=8)
(
    output  wire    clk_div_out,
    input   wire    [$clog2(WIDTH)-1:0]  counter_out_bit_index, 
    input   wire    clk,rst    
);

    reg [WIDTH-1:0]  counter,counter_temp = { (WIDTH){1'b0} };


always @(posedge clk or negedge rst)
begin
    if (!rst)
        counter<= { (WIDTH){1'b0} };
    else 
        counter<=counter_temp+1;
end

always@(*)
begin
    counter_temp<=counter+1;
end


assign clk_div_out=counter[counter_out_bit_index]; //remains zero for a time then returns to one
                                       //exactly as the truth table of Tflipflop


endmodule