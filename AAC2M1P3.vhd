--------------------------------------------------------------------------------
--                                                                            --
--               Application Assignment 3 Module 1 Course 2                   --
--                                                                            --
--------------------------------------------------------------------------------
--
-- [Replace [items in brackets] with your content]
-- @file AAC2M1P3.vhd
-- @brief Application Assignment 2-001 Example code with errors to be found
-- @version: 1.0 
-- Date of current revision:  @date YYYY-MM-DD  
-- Target FPGA: [Intel Altera MAX10] 
-- Tools used: [Quartus Prime 16.1] for editing and synthesis 
--             [Modeltech ModelSIM 10.4a Student Edition] for simulation 
--             [Quartus Prime 16.1]  for place and route if applied
--             
--  Functional Description:  This file contains the VHDL which describes the 
--               FPGA implementation of a 4-bit mux. The inputs are a, 4-bit 
--               vector, and a fixed 4-bit number, with c as the select and b
--               as the output. The output is of type std_logic_vector, which
--               means a conversion function is required.  
--  Hierarchy:  There is only one level in this simple design.
--  
--  Designed for: [Customer] 
--                [Address]
--                [City, ST ZIP]
--                [www.customer, phone number]
--  Designed by:  @author [your name] 
--                [Organization]
--                [email] 
-- 
--      Copyright (c) 2018 by Tim Scherr
--
-- Redistribution, modification or use of this software in source or binary
-- forms is permitted as long as the files maintain this copyright. Users are
-- permitted to modify this and use it to learn about the field of HDl code.
-- Tim Scherr and the University of Colorado are not liable for any misuse
-- of this material.
------------------------------------------------------------------------------
-- 

library ieee;
use ieee.std_logic_1164.all;

entity FSM is
GENERIC
	(
	stateA : std_logic_vector(1 downto 0) := "00";
	stateB : std_logic_vector(1 downto 0) := "01";
	stateC : std_logic_vector(1 downto 0) := "10"
	);
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

-- Architecture

architecture behavioral of FSM is
signal CurrentState, NextState : std_logic_vector(1 downto 0);
begin
	comb_proc : process(In1, CurrentState)
	begin
		case(CurrentState) is
			when stateA =>
				if(In1 = '0') then NextState <= stateA;
				else NextState <= stateB;
				end if;
				Out1 <= '0';
			when stateB =>
				if(In1 = '1') then NextState <= stateB;
				else NextState <= stateC;
				end if;
				Out1 <= '0';	
			when stateC =>
				if(In1 = '0') then NextState <= stateC;
				else NextState <= stateA;
				end if;
				Out1 <= '1';
			when others =>
				NextState <= stateA;
				Out1 <= '0';	
		end case;
	end process;
	clk_proc : process(RST, CLK)
	begin
		if(RST = '1') then CurrentState <= stateA;
		elsif( rising_Edge(CLK) ) then CurrentState <= NextState;	
		end if;
	end process;
end behavioral;
