module display(clk, rst, start, x, y, ballx, bally, paddlex, paddley, block_1_1x, block_1_1y, block_1_2x, block_1_2y, block_1_3x, block_1_3y, block_1_4x, block_1_4y, block_1_5x, block_1_5y, block_1_6x, block_1_6y, block_1_7x, block_1_7y, block_1_8x, block_1_8y,
                                                               block_2_1x, block_2_1y, block_2_2x, block_2_2y, block_2_3x, block_2_3y, block_2_4x, block_2_4y, block_2_5x, block_2_5y, block_2_6x, block_2_6y, block_2_7x, block_2_7y, block_2_8x, block_2_8y,
                                                               block_3_1x, block_3_1y, block_3_2x, block_3_2y, block_3_3x, block_3_3y, block_3_4x, block_3_4y, block_3_5x, block_3_5y, block_3_6x, block_3_6y, block_3_7x, block_3_7y, block_3_8x, block_3_8y, 
                                                               hit1_1, hit1_2, hit1_3, hit1_4, hit1_5, hit1_6, hit1_7, hit1_8, hit2_1, hit2_2, hit2_3, hit2_4, hit2_5, hit2_6, hit2_7, hit2_8, hit3_1, hit3_2, hit3_3, hit3_4, hit3_5, hit3_6, hit3_7, hit3_8,
               color);
input clk, rst, start, hit1_1, hit1_2, hit1_3, hit1_4, hit1_5, hit1_6, hit1_7, hit1_8, hit2_1, hit2_2, hit2_3, hit2_4, hit2_5, hit2_6, hit2_7, hit2_8, hit3_1, hit3_2, hit3_3, hit3_4, hit3_5, hit3_6, hit3_7, hit3_8;
input [9:0] x, y, ballx, bally, paddlex, paddley, block_1_1x, block_1_1y, block_1_2x, block_1_2y, block_1_3x, block_1_3y, block_1_4x, block_1_4y, block_1_5x, block_1_5y, block_1_6x, block_1_6y, block_1_7x, block_1_7y, block_1_8x, block_1_8y,
                                                  block_2_1x, block_2_1y, block_2_2x, block_2_2y, block_2_3x, block_2_3y, block_2_4x, block_2_4y, block_2_5x, block_2_5y, block_2_6x, block_2_6y, block_2_7x, block_2_7y, block_2_8x, block_2_8y,
                                                  block_3_1x, block_3_1y, block_3_2x, block_3_2y, block_3_3x, block_3_3y, block_3_4x, block_3_4y, block_3_5x, block_3_5y, block_3_6x, block_3_6y, block_3_7x, block_3_7y, block_3_8x, block_3_8y;
output reg [23:0] color;

  reg [7:0] NS, S;

parameter START = 8'd0,
          XY = 8'd1,
          RED = 8'd2,
          WHITE = 8'd3,
          BLACK = 8'd4,
			 ERROR = 8'd5;
  
