module Clock_Logic (

    output  reg     sclk,
    input   wire    cpha,
    input   wire    cpol,
    input   wire    clk_div_out
);

assign mode = {cpol, cpha};

always@(*)
begin
    if (mode == 2'b10 | mode ==2'b01)
        sclk<=~clk_div_out;
    else 
        sclk<=clk_div_out;
end


endmodule