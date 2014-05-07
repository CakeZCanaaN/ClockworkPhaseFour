--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local AUGMENT = {};

AUGMENT = {};
AUGMENT.name = "Reckoner";
AUGMENT.cost = 3000;
AUGMENT.image = "augments/reckoner";
AUGMENT.honor = "evil";
AUGMENT.description = "With this augment your generator cash will be sent directly to your inventory.";

AUG_RECKONER = PhaseFour.augment:Register(AUGMENT);