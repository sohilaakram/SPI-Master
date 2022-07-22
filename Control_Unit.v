module Control_Unit (
    output  reg    count_enable,clk_enable,
    output  reg    load_enable,shift_enable,
    input   wire    clk,rst,
    input   wire    overflow,
    input   wire    data_valid

);

localparam  	IDLE 		= 3'b10,
                LOAD 		= 3'b01,
                TRANSMIT 	= 3'b11;

    reg [1:0]   current_state= IDLE;
    reg [1:0]   next_state;


always@(posedge clk or negedge rst)
    begin
        if(!rst)
            current_state<=IDLE;
        else begin
            current_state<=next_state;
        end
    end

//Next state 
always@(*)
    begin
        case (current_state)

            IDLE : next_state<= (data_valid)?  LOAD : IDLE;

            LOAD : next_state<= TRANSMIT;

            TRANSMIT :  begin
                            if (overflow)
                                next_state<= (data_valid)? LOAD : IDLE;
                            else
                                next_state<= TRANSMIT;
                        end

            default : next_state<= IDLE;
        endcase
    end


//Current State

always@(*)
    begin
        case (current_state)

        IDLE :  begin
                    clk_enable=1'b0;
                    load_enable=1'b0;
                    shift_enable=1'b0;
                    count_enable=1'b0;
                end


        LOAD : begin
                    clk_enable=1'b1;
                    load_enable=1'b1;
                    shift_enable=1'b0;
                    count_enable=1'b1;
                end
                
        TRANSMIT : begin
                    clk_enable=1'b1;
                    load_enable=1'b0;
                    shift_enable=1'b1;
                    count_enable=1'b1;
                end


            default:    begin
                            clk_enable=1'b0;
                            load_enable=1'b0;
                            shift_enable=1'b0;
                            count_enable=1'b0;
                        end
        endcase
    end

endmodule