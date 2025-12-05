module block_collision(clk, rst, start, ballx, bally, x, y, hit, blockTB_col, blockLR_col);
input clk, rst, start;
input [9:0] ballx, bally, x, y;
output reg hit, blockTB_col, blockLR_col;

reg [2:0] S, NS;

parameter
START = 3'd0,
GO = 3'd1,
END = 3'd2;

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
    START:
      if(start == 1'b1)
            NS = GO;
      else
            NS = START;
    GO: 
			NS = GO;
	
endcase    
end
         
always@(posedge clk or negedge rst)
begin
    if(rst == 1'b0)
      begin
        hit <= 1'b0;
        blockTB_col <= 1'b0;
        blockLR_col <= 1'b0;
      end
    else
    begin
        case(S)
            START:
				    begin
                hit <= 1'b0;
                blockTB_col <= 1'b0;
                blockLR_col <= 1'b0;
				   end
				GO: 
					begin
					if (hit == 1'b1)
						begin
							blockTB_col <= 1'b0;
							blockLR_col <= 1'b0;
						end
					else
					if((ballx > x  && ballx < x + 80 && bally <= y) || (ballx > x  && ballx < x + 80 && bally <= y + 50))
						begin
							hit <= 1'b1;
							blockTB_col <= 1'b1;
						end
					else 
					if((bally > y && bally < y + 50 && ballx <= x + 3 && ballx >= x - 3) || (bally > y && bally < y + 50 && ballx <= x + 83 && ballx >= x + 77))
						begin
							hit <= 1'b1;
							blockLR_col <= 1'b1;
						end
					else
					
						begin
							blockTB_col <= 1'b0;
							blockLR_col <= 1'b0;
						end
				   end
				
        endcase
    end
end
endmodule
