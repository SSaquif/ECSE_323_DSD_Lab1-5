--
-- entity name:g47_VGA_Test_Pattern
--
-- Copyright (C) 2016 Sadnan Saquif
--	Version 1.0
--	Author:	Sadnan Saquif 260499660 
--				Yijie Zhou
-- Date: October 28, 2016
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library lpm;
use lpm.lpm_components.all;
use IEEE.STD_logic_unsigned.all;

entity g47_VGA_Test_Pattern is
port (clock		: 	in std_logic; 
		rst		:	in std_logic; --reset
		R, G, B	:	out std_logic_vector (3 downto 0);
		HSYNC		:	out std_logic; -- horizontal sync signal
		VSYNC		:	out std_logic --vertical sync signal)
		);
end g47_VGA_Test_Pattern;


Architecture archvgatp of g47_VGA_Test_Pattern is

Signal blk_signal : std_logic;
Signal col_signal, row_signal : unsigned(9 downto 0);

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

Begin
--insatantiating components
	comp1: g47_VGA port map (clock => clock, rst => rst, BLANKING => blk_signal, ROW => row_signal, COLUMN => col_signal, HSYNC => HSYNC, VSYNC => VSYNC);
	
	process_red: process(col_signal)
	Begin
		IF ((col_signal >= 0 and col_signal < 200)  or (col_signal >= 400 and col_signal < 600))
						THEN  R<="1111";
			ELSE R<="0000";
		END IF;
	End process;
	
	process_green: process(col_signal)
	Begin
		IF (col_signal >= 0 and col_signal < 400)
			THEN G<="1111";
			ELSE G<="0000";
		END IF;
	End process;
	
	process_blue: process(col_signal)
	Begin
		IF ((col_signal >= 0 and col_signal < 100) or (col_signal >= 200 and col_signal < 300) or (col_signal > 400 and col_signal < 500)
						or (col_signal > 600 and col_signal < 700))
			THEN B<="1111";
			ELSE B<="0000";
		END IF;
	End process;
End archvgatp;

