--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Notepad";
ITEM.cost = 80;
ITEM.model = "models/props_lab/clipboard.mdl";
ITEM.weight = 0.5;
ITEM.useText = "Edit";
ITEM.business = true;
ITEM.category = "Reusables";
ITEM.description = "A clean and professional notepad with a cardboard backing.";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	Clockwork.datastream:Start(player, "Notepad", player:GetCharacterData("notepad") or "");
	
	Clockwork.player:SetMenuOpen(player, false);
	
	return false;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();