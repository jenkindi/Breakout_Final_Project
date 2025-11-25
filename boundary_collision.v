module boundary_collision(clk, rst, start, ballx, bally, wall_col, ceiling_col);

input clk, rst, start;
input [9:0] ballx, bally;

output reg wall_col, ceiling_col;

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
        wall_col <= 1'd0;
        ceiling_col <= 1'd0;
    end
    else
    begin
        case(S)
            START:
                begin
                  wall_col <= 1'd0;
                  ceiling_col <= 1'd0;
                end
            GO: 
              if (ballx - 3 <= 0 || ballx + 3 >= 640)
                  wall_col <= 1'd1;
              else
              if (bally - 3 <= 1)
                  ceiling_col <= 1'd1;
              else
                begin
                  wall_col <= 1'd0;
                  ceiling_col <= 1'd0;
                end              
        endcase
		end
endmodule
