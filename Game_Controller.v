module Game_Controller(
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
	//inout 		          		PS2_CLK,.
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

assign clk = CLOCK_50;
assign rst = SW[0];

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
            
            if (x >= 100 && x < 180 && y >= 100 && y < 150)
                vga_color <= 24'h0000FF;       // Blue square
				else if (x >= 400 && x < 560 && y >= 400 && y < 420)
					vga_color <= 24'h0000FF;
				else if (x >= 300 && x < 305 && y >= 300 && y < 305)
					vga_color <= 24'h0000FF;
            else
                vga_color <= 24'hFFA500;       // Orange background

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
reg [9:0] x, y;
wire hit1_1, hit1_2, hit1_3, hit1_4, hit1_5, hit1_6, hit1_7, hit1_8, hit2_1, hit2_2, hit2_3, hit2_4, hit2_5, hit2_6, hit2_7, hit2_8, hit3_1, hit3_2, hit3_3, hit3_4, hit3_5, hit3_6, hit3_7, hit3_8;
always @(*) begin
    hit1_1 = 0; hit1_2 = 0; hit1_3 = 0; hit1_4 = 0;
    hit1_5 = 0; hit1_6 = 0; hit1_7 = 0; hit1_8 = 0;
    hit2_1 = 0; hit2_2 = 0; hit2_3 = 0; hit2_4 = 0;
    hit2_5 = 0; hit2_6 = 0; hit2_7 = 0; hit2_8 = 0;
    hit3_1 = 0; hit3_2 = 0; hit3_3 = 0; hit3_4 = 0;
    hit3_5 = 0; hit3_6 = 0; hit3_7 = 0; hit3_8 = 0;
end
	
paramater
START = 4'd0,
PLAY = 4'd1,

ballx = 10'd300,
bally = 10'd300,

paddlex = 10'd240,
paddley =  10'd440,

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
block_2_8x = 10'd5600, 
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

endmodule

