module vga_driver_memory	(
  	//////////// ADC //////////
	//output		          		ADC_CONVST,
	//output		          		ADC_DIN,
	//input 		          		ADC_DOUT,
	//output		          		ADC_SCLK,

	//////////// Audio //////////
	//input 		          		AUD_ADCDAT,
	//inout 		          		AUD_ADCLRCK,
	//inout 		          		AUD_BCLK,
	//output		          		AUD_DACDAT,
	//inout 		          		AUD_DACLRCK,
	//output		          		AUD_XCK,

	//////////// CLOCK //////////
	//input 		          		CLOCK2_50,
	//input 		          		CLOCK3_50,
	//input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	//output		    [12:0]		DRAM_ADDR,
	//output		     [1:0]		DRAM_BA,
	//output		          		DRAM_CAS_N,
	//output		          		DRAM_CKE,
	//output		          		DRAM_CLK,
	//output		          		DRAM_CS_N,
	//inout 		    [15:0]		DRAM_DQ,
	//output		          		DRAM_LDQM,
	//output		          		DRAM_RAS_N,
	//output		          		DRAM_UDQM,
	//output		          		DRAM_WE_N,

	//////////// I2C for Audio and Video-In //////////
	//output		          		FPGA_I2C_SCLK,
	//inout 		          		FPGA_I2C_SDAT,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	//output		     [6:0]		HEX4,
	//output		     [6:0]		HEX5,

	//////////// IR //////////
	//input 		          		IRDA_RXD,
	//output		          		IRDA_TXD,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// PS2 //////////
	//inout 		          		PS2_CLK,
	//inout 		          		PS2_CLK2,
	//inout 		          		PS2_DAT,
	//inout 		          		PS2_DAT2,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// Video-In //////////
	//input 		          		TD_CLK27,
	//input 		     [7:0]		TD_DATA,
	//input 		          		TD_HS,
	//output		          		TD_RESET_N,
	//input 		          		TD_VS,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output reg	     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output reg	     [7:0]		VGA_G,
	output		          		VGA_HS,
	output reg	     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	//inout 		    [35:0]		GPIO_0,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	//inout 		    [35:0]		GPIO_1

);

  // Turn off all displays.
	assign	HEX0		=	7'h00;
	assign	HEX1		=	7'h00;
	assign	HEX2		=	7'h00;
	assign	HEX3		=	7'h00;

wire active_pixels; // is on when we're in the active draw space

wire [9:0]x; // current x
wire [9:0]y; // current y - 10 bits = 1024 ... a little bit more than we need

wire clk;
wire rst;
wire start;
wire left_move;
wire right_move;

assign clk = CLOCK_50;
assign rst = KEY[2];
assign start = SW[0];
assign left_move = KEY[1];
assign right_move = KEY[0];

assign LEDR[0] = active_pixels;
assign LEDR[1] = flag;

vga_driver the_vga(
.clk(clk),
.rst(rst),

.vga_clk(VGA_CLK),

.hsync(VGA_HS),
.vsync(VGA_VS),

.active_pixels(active_pixels),

.xPixel(x),
.yPixel(y),

.VGA_BLANK_N(VGA_BLANK_N),
.VGA_SYNC_N(VGA_SYNC_N)
);

always @(*)
begin
	{VGA_R, VGA_G, VGA_B} = vga_color;
end

reg flag;
reg [23:0] vga_color;


