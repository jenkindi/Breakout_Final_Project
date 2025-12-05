module ball_move(clk, rst, game_clock, start, blockTB_col_1_1, blockTB_col_1_2, blockTB_col_1_3, blockTB_col_1_4, blockTB_col_1_5, blockTB_col_1_6, blockTB_col_1_7, blockTB_col_1_8, blockTB_col_2_1, blockTB_col_2_2, blockTB_col_2_3, blockTB_col_2_4, blockTB_col_2_5, blockTB_col_2_6, blockTB_col_2_7, blockTB_col_2_8, blockTB_col_3_1, blockTB_col_3_2, blockTB_col_3_3, blockTB_col_3_4, blockTB_col_3_5, blockTB_col_3_6, blockTB_col_3_7, blockTB_col_3_8, blockLR_col_1_1, blockLR_col_1_2, blockLR_col_1_3, blockLR_col_1_4, blockLR_col_1_5, blockLR_col_1_6, blockLR_col_1_7, blockLR_col_1_8, blockLR_col_2_1, blockLR_col_2_2, blockLR_col_2_3, blockLR_col_2_4, blockLR_col_2_5, blockLR_col_2_6, blockLR_col_2_7, blockLR_col_2_8, blockLR_col_3_1, blockLR_col_3_2, blockLR_col_3_3, blockLR_col_3_4, blockLR_col_3_5, blockLR_col_3_6, blockLR_col_3_7, blockLR_col_3_8, wall_col, ceiling_col, paddle_col, ball_angle, ballx, bally, lose);
input clk, rst, game_clock, start;
input blockTB_col_1_1, blockTB_col_1_2, blockTB_col_1_3, blockTB_col_1_4, blockTB_col_1_5, blockTB_col_1_6, blockTB_col_1_7, blockTB_col_1_8, blockTB_col_2_1, blockTB_col_2_2, blockTB_col_2_3, blockTB_col_2_4, blockTB_col_2_5, blockTB_col_2_6, blockTB_col_2_7, blockTB_col_2_8, blockTB_col_3_1, blockTB_col_3_2, blockTB_col_3_3, blockTB_col_3_4, blockTB_col_3_5, blockTB_col_3_6, blockTB_col_3_7, blockTB_col_3_8, blockLR_col_1_1, blockLR_col_1_2, blockLR_col_1_3, blockLR_col_1_4, blockLR_col_1_5, blockLR_col_1_6, blockLR_col_1_7, blockLR_col_1_8, blockLR_col_2_1, blockLR_col_2_2, blockLR_col_2_3, blockLR_col_2_4, blockLR_col_2_5, blockLR_col_2_6, blockLR_col_2_7, blockLR_col_2_8, blockLR_col_3_1, blockLR_col_3_2, blockLR_col_3_3, blockLR_col_3_4, blockLR_col_3_5, blockLR_col_3_6, blockLR_col_3_7, blockLR_col_3_8, wall_col, ceiling_col, paddle_col;
input [3:0] ball_angle;
output reg [9:0] ballx, bally;
output reg lose;

reg [3:0] S, NS;
reg vert_vector;
reg [3:0] horz_vector; 
  
parameter
START = 3'd0,
START_BALL_MOVE = 3'd1,
BALL_MOVE = 3'd2,
SWITCH_X = 3'd3,
SWITCH_Y = 3'd4,
PADDLE = 3'd5,
DONE = 3'd6;

