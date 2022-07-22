module Shift_Register 
#(parameter Register_Width=8)
(
    output  wire                            Data_OUT,
    input   wire                            Data_IN,    
    input   wire    [Register_Width-1:0]    Data,
    input   wire                            clk,
    input   wire                            Shift_Enable
);

reg [Register_Width-1:0]    Regs;                                                                                      


always@(clk and Shift_Enable)
begin
        Regs<=Data;
end


always@(clk)
begin
    Regs<=Regs<<1;
    Regs[0]<=Data_IN;
end


assign  Data_OUT<=Regs[Register_Width-1];

endmodule