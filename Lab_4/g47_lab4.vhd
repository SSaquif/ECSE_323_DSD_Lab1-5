  --
-- entity name:g47_lab4
--
-- Copyright (C) 2016 Sadnan Saquif
--	Version 1.0
--	Author:	Sadnan Saquif 260499660 
--				Yijie Zhou
-- Date: November 25, 2016
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library lpm;
use lpm.lpm_components.all;
use IEEE.STD_logic_unsigned.all;

entity g47_lab4 is
port (clock			:	in std_logic; --50MHz
		rst			:	in std_logic; --reset		
		level			:	in std_logic_vector(2 downto 0); --3 bits
		life			:	in std_logic_vector(2 downto 0); --3 bits
		R, G, B	:	out std_logic_vector (3 downto 0);
		HSYNC			:	out std_logic; -- horizontal sync signal
		VSYNC			:	out std_logic --vertical sync signal)		
		);
end g47_lab4;


Architecture archlab4 of g47_lab4 is
--Signals
Signal vga_Row, vga_Col : unsigned(9 downto 0); -- to store ROW and COL output from vga
Signal vga_blk_signal : std_logic;
Signal tag_font_col	:	std_logic_vector(2 downto 0);   -- 0 - 7
Signal tag_font_row	:	std_logic_vector(3 downto 0);  -- 0 - 15
Signal reg1_font_col	:	std_logic_vector(2 downto 0);   -- 0 - 7
Signal reg1_font_row	:	std_logic_vector(3 downto 0);  -- 0 - 15	
Signal tag_text_col	:	std_logic_vector(5 downto 0);  -- 0 - 50
Signal tag_text_row	:	std_logic_vector(4 downto 0);  -- 0 - 18
Signal tg_ASCII : std_logic_vector(6 downto 0);
Signal tg_R, tg_G, tg_B : std_logic_vector (3 downto 0);
Signal reg2_R, reg2_G, reg2_B: std_logic_vector (3 downto 0);
Signal CROM_pixel 	:	std_logic;
Signal slow_clock, fast_score_clear, score_clear	: std_logic;
Signal fast_score_count: std_logic_vector(23 downto 0);
Signal score_count:	std_logic_vector(15 downto 0);
Signal R1, G1, B1	:	std_logic_vector (3 downto 0);


--Componenets
-- VGA
Component g47_VGA
	port(	clock			:	in std_logic; --50MHz
			rst			:	in std_logic; --reset
			BLANKING		:	out std_logic; -- blank display when 0
			ROW			:	out unsigned(9 downto 0);	-- line 0 to 599
			COLUMN		: 	out unsigned(9 downto 0);	-- column 0 to 799
			HSYNC			:	out std_logic; -- horizontal sync signal
			VSYNC			:	out std_logic --vertical sync signal)
			);
end component;

-- Text_Address_Generator
Component g47_Text_Address_Generator is
	port(	ROW			:	in unsigned(9 downto 0);	-- line 0 to 599
			COLUMN		: 	in unsigned(9 downto 0);	-- column 0 to 799
			text_row		:	out std_logic_vector(4 downto 0);  -- 0 - 18
			text_col		:	out std_logic_vector(5 downto 0);  -- 0 - 50
			font_row		:	out std_logic_vector(3 downto 0);  -- 0 - 15
			font_col		:	out std_logic_vector(2 downto 0)   -- 0 - 7
			);
end component;

--Text_Generator
Component g47_Text_Generator is
	port(	text_row		: in std_logic_vector(4 downto 0);  -- 0 - 18
			text_col		: in std_logic_vector(5 downto 0);  -- 0 - 50
			score			: in std_logic_vector(15 downto 0); --16 bits
			level			: in std_logic_vector(2 downto 0); --3 bits
			life			: in std_logic_vector(2 downto 0); --3 bits
			ASCII			: out std_logic_vector(6 downto 0); -- 7bit ASCII code
			R, G, B		: out std_logic_vector (3 downto 0)
			);			
