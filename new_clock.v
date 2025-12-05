module new_clock(clk, rst, game_clock);

input clk, rst;
output reg game_clock;

  reg [25:0] counter;

always@(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
  	begin
  		counter <= 26'd0;
  		game_clock <= 1'b0;
  	end
	else
	begin
    if (counter >= 26'd300000) //120 pixels per second
  		begin
  			counter <= 26'd0;
  			game_clock <=1'b1;
  		end
		else
  		begin
  			counter <= counter + 1'b1;
  			game_clock <= 1'b0;
  		end
  end
end
endmodule
