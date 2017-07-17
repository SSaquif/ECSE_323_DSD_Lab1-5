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
-- Generated on "10/17/2016 14:35:30"
                                                            
-- Vhdl Test Bench template for design  :  g47_keyboard_encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
use ieee.numeric_std.all;
library lpm;
use lpm.lpm_components.all;
use IEEE.STD_logic_unsigned.all;   
 
ENTITY g47_keyboard_encoder_vhd_tst IS
END g47_keyboard_encoder_vhd_tst;
ARCHITECTURE g47_keyboard_encoder_arch OF g47_keyboard_encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ASCII_CODE : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL keys : STD_LOGIC_VECTOR(63 DOWNTO 0);
COMPONENT g47_keyboard_encoder
	PORT (
	ASCII_CODE : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	keys : IN STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g47_keyboard_encoder
	PORT MAP (
-- list connections between master ports and signals
	ASCII_CODE => ASCII_CODE,
	keys => keys
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
generate_test2 : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
      -- code executes for every event on sensitivity list
		FOR i IN 0 to 63 LOOP
			keys <= std_logic_vector (to_unsigned(0,64));
			keys (i) <= '1';
		WAIT FOR 10 ns;
		END LOOP;
		
		WAIT FOR 10 ns;
		keys <= "0000000000000000000000000000000000000000000000000000000000000011";
		WAIT FOR 10 ns;
WAIT;
		
END PROCESS generate_test2;                                          
END g47_keyboard_encoder_arch;
