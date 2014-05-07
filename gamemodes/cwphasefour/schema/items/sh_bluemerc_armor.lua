--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");
	ITEM.cost = 3500;
	ITEM.name = "Bluemerc Armor";
	ITEM.weight = 2;
	ITEM.business = true;
	ITEM.armorScale = 0.275;
	ITEM.replacement = "models/salem/blue.mdl";
	ITEM.description = "Some Bluemerc branded armor with a stylised mask.\nProvides you with 27.5% bullet resistance.\nProvides you with tear gas protection.";
	ITEM.tearGasProtection = true;
ITEM:Register();