end component;

--Text_Pattern_Generator (will not need)
Component g47_VGA_Test_Pattern is
port (clock		: 	in std_logic; 
		rst		:	in std_logic; --reset
		R, G, B	:	out std_logic_vector (3 downto 0);
		HSYNC		:	out std_logic; -- horizontal sync signal
		VSYNC		:	out std_logic --vertical sync signal)
		);
end component;


--fontROM
Component fontROM is
	generic(
		addrWidth: integer := 11;
		dataWidth: integer := 8
	);
	port(
		clkA: in std_logic;
		char_code : in std_logic_vector(6 downto 0); -- 7-bit ASCII character code
		font_row : in std_logic_vector(3 downto 0); -- 0-15 row address in single character
		font_col : in std_logic_vector(2 downto 0); -- 0-7 column address in single character
		font_bit : out std_logic -- pixel value at the given row and column for the selected character code
	);
end component;

--Video Overlay
Component g47_VGA_Overlay is
port (pixel		: 	in std_logic; --selection line
		R_in_TG, G_in_TG, B_in_TG	:	in std_logic_vector (3 downto 0); 
		--R_in_TP, G_in_TP, B_in_TP	:	in std_logic_vector (3 downto 0);
		R, G, B	:	out std_logic_vector (3 downto 0)
		);
end component;

Begin		
	--have first counter count to a very high number, when it recheases that number, it triggers the clock of the second counter
	ScoreCounter1 :	lpm_counter
							generic map (LPM_WIDTH => 24)
							port map (clock => clock, sclr => fast_score_clear, aclr => rst, q => fast_score_count);	
	
	with fast_score_count select
	slow_clock <= 	'1' when "111111111111111111111111",
						'0' when others;
						
--	with fast_score_count select
--	fast_score_clear <= 	'1' when "1111111111111111",
--								'0' when others;
				
	ScoreCounter2 : 	lpm_counter
							generic map (LPM_WIDTH => 16)
							--port map (clock => slow_clock, sclr => score_clear, aclr => rst, q => score_count);
							port map (clock => clock, aclr => rst, cnt_en => slow_clock, q => score_count);
						
	
	
			
	compVGA : g47_VGA port map (clock => clock, rst => rst, ROW =>vga_Row, COLUMN =>vga_Col, HSYNC => HSYNC, VSYNC => VSYNC);
	compTAG : g47_Text_Address_Generator port map (ROW => vga_Row, COLUMN => vga_Col, text_row => tag_text_row, text_col => tag_text_col, font_row => tag_font_row, font_col=> tag_font_col);
	compTG :	g47_Text_Generator port map (text_row => tag_text_row, text_col => tag_text_col, score => score_count, level => level, life => life, ASCII => tg_ASCII, R => tg_R, G => tg_G, B=> tg_B);
	compCROM : fontROM port map (clkA => clock, char_code => tg_ASCII, font_row => reg1_font_row, font_col => reg1_font_col, font_bit => CROM_pixel);
	compVO : g47_VGA_Overlay port map (pixel => CROM_pixel, R_in_TG => reg2_R, G_in_TG => reg2_G, B_in_TG => reg2_B, R => R1, G => G1, B => B1 );
	
	R <= R1;
	B <= B1;
	G <= G1;

-- register process
	process_register1: process(clock, rst)
	begin
		if (rst = '1') then
			reg1_font_col	<= (others => '0');
			reg1_font_row	<= (others => '0');
			reg2_R <= (others => '0');
			reg2_G <= (others => '0');
			reg2_B <= (others => '0');
		elsif (rising_edge(clock)) then
			reg1_font_col	<= tag_font_col;
			reg1_font_row	<= tag_font_row;
			reg2_R <= tg_R;
			reg2_G <= tg_G;
			reg2_B <= tg_B;
		end if;
	end process;
End archlab4;