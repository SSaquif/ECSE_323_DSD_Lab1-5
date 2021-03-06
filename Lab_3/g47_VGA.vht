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
-- Generated on "11/03/2016 16:42:25"
                                                            
-- Vhdl Test Bench template for design  :  g47_VGA
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
use ieee.numeric_std.all;
library lpm;
use lpm.lpm_components.all;
use IEEE.STD_logic_unsigned.all;

ENTITY g47_VGA_vhd_tst IS
END g47_VGA_vhd_tst;
ARCHITECTURE g47_VGA_arch OF g47_VGA_vhd_tst IS
-- constants
                                                
-- signals                                                   
SIGNAL BLANKING : STD_LOGIC;
SIGNAL clock : STD_LOGIC;
SIGNAL COLUMN : unsigned(9 DOWNTO 0);
SIGNAL HSYNC : STD_LOGIC;
SIGNAL ROW : unsigned(9 DOWNTO 0);
SIGNAL rst : STD_LOGIC;
SIGNAL VSYNC : STD_LOGIC;
COMPONENT g47_VGA
	PORT (
	BLANKING : OUT STD_LOGIC;
	clock : IN STD_LOGIC;
	COLUMN : OUT unsigned(9 DOWNTO 0);
	HSYNC : OUT STD_LOGIC;
	ROW : OUT unsigned(9 DOWNTO 0);
	rst : IN STD_LOGIC;
	VSYNC : OUT STD_LOGIC
	);
END COMPONENT;

constant clock_period: time := 20 ns;  
BEGIN
	i1 : g47_VGA
	PORT MAP (
-- list connections between master ports and signals
	BLANKING => BLANKING,
	clock => clock,
	COLUMN => COLUMN,
	HSYNC => HSYNC,
	ROW => ROW,
	rst => rst,
	VSYNC => VSYNC
	);
reset_process : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once
			rst <= '1';
			wait for 20 ns;
			rst <= '0';
WAIT;                                                       
END PROCESS;                                           
clock_process : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list
			clock <= '0';
			wait for clock_period/2;
			clock <= '1';
			wait for clock_period/2;
                                                        
END PROCESS;                                          
END g47_VGA_arch;
