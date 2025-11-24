module ball_move(clk, rst, start, blockTB_col_1_1, blockTB_col_1_2, blockTB_col_1_3, blockTB_col_1_4, blockTB_col_1_5, blockTB_col_1_6, blockTB_col_1_7, blockTB_col_1_8, blockTB_col_2_1, blockTB_col_2_2, blockTB_col_2_3, blockTB_col_2_4, blockTB_col_2_5, blockTB_col_2_6, blockTB_col_2_7, blockTB_col_2_8, blockTB_col_3_1, blockTB_col_3_2, blockTB_col_3_3, blockTB_col_3_4, blockTB_col_3_5, blockTB_col_3_6, blockTB_col_3_7, blockTB_col_3_8, blockhorz_col_1_1, blockhorz_col_1_2, blockhorz_col_1_3, blockhorz_col_1_4, blockhorz_col_1_5, blockhorz_col_1_6, blockhorz_col_1_7, blockhorz_col_1_8, blockhorz_col_2_1, blockhorz_col_2_2, blockhorz_col_2_3, blockhorz_col_2_4, blockhorz_col_2_5, blockhorz_col_2_6, blockhorz_col_2_7, blockhorz_col_2_8, blockhorz_col_3_1, blockhorz_col_3_2, blockhorz_col_3_3, blockhorz_col_3_4, blockhorz_col_3_5, blockhorz_col_3_6, blockhorz_col_3_7, blockhorz_col_3_8, wall_col, ceiling_col, paddle_col, ball_angle, ballx, bally);
input clk, rst, start;
input blockTB_col_1_1, blockTB_col_1_2, blockTB_col_1_3, blockTB_col_1_4, blockTB_col_1_5, blockTB_col_1_6, blockTB_col_1_7, blockTB_col_1_8, blockTB_col_2_1, blockTB_col_2_2, blockTB_col_2_3, blockTB_col_2_4, blockTB_col_2_5, blockTB_col_2_6, blockTB_col_2_7, blockTB_col_2_8, blockTB_col_3_1, blockTB_col_3_2, blockTB_col_3_3, blockTB_col_3_4, blockTB_col_3_5, blockTB_col_3_6, blockTB_col_3_7, blockTB_col_3_8, blockhorz_col_1_1, blockhorz_col_1_2, blockhorz_col_1_3, blockhorz_col_1_4, blockhorz_col_1_5, blockhorz_col_1_6, blockhorz_col_1_7, blockhorz_col_1_8, blockhorz_col_2_1, blockhorz_col_2_2, blockhorz_col_2_3, blockhorz_col_2_4, blockhorz_col_2_5, blockhorz_col_2_6, blockhorz_col_2_7, blockhorz_col_2_8, blockhorz_col_3_1, blockhorz_col_3_2, blockhorz_col_3_3, blockhorz_col_3_4, blockhorz_col_3_5, blockhorz_col_3_6, blockhorz_col_3_7, blockhorz_col_3_8, wall_col, ceiling_col, paddle_col;
input [2:0] ball_angle;
output reg [9:0] ballx, bally;

reg [3:0] S, NS;
reg vert_vector;
reg [2:0] horz_vector; 
  
parameter
START = 3'd0,
START_BALL_MOVE = 3'd1,
BALL_MOVE = 3'd2;
SWITCH_X = 3'd3,
SWITCH_Y = 3'd4,
PADDLE = 3'd5,
DONE = 3'd6;

