module paddlemove(clk, rst, start, left_move, right_move, paddlex, paddley);
input clk, rst, start, left_move, right_move;
output reg [9:0] paddlex, paddley;

reg [2:0] S,NS;

parameter
paddlex_start = 10'd240,
paddley_start = 10'd440,
START = 3'd0,
STAY = 3'd1,
MOVE_L = 3'd2,
MOVE_R = 3'd3;

always@(posedge clk or negedge rst)
begin
    if(rst == 1'b0)
        S <= START;
    else
        S <= NS;
end

always@(*)
    case(S)
        START:
            if(start == 1'b0)
                NS = STAY;
            else
                NS = START;
        STAY:
            if(left_move == 1'b0 && right_move == 1'b0)
                NS = STAY;
            else
            if(left_move == 1'b0 && paddlex > 0)
                NS = MOVE_L;
            else
            if(right_move == 1'b0 && paddlex + 160 < 640)
                NS = MOVE_R;
            else
                NS = STAY;
        MOVE_L:
            if(left_move == 1'b0 && right_move == 1'b0)
                NS = STAY;
            else
            if(left_move == 1'b0 && paddlex > 0)
                NS = MOVE_L;
            else
            if(right_move == 1'b0 && paddlex + 160 < 640)
                NS = MOVE_R;
            else
                NS = STAY;
        
        MOVE_R:
            if(left_move == 1'b0 && right_move == 1'b0)
                NS = STAY;
            else
            if(left_move == 1'b0 && paddlex > 0)
                NS = MOVE_L;
            else
            if(right_move == 1'b0 && paddlex + 160 < 640)
                NS = MOVE_R;
            else
                NS = STAY;
    endcase

always@(posedge clk or negedge rst)
begin
    if(rst == 1'b0)
    begin
        paddlex <= paddlex_start;
        paddley <= paddley_start;
    end
    else
    begin
        case(S)
          START:  
            begin
                paddlex <= paddlex_start;
                paddley <= paddley_start;
            end
          STAY:
                paddlex <= paddlex;
          MOVE_L:
                paddlex <= paddlex - 1;
          MOVE_R:
                paddlex <= paddlex + 1;
        endcase
    end
endmodule








          
