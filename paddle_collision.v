module paddle_collision(clk, rst, start, ballx, bally, paddlex, paddley, paddle_col, ball_angle);
input clk, rst, start;
input [9:0] ballx, bally, paddlex, paddley;
output reg paddle_col;
output reg [2:0] ball_angle;

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
            if(start == 1'b0)
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
    end
    else
    begin
        case(S)
            START:
                begin
                  paddle_col <= 1'd0;
                end
            GO: 
              if(ballx >= paddlex && ballx < paddlex + 20 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd0;
					           end 
              else
              if(ballx >= paddlex + 20 && ballx < paddlex + 40 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd1;
					           end 
              else
              if(ballx >= paddlex + 40 && ballx < paddlex + 70 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd2;
					           end 
              else
              if(ballx >= paddlex + 70 && ballx < paddlex + 90 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd3;
					           end 
              else
              if(ballx >= paddlex + 90 && ballx < paddlex + 120 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd4;
					           end 
              else    
              if(ballx >= paddlex + 120 && ballx < paddlex + 140 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd5;
					           end 
              else
              if(ballx >= paddlex + 140 && ballx < paddlex + 160 && bally == pady)
					           begin
                        paddle_col <= 1'b1;
                        ball_angle <= 3'd6;
					           end 
              else
                 begin
                     paddle_col <= 1'b0;
                     ball_angle <= ball_angle;     
				        end
          endcase
		end
endmodule

