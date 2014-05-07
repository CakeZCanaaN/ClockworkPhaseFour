--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("generator_base")
ITEM.name = "Ration Printer";
ITEM.cost = 100;
ITEM.model = "models/props_lab/reciever01b.mdl";
ITEM.business = true;
ITEM.category = "Generators";
ITEM.description = "Prints a minor rate of rations over time.\nThis is not permanent and can be destroyed by others.\nOrdering a second one will destroy your first one.";

ITEM.generatorInfo = {
	powerPlural = "Batteries",
	powerName = "Battery",
	uniqueID = "cw_rationprinter",
	maximum = 1,
	health = 100,
	power = 3,
	cash = 90,
	name = "Ration Printer",
};

-- Called before a player orders the item.
function ITEM:PreOrder(player)
	local entities = Clockwork.player:GetPropertyEntities(player, self("generatorInfo").uniqueID);
	
	for k, v in ipairs(entities) do
		v:Explode(); v:Remove();
		Clockwork.entity:ClearProperty(v);
	end;
end;

-- Called before a player drops the item.
function ITEM:PreDrop(player)
	self:PreOrder(player);
end;

ITEM:Register();