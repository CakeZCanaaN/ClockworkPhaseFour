--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("Aerodynamics");
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "aer";
	ATTRIBUTE.category = "Skills";
	ATTRIBUTE.description = "Affects the the speed at which you fly with jetpacks.";
ATB_AERODYNAMICS = ATTRIBUTE:Register();