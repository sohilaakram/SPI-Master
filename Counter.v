module Counter
#(parameter Counter_Width =3) 
(
    output  reg    overflow,
    input   wire    clk,rst,
    input   wire    count_enable
);
    reg [Counter_Width-1:0]  counter=0;
    reg [Counter_Width-1:0]  counter_reg=0;
always@(posedge clk or negedge rst)
begin
    if (!rst)
        begin
            counter<= { (Counter_Width) {1'b0} };
            overflow<=0;
        end
        

    else 
    begin
        if (count_enable)
            counter<=counter_reg;
                if (overflow)
                    counter<= { (Counter_Width) {1'b0} };
    end

end

always@(*)

begin
    {overflow , counter_reg }<=counter+1;
end

endmodule