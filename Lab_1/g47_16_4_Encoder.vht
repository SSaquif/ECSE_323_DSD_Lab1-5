-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "09/30/2016 11:07:02"
                                                            
-- Vhdl Test Bench template for design  :  g47_16_4_Encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all;                              

ENTITY g47_16_4_Encoder_vhd_tst IS
END g47_16_4_Encoder_vhd_tst;
ARCHITECTURE g47_16_4_Encoder_arch OF g47_16_4_Encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL BLOCK_COL : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL CODE : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL ERROR : STD_LOGIC;
COMPONENT g47_16_4_Encoder
	PORT (
	BLOCK_COL : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	CODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	ERROR : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g47_16_4_Encoder
	PORT MAP (
-- list connections between master ports and signals
	BLOCK_COL => BLOCK_COL,
	CODE => CODE,
	ERROR => ERROR
	);
                                        
generate_test : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list
	-- for loop that test the valid input values by having
	-- 1 input bit as high at each iteration 	
		  FOR i IN 0 to 15 LOOP
			BLOCK_COL <= std_logic_vector (to_unsigned(0,16));
			BLOCK_COL (i) <= '1';
		  WAIT FOR 10 ns;
		  END LOOP;
	-- test to check what happens when all input bits are 0	  
		  WAIT FOR 20 ns;
		  BLOCK_COL <= "0000000000000000";
	-- tests to check when there are multiple bits with a high value
		  WAIT FOR 10 ns;
		  BLOCK_COL <= "1111111111111111";
		  WAIT FOR 10 ns;
		  BLOCK_COL <= "1000000000000001";
		  WAIT FOR 10 ns; 
		  	  
		  
WAIT;                                                        
END PROCESS generate_test;                                          
END g47_16_4_Encoder_arch;