wire game_clock;	
wire [23:0] color;
wire [9:0]paddlex;
wire [9:0]paddley;
wire paddle_col;
wire [2:0]ball_angle;
wire wall_col;
wire ceiling_col;
wire [9:0]ballx;
wire [9:0]bally;
wire hit1_1, hit1_2, hit1_3, hit1_4, hit1_5, hit1_6, hit1_7, hit1_8, hit2_1, hit2_2, hit2_3, hit2_4, hit2_5, hit2_6, hit2_7, hit2_8, hit3_1, hit3_2, hit3_3, hit3_4, hit3_5, hit3_6, hit3_7, hit3_8;
wire blockTB_col_1_1, blockTB_col_1_2, blockTB_col_1_3, blockTB_col_1_4, blockTB_col_1_5, blockTB_col_1_6, blockTB_col_1_7, blockTB_col_1_8, blockTB_col_2_1, blockTB_col_2_2, blockTB_col_2_3, blockTB_col_2_4, blockTB_col_2_5, blockTB_col_2_6, blockTB_col_2_7, blockTB_col_2_8, blockTB_col_3_1, blockTB_col_3_2, blockTB_col_3_3, blockTB_col_3_4, blockTB_col_3_5, blockTB_col_3_6, blockTB_col_3_7, blockTB_col_3_8;
wire blockLR_col_1_1, blockLR_col_1_2, blockLR_col_1_3, blockLR_col_1_4, blockLR_col_1_5, blockLR_col_1_6, blockLR_col_1_7, blockLR_col_1_8, blockLR_col_2_1, blockLR_col_2_2, blockLR_col_2_3, blockLR_col_2_4, blockLR_col_2_5, blockLR_col_2_6, blockLR_col_2_7, blockLR_col_2_8, blockLR_col_3_1, blockLR_col_3_2, blockLR_col_3_3, blockLR_col_3_4, blockLR_col_3_5, blockLR_col_3_6, blockLR_col_3_7, blockLR_col_3_8;	
wire lose;
reg win;
reg loss;
	
// Instantiate game clock
new_clock my_new_clock(clk, rst, game_clock);
	
// Instantiate display module
display my_display(clk, rst, start, x, y, ballx, bally, paddlex, paddley, block_1_1x, block_1_1y, block_1_2x, block_1_2y, block_1_3x, block_1_3y, block_1_4x, block_1_4y, block_1_5x, block_1_5y, block_1_6x, block_1_6y, block_1_7x, block_1_7y, block_1_8x, block_1_8y,
                                                               block_2_1x, block_2_1y, block_2_2x, block_2_2y, block_2_3x, block_2_3y, block_2_4x, block_2_4y, block_2_5x, block_2_5y, block_2_6x, block_2_6y, block_2_7x, block_2_7y, block_2_8x, block_2_8y,
                                                               block_3_1x, block_3_1y, block_3_2x, block_3_2y, block_3_3x, block_3_3y, block_3_4x, block_3_4y, block_3_5x, block_3_5y, block_3_6x, block_3_6y, block_3_7x, block_3_7y, block_3_8x, block_3_8y, 
                                                               hit1_1, hit1_2, hit1_3, hit1_4, hit1_5, hit1_6, hit1_7, hit1_8, hit2_1, hit2_2, hit2_3, hit2_4, hit2_5, hit2_6, hit2_7, hit2_8, hit3_1, hit3_2, hit3_3, hit3_4, hit3_5, hit3_6, hit3_7, hit3_8, win, loss,
               color);

// Instantiate paddle movements
paddle_move my_paddle_move(clk, rst, game_clock, start, left_move, right_move, paddlex, paddley);

// Instantiate paddle collision
paddle_collision my_paddle_collision(clk, rst, start, ballx, bally, paddlex, paddley, paddle_col, ball_angle);

// Instantiate boundary collision
boundary_collision my_boundary_collision(clk, rst, start, ballx, bally, wall_col, ceiling_col);

// Instantiate ball movements
ball_move my_ball_move(clk, rst, game_clock, start, blockTB_col_1_1, blockTB_col_1_2, blockTB_col_1_3, blockTB_col_1_4, blockTB_col_1_5, blockTB_col_1_6, blockTB_col_1_7, blockTB_col_1_8, blockTB_col_2_1, blockTB_col_2_2, blockTB_col_2_3, blockTB_col_2_4, blockTB_col_2_5, blockTB_col_2_6, blockTB_col_2_7, blockTB_col_2_8, blockTB_col_3_1, blockTB_col_3_2, blockTB_col_3_3, blockTB_col_3_4, blockTB_col_3_5, blockTB_col_3_6, blockTB_col_3_7, blockTB_col_3_8, blockLR_col_1_1, blockLR_col_1_2, blockLR_col_1_3, blockLR_col_1_4, blockLR_col_1_5, blockLR_col_1_6, blockLR_col_1_7, blockLR_col_1_8, blockLR_col_2_1, blockLR_col_2_2, blockLR_col_2_3, blockLR_col_2_4, blockLR_col_2_5, blockLR_col_2_6, blockLR_col_2_7, blockLR_col_2_8, blockLR_col_3_1, blockLR_col_3_2, blockLR_col_3_3, blockLR_col_3_4, blockLR_col_3_5, blockLR_col_3_6, blockLR_col_3_7, blockLR_col_3_8, wall_col, ceiling_col, paddle_col, ball_angle, ballx, bally, lose);

