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
-- Generated on "10/15/2016 23:44:45"
                                                            
-- Vhdl Test Bench template for design  :  g47_64_6_encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library lpm;
use lpm.lpm_components.all;
use IEEE.STD_logic_unsigned.all;                                

ENTITY g47_64_6_encoder_vhd_tst IS
END g47_64_6_encoder_vhd_tst;
ARCHITECTURE g47_64_6_encoder_arch OF g47_64_6_encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL codeA : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL errorA : STD_LOGIC;
SIGNAL input : STD_LOGIC_VECTOR(63 DOWNTO 0);
COMPONENT g47_64_6_encoder
	PORT (
	codeA : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	errorA : OUT STD_LOGIC;
	input : IN STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g47_64_6_encoder
	PORT MAP (
-- list connections between master ports and signals
	codeA => codeA,
	errorA => errorA,
	input => input
	);
                                           
generate_test1 : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list
		FOR i IN 0 to 63 LOOP
			input <= std_logic_vector (to_unsigned(0,64));
			input (i) <= '1';
		WAIT FOR 10 ns;
		END LOOP;

--	input <= "0000000000000000000000000000000000000000000000000000000000000001";
--	WAIT FOR 10 ns;
--	input <= "0000000000000000000000000000000000000000000000000000000000000010";
--	WAIT FOR 10 ns;
--	input <= "0000000000000000000000000000000000000000000000000000000000000100";
--	WAIT FOR 10 ns;
--	input <= "0000000000000000000000000000000000000000000000000000000000001000";
--	WAIT FOR 10 ns;
--	input <= "0000000000000000000000000000000000000000000000000000000000010000";
--	WAIT FOR 10 ns;
--	input <= "0000000000000000000000000000000000000000000000000000000000100000";
--	WAIT FOR 10 ns;

	
WAIT;                                                        
END PROCESS generate_test1;                                          
END g47_64_6_encoder_arch;
