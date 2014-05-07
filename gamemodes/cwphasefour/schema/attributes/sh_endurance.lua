--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("Endurance");
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "end";
	ATTRIBUTE.description = "Affects your overall endurance, e.g: how much pain you can take.";
	ATTRIBUTE.characterScreen = true;
ATB_ENDURANCE = ATTRIBUTE:Register();