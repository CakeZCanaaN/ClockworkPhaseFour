--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("Strength");
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "str";
	ATTRIBUTE.description = "Affects your overall strength, e.g: how hard you punch.";
	ATTRIBUTE.characterScreen = true;
ATB_STRENGTH = ATTRIBUTE:Register();