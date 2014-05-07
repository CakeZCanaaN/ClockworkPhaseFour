--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");
	ITEM.cost = 500;
	ITEM.name = "Rookie Cloak";
	ITEM.weight = 1;
	ITEM.business = true;
	ITEM.armorScale = 0.05;
	ITEM.replacement = "models/srp/stalker_bandit_veteran.mdl";
	ITEM.description = "A rookie cloak, usually used for comitting good deeds.\nProvides you with 5% bullet resistance.";
ITEM:Register();