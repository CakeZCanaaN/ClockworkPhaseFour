--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local AUGMENT = {};

AUGMENT = {};
AUGMENT.name = "Mutilator";
AUGMENT.cost = 2400;
AUGMENT.image = "augments/mutilator";
AUGMENT.honor = "evil";
AUGMENT.description = "Grants you the ability to mutilate corpses for health.";

AUG_MUTILATOR = PhaseFour.augment:Register(AUGMENT);