// Instantiate block boundary collisions
localparam
	block_1_1x = 10'd0, 
	block_1_1y = 10'd20, 
	block_1_2x = 10'd80, 
	block_1_2y = 10'd20, 
	block_1_3x = 10'd160, 
	block_1_3y = 10'd20, 
	block_1_4x = 10'd240, 
	block_1_4y = 10'd20, 
	block_1_5x = 10'd320,
	block_1_5y = 10'd20, 
	block_1_6x = 10'd400, 
	block_1_6y = 10'd20, 
	block_1_7x = 10'd480, 
	block_1_7y = 10'd20, 
	block_1_8x = 10'd560,
	block_1_8y = 10'd20,
	block_2_1x = 10'd0, 
	block_2_1y = 10'd70, 
	block_2_2x = 10'd80, 
	block_2_2y = 10'd70, 
	block_2_3x = 10'd160, 
	block_2_3y = 10'd70, 
	block_2_4x = 10'd240, 
	block_2_4y = 10'd70, 
	block_2_5x = 10'd320, 
	block_2_5y = 10'd70, 
	block_2_6x = 10'd400, 
	block_2_6y = 10'd70, 
	block_2_7x = 10'd480, 
	block_2_7y = 10'd70, 
	block_2_8x = 10'd560, 
	block_2_8y = 10'd70,
	block_3_1x = 10'd0, 
	block_3_1y = 10'd120, 
	block_3_2x = 10'd80, 
	block_3_2y = 10'd120, 
	block_3_3x = 10'd160, 
	block_3_3y = 10'd120, 
	block_3_4x = 10'd240, 
	block_3_4y = 10'd120, 
	block_3_5x = 10'd320, 
	block_3_5y = 10'd120, 
	block_3_6x = 10'd400, 
	block_3_6y = 10'd120, 
	block_3_7x = 10'd480,
	block_3_7y = 10'd120, 
	block_3_8x = 10'd560, 
	block_3_8y = 10'd120;
	
