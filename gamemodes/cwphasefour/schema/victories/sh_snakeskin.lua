--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local VICTORY = {};

VICTORY.name = "Snakeskin";
VICTORY.image = "victories/snakeskin";
VICTORY.reward = 960;
VICTORY.maximum = 1;
VICTORY.description = "Get 100% endurance without using boosts.\nReceive a reward of 960 rations.";
VICTORY.unlockTitle = "%n the Endurable";

VIC_SNAKESKIN = PhaseFour.victory:Register(VICTORY);