always@(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
		S <= START;
	else 
		S<= NS;
end          

always@(*)
begin
case(S)
	START:
		if(start == 1'b0)
			NS = XY;
		else
			NS = START;
  XY: 
    if(x > paddlex && x < paddlex + 160 && y < paddley + 10 && y > paddley)
			NS = WHITE;
    else if (x > ballx - 3 && x < ballx + 3 && y > bally - 3 && y < bally + 3)
      NS = WHITE;
             
    else if(x > block_1_1x && x < block_1_1x + 80 && y > block_1_1y && y < block_1_1y + 50 && hit1_1 == 1'b0)
			NS = RED;
    else if(x > block_1_2x && x < block_1_2x + 80 && y > block_1_2y && y < block_1_2y + 50 && hit1_2 == 1'b0)
			NS = WHITE;
    else if(x > block_1_3x && x < block_1_3x + 80 && y > block_1_3y && y < block_1_3y + 50 && hit1_3 == 1'b0)
			NS = RED;
    else if(x > block_1_4x && x < block_1_4x + 80 && y > block_1_4y && y < block_1_4y + 50 && hit1_4 == 1'b0)
			NS = WHITE;
    else if(x > block_1_5x && x < block_1_5x + 80 && y > block_1_5y && y < block_1_5y + 50 && hit1_5 == 1'b0)
			NS = RED;
    else if(x > block_1_6x && x < block_1_6x + 80 && y > block_1_6y && y < block_1_6y + 50 && hit1_6 == 1'b0)
			NS = WHITE;
    else if(x > block_1_7x && x < block_1_7x + 80 && y > block_1_7y && y < block_1_7y + 50 && hit1_7 == 1'b0)
			NS = RED;
    else if(x > block_1_8x && x < block_1_8x + 80 && y > block_1_8y && y < block_1_8y + 50 && hit1_8 == 1'b0)
			NS = WHITE;
  
    else if(x > block_2_1x && x < block_2_1x + 80 && y > block_2_1y && y < block_2_1y + 50 && hit2_1 == 1'b0)
			NS = WHITE;
    else if(x > block_2_2x && x < block_2_2x + 80 && y > block_2_2y && y < block_2_2y + 50 && hit2_2 == 1'b0)
			NS = RED;
    else if(x > block_2_3x && x < block_2_3x + 80 && y > block_2_3y && y < block_2_3y + 50 && hit2_3 == 1'b0)
			NS = WHITE;
    else if(x > block_2_4x && x < block_2_4x + 80 && y > block_2_4y && y < block_2_4y + 50 && hit2_4 == 1'b0)
			NS = RED;
    else if(x > block_2_5x && x < block_2_5x + 80 && y > block_2_5y && y < block_2_5y + 50 && hit2_5 == 1'b0)
			NS = WHITE;
    else if(x > block_2_6x && x < block_2_6x + 80 && y > block_2_6y && y < block_2_6y + 50 && hit2_6 == 1'b0)
			NS = RED;
    else if(x > block_2_7x && x < block_2_7x + 80 && y > block_2_7y && y < block_2_7y + 50 && hit2_7 == 1'b0)
			NS = WHITE;
    else if(x > block_2_8x && x < block_2_8x + 80 && y > block_2_8y && y < block_2_8y + 50 && hit2_8 == 1'b0)
			NS = RED;

    else if(x > block_3_1x && x < block_3_1x + 80 && y > block_3_1y && y < block_3_1y + 50 && hit3_1 == 1'b0)
			NS = RED;
    else if(x > block_3_2x && x < block_3_2x + 80 && y > block_3_2y && y < block_3_2y + 50 && hit3_2 == 1'b0)
			NS = WHITE;
    else if(x > block_3_3x && x < block_3_3x + 80 && y > block_3_3y && y < block_3_3y + 50 && hit3_3 == 1'b0)
			NS = RED;
    else if(x > block_3_4x && x < block_3_4x + 80 && y > block_3_4y && y < block_3_4y + 50 && hit3_4 == 1'b0)
			NS = WHITE;
    else if(x > block_3_5x && x < block_3_5x + 80 && y > block_3_5y && y < block_3_5y + 50 && hit3_5 == 1'b0)
			NS = RED;
    else if(x > block_3_6x && x < block_3_6x + 80 && y > block_3_6y && y < block_3_6y + 50 && hit3_6 == 1'b0)
			NS = WHITE;
    else if(x > block_3_7x && x < block_3_7x + 80 && y > block_3_7y && y < block_3_7y + 50 && hit3_7 == 1'b0)
			NS = RED;
    else if(x > block_3_8x && x < block_3_8x + 80 && y > block_3_8y && y < block_3_8y + 50 && hit3_8 == 1'b0)
			NS = WHITE;
             
    else
      NS = BLACK;
  RED:
      NS = XY;
  WHITE:
      NS = XY;
  BLACK: 
      NS =XY;
  default:
		NS = ERROR;
endcase
end

always@(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
	begin
		color <= 24'd0;
	end
	else
	begin
		case (S)
			START:
						color <= 24'd0;
      	  RED:
						color <= 24'hFF0000;
     		WHITE:
						color <= 24'hFFFFFF;
      	BLACK:
						color <= 24'd0;
		endcase
	end
end
endmodule



















  
  