block_collision block_1_1(clk, rst, start, ballx, bally, block_1_1x, block_1_1y, hit1_1, blockTB_col_1_1, blockLR_col_1_1);
block_collision block_1_2(clk, rst, start, ballx, bally, block_1_2x, block_1_2y, hit1_2, blockTB_col_1_2, blockLR_col_1_2);
block_collision block_1_3(clk, rst, start, ballx, bally, block_1_3x, block_1_3y, hit1_3, blockTB_col_1_3, blockLR_col_1_3);
block_collision block_1_4(clk, rst, start, ballx, bally, block_1_4x, block_1_4y, hit1_4, blockTB_col_1_4, blockLR_col_1_4);
block_collision block_1_5(clk, rst, start, ballx, bally, block_1_5x, block_1_5y, hit1_5, blockTB_col_1_5, blockLR_col_1_5);
block_collision block_1_6(clk, rst, start, ballx, bally, block_1_6x, block_1_6y, hit1_6, blockTB_col_1_6, blockLR_col_1_6);
block_collision block_1_7(clk, rst, start, ballx, bally, block_1_7x, block_1_7y, hit1_7, blockTB_col_1_7, blockLR_col_1_7);
block_collision block_1_8(clk, rst, start, ballx, bally, block_1_8x, block_1_8y, hit1_8, blockTB_col_1_8, blockLR_col_1_8);
block_collision block_2_1(clk, rst, start, ballx, bally, block_2_1x, block_2_1y, hit2_1, blockTB_col_2_1, blockLR_col_2_1);
block_collision block_2_2(clk, rst, start, ballx, bally, block_2_2x, block_2_2y, hit2_2, blockTB_col_2_2, blockLR_col_2_2);
block_collision block_2_3(clk, rst, start, ballx, bally, block_2_3x, block_2_3y, hit2_3, blockTB_col_2_3, blockLR_col_2_3);
block_collision block_2_4(clk, rst, start, ballx, bally, block_2_4x, block_2_4y, hit2_4, blockTB_col_2_4, blockLR_col_2_4);
block_collision block_2_5(clk, rst, start, ballx, bally, block_2_5x, block_2_5y, hit2_5, blockTB_col_2_5, blockLR_col_2_5);
block_collision block_2_6(clk, rst, start, ballx, bally, block_2_6x, block_2_6y, hit2_6, blockTB_col_2_6, blockLR_col_2_6);
block_collision block_2_7(clk, rst, start, ballx, bally, block_2_7x, block_2_7y, hit2_7, blockTB_col_2_7, blockLR_col_2_7);
block_collision block_2_8(clk, rst, start, ballx, bally, block_2_8x, block_2_8y, hit2_8, blockTB_col_2_8, blockLR_col_2_8);
block_collision block_3_1(clk, rst, start, ballx, bally, block_3_1x, block_3_1y, hit3_1, blockTB_col_3_1, blockLR_col_3_1);
block_collision block_3_2(clk, rst, start, ballx, bally, block_3_2x, block_3_2y, hit3_2, blockTB_col_3_2, blockLR_col_3_2);
block_collision block_3_3(clk, rst, start, ballx, bally, block_3_3x, block_3_3y, hit3_3, blockTB_col_3_3, blockLR_col_3_3);
block_collision block_3_4(clk, rst, start, ballx, bally, block_3_4x, block_3_4y, hit3_4, blockTB_col_3_4, blockLR_col_3_4);
block_collision block_3_5(clk, rst, start, ballx, bally, block_3_5x, block_3_5y, hit3_5, blockTB_col_3_5, blockLR_col_3_5);
block_collision block_3_6(clk, rst, start, ballx, bally, block_3_6x, block_3_6y, hit3_6, blockTB_col_3_6, blockLR_col_3_6);
block_collision block_3_7(clk, rst, start, ballx, bally, block_3_7x, block_3_7y, hit3_7, blockTB_col_3_7, blockLR_col_3_7);
block_collision block_3_8(clk, rst, start, ballx, bally, block_3_8x, block_3_8y, hit3_8, blockTB_col_3_8, blockLR_col_3_8);

	
always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		vga_color <= 24'hFFFFFF;
		flag <= 1'b0;
	end
	else begin
    if (active_pixels) begin
        // We are in the visible region

        if (KEY[3] == 1'b0) begin
            // Button pressed -> draw blue square
            
            vga_color <= color;      // Orange background

        end else begin
            // Button not pressed
            vga_color <= 24'hFFFFFF;           // White background
        end
    end else begin
        // In blanking interval
        vga_color <= 24'h000000;               // Black or don't care
    end
end
end

reg [3:0] S, NS; 
	
parameter
START = 4'd0,
PLAY = 4'd1,
WIN = 4'd2,
LOSS = 4'd3;

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
			NS = PLAY;
		else 
			NS = START;
	PLAY:
		if(hit1_1 == 1'b1 && hit1_2 == 1'b1 && hit1_3 == 1'b1 && hit1_4 == 1'b1 && hit1_5 == 1'b1 && hit1_6 == 1'b1 && hit1_7 == 1'b1 && hit1_8 == 1'b1 && hit2_1 == 1'b1 && hit2_2 == 1'b1 && hit2_3 == 1'b1 && hit2_4 == 1'b1 && hit2_5 == 1'b1 && hit2_6 == 1'b1 && hit2_7 == 1'b1 && hit2_8 == 1'b1 &&hit3_1 == 1'b1 && hit3_2 == 1'b1 && hit3_3 == 1'b1 && hit3_4 == 1'b1 && hit3_5 == 1'b1 && hit3_6 == 1'b1 && hit3_7 == 1'b1 && hit3_8 == 1'b1)
			NS = WIN;
		else 
		if(lose == 1'b1)
			NS = LOSS;
		else
			NS = PLAY;
	WIN:
		NS = WIN;
	LOSS: 
		NS = LOSS;
endcase
end


always@(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
	begin 
		win <= 1'b0;
		loss <= 1'b0;
	end
	else 
	begin
		case (S)
			START:
			begin
				win <= 1'b0;
				loss <= 1'b0;
			end
			WIN:
				win <= 1'b1;
			LOSS:
				loss <= 1'b1;
			
		endcase
	end
end
endmodule	
