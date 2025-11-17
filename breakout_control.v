module breakout_control(clk_50, strt, rst, ,L, R, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);

vga_adapter display(rst, clk_50, color, x, y, 1'b1, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