always@(posedge game_clock or negedge rst)
begin
    if(rst == 1'b0)
        S <= START;
    else
        S <= NS;
end

always@(*)
begin
    case(S)
	  START: if(start == 1'd1)
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
          if (blockLR_col_1_1 == 1'b1 || blockLR_col_1_2 == 1'b1 || blockLR_col_1_3 == 1'b1 || blockLR_col_1_4 == 1'b1 || blockLR_col_1_5 == 1'b1 || blockLR_col_1_6 == 1'b1 || blockLR_col_1_7 == 1'b1 || blockLR_col_1_8 == 1'b1 || blockLR_col_2_1 == 1'b1 || blockLR_col_2_2 == 1'b1 || blockLR_col_2_3 == 1'b1 || blockLR_col_2_4 == 1'b1 || blockLR_col_2_5 == 1'b1 || blockLR_col_2_6 == 1'b1 || blockLR_col_2_7 == 1'b1 || blockLR_col_2_8 == 1'b1 || blockLR_col_3_1 == 1'b1 || blockLR_col_3_2 == 1'b1 || blockLR_col_3_3 == 1'b1 || blockLR_col_3_4 == 1'b1 || blockLR_col_3_5 == 1'b1 || blockLR_col_3_6 == 1'b1 || blockLR_col_3_7 == 1'b1 || blockLR_col_3_8 == 1'b1)
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
          if (bally >= 470)
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

always@(posedge game_clock or negedge rst)
begin
	if(rst == 1'b0)
  	begin
  		ballx <= 10'd300;
  		bally <= 10'd300;
  		vert_vector <= 1'b0;
  		horz_vector <= 4'd7;
		lose <= 1'd0;
  	end
	else
	begin
		case(S)
			START: 
  			begin
  				ballx <= 10'd300;
  				bally <= 10'd300;
				lose <= 1'd0;
  			end
			START_BALL_MOVE:
  			begin
  				vert_vector <= 1'd0;
  				horz_vector <= 4'd7;
  			end		
			BALL_MOVE:
        begin
          if(vert_vector == 1'b0 && horz_vector == 4'd0)
    			begin
    				ballx <= ballx - 5;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd1)
    			begin
    				ballx <= ballx - 4;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd2)
    			begin
    				ballx <= ballx - 3;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd3)
    			begin
    				ballx <= ballx - 3;
    				bally <= bally + 2;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd4)
    			begin
    				ballx <= ballx - 2;
    				bally <= bally + 2;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd5)
    			begin
    				ballx <= ballx - 2;
    				bally <= bally + 3;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd6)
    			begin
    				ballx <= ballx - 1;
    				bally <= bally + 3;
			    end
			 else
			 if(vert_vector == 1'b0 && horz_vector == 4'd7)
    			begin
    				ballx <= ballx;
    				bally <= bally + 4;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd8)
    			begin
    				ballx <= ballx + 1;
    				bally <= bally + 3;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd9)
    			begin
    				ballx <= ballx + 2;
    				bally <= bally + 3;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd10)
    			begin
    				ballx <= ballx + 2;
    				bally <= bally + 2;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd11)
    			begin
    				ballx <= ballx + 3;
    				bally <= bally + 2;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd12)
    			begin
    				ballx <= ballx + 3;
    				bally <= bally + 1;
			    end
          else
          if(vert_vector == 1'b0 && horz_vector == 4'd13)
    			begin
    				ballx <= ballx + 4;
    				bally <= bally + 1;
			    end
			else 
			if(vert_vector == 1'b0 && horz_vector == 4'd14)
    			begin
    				ballx <= ballx + 5;
    				bally <= bally + 1;
			    end 

			else	 
         if(vert_vector == 1'b1 && horz_vector == 4'd0)
    			begin
    				ballx <= ballx - 5;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd1)
    			begin
    				ballx <= ballx - 4;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd2)
    			begin
    				ballx <= ballx - 3;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd3)
    			begin
    				ballx <= ballx - 3;
    				bally <= bally - 2;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd4)
    			begin
    				ballx <= ballx - 2;
    				bally <= bally - 2;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd5)
    			begin
    				ballx <= ballx - 2;
    				bally <= bally - 3;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd6)
    			begin
    				ballx <= ballx - 1;
    				bally <= bally - 3;
			    end
			else
			 if(vert_vector == 1'b1 && horz_vector == 4'd7)
    			begin
    				ballx <= ballx;
    				bally <= bally - 4;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd8)
    			begin
    				ballx <= ballx + 1;
    				bally <= bally - 3;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd9)
    			begin
    				ballx <= ballx + 2;
    				bally <= bally - 3;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd10)
    			begin
    				ballx <= ballx + 2;
    				bally <= bally - 2;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd11)
    			begin
    				ballx <= ballx + 3;
    				bally <= bally - 2;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd12)
    			begin
    				ballx <= ballx + 3;
    				bally <= bally - 1;
			    end
          else
          if(vert_vector == 1'b1 && horz_vector == 4'd13)
    			begin
    				ballx <= ballx + 4;
    				bally <= bally - 1;
			    end 
			else
			if(vert_vector == 1'b1 && horz_vector == 4'd14)
    			begin
    				ballx <= ballx + 5;
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
          if(horz_vector == 4'd0)begin
            horz_vector <= 4'd14;
				ballx <= ballx + 10;end
          else
          if(horz_vector == 4'd1)begin
            horz_vector <= 4'd13;
				ballx <= ballx + 10;end
          else
          if(horz_vector == 4'd2)begin
            horz_vector <= 4'd12;
				ballx <= ballx + 10;end
          else
          if(horz_vector == 4'd3)begin
            horz_vector <= 4'd11;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd4)begin
            horz_vector <= 4'd10;
				ballx <= ballx + 10;end
          else
          if(horz_vector == 4'd5)begin
            horz_vector <= 4'd9;
				ballx <= ballx + 10;end
          else
          if(horz_vector == 4'd6)begin
            horz_vector <= 4'd8;
				ballx <= ballx + 10;end
			else
			if(horz_vector == 4'd8)begin
            horz_vector <= 4'd6;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd9)begin
            horz_vector <= 4'd5;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd10)begin
            horz_vector <= 4'd4;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd11)begin
            horz_vector <= 4'd3;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd12)begin
            horz_vector <= 4'd2;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd13)begin
            horz_vector <= 4'd1;
				ballx <= ballx - 10;end
          else
          if(horz_vector == 4'd14)begin
            horz_vector <= 4'd0;
				ballx <= ballx - 10;end
        end
      SWITCH_Y:
        begin
          if(vert_vector == 1'b0)begin
  					vert_vector <= 1'b1;
					bally <= bally - 5;
				end
  				else begin
  					vert_vector <= 1'b0;
					bally <= bally + 5;
						end
        end
      PADDLE:
        begin
          vert_vector <= 1'b1;
			 bally <= bally - 5;
          if (ball_angle == 4'd0)
            horz_vector <= 4'd0;
          else
          if (ball_angle == 4'd1)
            horz_vector <= 4'd1;
          else
          if (ball_angle == 4'd2)
            horz_vector <= 4'd2;
          else
          if (ball_angle == 4'd3)
            horz_vector <= 4'd3;
          else
          if (ball_angle == 4'd4)
            horz_vector <= 4'd4;
          else
          if (ball_angle == 4'd5)
            horz_vector <= 4'd5;
          else
          if (ball_angle == 4'd7)
            horz_vector <= 4'd7;
				else
          if (ball_angle == 4'd8)
            horz_vector <= 4'd8;
			 else
          if (ball_angle == 4'd9)
            horz_vector <= 4'd9;
				else
          if (ball_angle == 4'd10)
            horz_vector <= 4'd10;
				else
          if (ball_angle == 4'd11)
            horz_vector <= 4'd11;
				else
          if (ball_angle == 4'd12)
            horz_vector <= 4'd12;
				else
          if (ball_angle == 4'd13)
            horz_vector <= 4'd13;
				else
          if (ball_angle == 4'd14)
            horz_vector <= 4'd14;
			 
        end
	  DONE:
		  lose <= 1'b1;		
    endcase
  end
end
endmodule

      
