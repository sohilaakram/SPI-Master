module SPI_Master 
#(parameter Data_Width=8)

(
    output  wire                        MOSI,
    output  wire                        SPI_CLK,
    //output  wire                        CS,
    input   wire                        MISO,
    input   wire    [Data_Width-1:0]    Data,
    input   wire                        clk,rst,
    input   wire                        cpol,cpha,
    input   wire    [2:0]               divide_by_index,
    input   wire                        Data_Valid                       

);

    wire                            sclk,shift_right,Load_Enable;
    wire                            clk_div_out,clk_enable,count_enable;
    wire                            overflow_flag;




Shift_Register Shift_Register (.sclk(sclk),
                               .rst(rst),
                               .Data_IN(MISO),
                               .Data_OUT(MOSI),
                               .Data(Data),
                               .Load_Enable(Load_Enable),
                               .shift_right(shift_right)
                            );


Clock_Logic Clock_Logic (.clk_div_out(clk_div_out),
                         .cpol(cpol),
                         .cpha(cpha),
                         .sclk(sclk)     
                        );


Clock_Divider Clock_Divider (.clk_div_out(clk_div_out),
                             .counter_out_bit_index(divide_by_index),
                             .clk(clk),
                             .rst(rst)
                             );

                             
Mux21 #(.Data_Width(1)) Mux_Clock (.A(cpol),
                 .B(clk_div_out),
                 .sel(clk_enable),
                 .Mux_out(SPI_CLK)   
                );

Counter Counter (.clk(sclk),
                 .rst(rst),
                 .count_enable(count_enable),
                 .overflow(overflow_flag)
                );

Control_Unit ControlUnit (.count_enable(count_enable),
                          .overflow(overflow_flag),
                          .clk(sclk),
                          .rst(rst),
                          .clk_enable(clk_enable),
                          .shift_enable(shift_right),
                          .load_enable(Load_Enable),
                          .data_valid(Data_Valid)
                         ); 
endmodule