module block_collision(clk, rst, start, ballx, bally, x, y, hit, blockTB_col, blockLR_col);
input clk, rst, start;
input [9:0] ballx, bally, x, y;
output reg hit, blockTB_col, blockLR_col;

reg [1:0] S, NS;

parameter
START = 2'd0,
GO = 2'd1,
HIT = 2'd2;

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
      if((ballx > x  && ballx < x + 80 && bally == y) || (ballx > x  && ballx < x + 80 && bally == y + 50))
            NS = HIT;
      else 
      if((bally > y && bally < y + 50 && ballx == x) || (bally > y && bally < y + 50 && ballx == x + 80))
            NS = HIT;
      else
            NS = GO;
    HIT:
      NS = HIT;
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
              if((ballx > x  && ballx < x + 80 && bally == y) || (ballx > x  && ballx < x + 80 && bally == y + 50))
                begin
                  hit <= 1'b1;
                  blockTB_col <= 1'b1;
                  blockLR_col <= 1'b0;
                end
              else 
              if((bally > y && bally < y + 50 && ballx == x) || (bally > y && bally < y + 50 && ballx == x + 80))
                  begin
                  hit <= 1'b1;
                  blockTB_col <= 1'b0;
                  blockLR_col <= 1'b1;
                end
              else
                  begin
                  hit <= 1'b0;
                  blockTB_col <= 1'b0;
                  blockLR_col <= 1'b0;
                end
            end
            HIT:
				      begin
                hit <= 1'b1;
                blockTB_col <= 1'b0;
                blockLR_col <= 1'b0;
				      end
        endcase
    end
end
endmodule
