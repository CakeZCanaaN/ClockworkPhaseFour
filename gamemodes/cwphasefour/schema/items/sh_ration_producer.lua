--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("generator_base")
ITEM.name = "Ration Producer";
ITEM.cost = 150;
ITEM.model = "models/props_lab/reciever01a.mdl";
ITEM.business = true;
ITEM.category = "Generators";
ITEM.description = "Produces a medium rate of rations over time.\nThis is not permanent and can be destroyed by others.\nOrdering a second one will destroy your first one.";

ITEM.generatorInfo = {
	powerPlural = "Batteries",
	powerName = "Battery",
	uniqueID = "cw_rationproducer",
	maximum = 1,
	health = 150,
	power = 4,
	cash = 110,
	name = "Ration Producer",
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