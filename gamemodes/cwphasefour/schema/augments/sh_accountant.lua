--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local AUGMENT = {};

AUGMENT = {};
AUGMENT.name = "Accountant";
AUGMENT.cost = 3000;
AUGMENT.image = "augments/accountant";
AUGMENT.honor = "good";
AUGMENT.description = "With this augment your generator cash will be sent directly to your Safebox.";

AUG_ACCOUNTANT = PhaseFour.augment:Register(AUGMENT);