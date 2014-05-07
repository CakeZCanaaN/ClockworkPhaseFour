--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("Agility");
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "agt";
	ATTRIBUTE.description = "Affects your overall speed, e.g: how fast you run.";
	ATTRIBUTE.characterScreen = true;
ATB_AGILITY = ATTRIBUTE:Register();