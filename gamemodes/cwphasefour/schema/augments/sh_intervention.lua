--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local AUGMENT = {};

AUGMENT = {};
AUGMENT.name = "Intervention";
AUGMENT.cost = 2400;
AUGMENT.image = "augments/intervention";
AUGMENT.honor = "good";
AUGMENT.description = "Your Ration Guarders give your generators double protection.";

AUG_INTERVENTION = PhaseFour.augment:Register(AUGMENT);