always@(posedge clk or negedge rst)
begin
    if(rst == 1'b0)
        S <= START;
    else
        S <= NS;
end

always@(*)
begin
    case(S)
      START: if(start == 1'd0)
                NS = START_BALL_MOVE;
             else
                NS = START;
      START_BALL_MOVE:
                NS = BALL_MOVE;
      BALL_MOVE: 
        begin
          if (blockTB_col_1_1 == 1'b1 || blockTB_col_1_2 == 1'b1 || blockTB_col_1_3 == 1'b1 || blockTB_col_1_4 == 1'b1 || blockTB_col_1_5 == 1'b1 || blockTB_col_1_6 == 1'b1 || blockTB_col_1_7 == 1'b1 || blockTB_col_1_8 == 1'b1 || blockTB_col_2_1 == 1'b1 || blockTB_col_2_2 == 1'b1 || blockTB_col_2_3 == 1'b1 || blockTB_col_2_4 == 1'b1 || blockTB_col_2_5 == 1'b1 || blockTB_col_2_6 == 1'b1 || blockTB_col_2_7 == 1'b1 || blockTB_col_2_8 == 1'b1 || blockTB_col_3_1 == 1'b1 || blockTB_col_3_2 == 1'b1 || blockTB_col_3_3 == 1'b1 || blockTB_col_3_4 == 1'b1 || blockTB_col_3_5 == 1'b1 || blockTB_col_3_6 == 1'b1 || blockTB_col_3_7 == 1'b1 || blockTB_col_3_8 == 1'b1)
                NS = SWITCH_Y;
          else
          if (blockhorz_col_1_1 == 1'b1 || blockhorz_col_1_2 == 1'b1 || blockhorz_col_1_3 == 1'b1 || blockhorz_col_1_4 == 1'b1 || blockhorz_col_1_5 == 1'b1 || blockhorz_col_1_6 == 1'b1 || blockhorz_col_1_7 == 1'b1 || blockhorz_col_1_8 == 1'b1 || blockhorz_col_2_1 == 1'b1 || blockhorz_col_2_2 == 1'b1 || blockhorz_col_2_3 == 1'b1 || blockhorz_col_2_4 == 1'b1 || blockhorz_col_2_5 == 1'b1 || blockhorz_col_2_6 == 1'b1 || blockhorz_col_2_7 == 1'b1 || blockhorz_col_2_8 == 1'b1 || blockhorz_col_3_1 == 1'b1 || blockhorz_col_3_2 == 1'b1 || blockhorz_col_3_3 == 1'b1 || blockhorz_col_3_4 == 1'b1 || blockhorz_col_3_5 == 1'b1 || blockhorz_col_3_6 == 1'b1 || blockhorz_col_3_7 == 1'b1 || blockhorz_col_3_8 == 1'b1)
                NS = SWITCH_X;
          else
          if (wall_col == 1'b1)
                NS = SWITCH_X;
          else
          if (ceiling_col == 1'b1)
                NS = SWITCH_Y;
          else
          if (paddle_col == 1'b1)
                NS = PADDLE;
          else
          if (bally == 477)
                NS = DONE;
          else
                NS = BALL_MOVE;
        end
      SWITCH_X:
                NS = BALL_MOVE;
      SWITCH_Y:
                NS = BALL_MOVE;
      PADDLE:
                NS = BALL_MOVE;
      DONE: 
                NS = DONE;
    endcase
end

always@(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
  	begin
  		ballx <= 10'd300;
  		bally <= 10'd300;
  		vert_vector <= 1'b0;
  		horz_vector <= 3'd3;
  	end
	else
	begin
		case(S)
			START: 
  			begin
  				ballx <= 10'd300;
  				bally <= 10'd300;
  			end
			START_BALL_MOVE:
  			begin
  				vert_vector <= 1'd0;
  				horz_vector <= 3'd1;
  			end		
			BALL_MOVE:
        begin
          if(vert_vector == 1'b0 && horz_vector == 3'd0)
    			begin
    				ballx <= ballx - 3;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 3'd1)
    			begin
    				ballx <= ballx - 2;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 3'd2)
    			begin
    				ballx <= ballx - 1;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 3'd3)
    			begin
    				ballx <= ballx;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 3'd4)
    			begin
    				ballx <= ballx + 1;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 3'd5)
    			begin
    				ballx <= ballx + 2;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 3'd6)
    			begin
    				ballx <= ballx + 3;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd0)
    			begin
    				ballx <= ballx - 3;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd1)
    			begin
    				ballx <= ballx - 2;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd2)
    			begin
    				ballx <= ballx - 1;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd3)
    			begin
    				ballx <= ballx;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd4)
    			begin
    				ballx <= ballx + 1;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd5)
    			begin
    				ballx <= ballx + 2;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 3'd6)
    			begin
    				ballx <= ballx + 3;
    				bally <= bally - 1;
			    end
          else
          begin
            ballx <= ballx;
    				bally <= bally;
          end
        end
      SWITCH_X:
        begin
          if(horz_vector == 3'd0)
            horz_vector <= 3'd6;
          else
          if(horz_vector == 3'd1)
            horz_vector <= 3'd5;
          else
          if(horz_vector == 3'd2)
            horz_vector <= 3'd4;
          else
          if(horz_vector == 3'd3)
            horz_vector <= 3'd3;
          else
          if(horz_vector == 3'd4)
            horz_vector <= 3'd2;
          else
          if(horz_vector == 3'd5)
            horz_vector <= 3'd1;
          else
          if(horz_vector == 3'd6)
            horz_vector <= 3'd0;
        end
      SWITCH_Y:
        begin
          if(vert_vector == 1'b0)
  					vert_vector <= 1'b1;
  				else
  					vert_vector <= 1'b0;
        end
      PADDLE:
        begin
          vert_vector <= 1'b1;
          if (ball_angle == 3'd0)
            horz_vector <= 3'd0;
          else
          if (ball_angle == 3'd1)
            horz_vector <= 3'd1;
          else
          if (ball_angle == 3'd2)
            horz_vector <= 3'd2;
          else
          if (ball_angle == 3'd3)
            horz_vector <= 3'd3;
          else
          if (ball_angle == 3'd4)
            horz_vector <= 3'd4;
          else
          if (ball_angle == 3'd5)
            horz_vector <= 3'd5;
          else
          if (ball_angle == 3'd6)
            horz_vector <= 3'd6;
        end
    endcase
  end
endmodule

      
