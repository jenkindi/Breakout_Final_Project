module paddle_collision(clk, rst, start, ballx, bally, paddlex, paddley, paddle_col, ball_angle);
input clk, rst, start;
input [9:0] ballx, bally, paddlex, paddley;
output reg paddle_col;
output reg [3:0] ball_angle;
	

reg [1:0] S,NS;

parameter
START = 2'd0,
GO = 2'd1;

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
			if(start == 1'b1)
                NS = GO;
            else
                NS = START;
        GO:
                NS = GO;
    endcase

always@(posedge clk or negedge rst)
begin
    if(rst == 1'b0)
    begin
        paddle_col <= 1'd0;
		ball_angle <= 3'd3;
    end
    else
    begin
        case(S)
            START:
                begin
                  paddle_col <= 1'd0;
				  ball_angle <= 3'd3;
                end
            GO: 
				
			 if(ballx >= paddlex && ballx < paddlex + 10 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd0;
				end 
             else
			 if(ballx >= paddlex + 10 && ballx < paddlex + 20 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd1;
				end 
             else
		     if(ballx >= paddlex + 20 && ballx < paddlex + 30 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd2;
				end 
             else
			 if(ballx >= paddlex + 30 && ballx < paddlex + 40 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd3;
				end 
             else
			 if(ballx >= paddlex + 40 && ballx < paddlex + 50 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                	paddle_col <= 1'b1;
               		ball_angle <= 4'd4;
				end 
             else    
			 if(ballx >= paddlex + 50 && ballx < paddlex + 60 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd5;
				end 
             else
			 if(ballx >= paddlex + 60 && ballx < paddlex + 70 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd6;
				end 
             else
			 if(ballx >= paddlex + 70 && ballx < paddlex + 90 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd7;
				end 
             else
				 if(ballx >= paddlex + 90 && ballx < paddlex + 100 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd8;
				end 
             else
				 if(ballx >= paddlex + 100 && ballx < paddlex + 110 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd9;
				end 
             else
				 if(ballx >= paddlex + 110 && ballx < paddlex + 120 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd10;
				end 
             else
				 if(ballx >= paddlex + 120 && ballx < paddlex + 130 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd11;
				end 
             else
				 if(ballx >= paddlex + 130 && ballx < paddlex + 140 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd12;
				end 
             else
				 if(ballx >= paddlex + 140 && ballx < paddlex + 150 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd13;
				end 
             else
				 if(ballx >= paddlex + 150 && ballx < paddlex + 160 && bally <= paddley + 3 && bally >= paddley - 3)
				begin
                    paddle_col <= 1'b1;
                    ball_angle <= 4'd14;
				end 
             else
                 begin
                     paddle_col <= 1'b0;    
				end
          endcase
		end
	end
endmodule
