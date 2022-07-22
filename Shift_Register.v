module Shift_Register 
#(parameter Register_Width=8)

(
    output  wire                            Data_OUT,       //MOSI
    input   wire                            Data_IN,        //MISO
    input   wire    [Register_Width-1:0]    Data,
    input   wire                            sclk,rst,
    input   wire                            Load_Enable,shift_right

);

    reg [Register_Width-1:0]    Internal_Buffer;

    always@(posedge Load_Enable )
    begin
        Internal_Buffer<=Data;
    end

    always@(posedge sclk or negedge rst)
    begin
        if(!rst)
        Internal_Buffer<={ (Register_Width){1'b0} };

        else if (shift_right)
        begin
            Internal_Buffer<=Internal_Buffer<<1;
            Internal_Buffer[0]<=Data_IN;
        end
        
    end

    assign Data_OUT=Internal_Buffer[Register_Width-1];       

    endmodule