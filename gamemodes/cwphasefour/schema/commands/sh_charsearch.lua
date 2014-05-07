--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("CharSearch");
COMMAND.tip = "Search a character if they are tied.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.entity:GetPlayer(player:GetEyeTraceNoCursor().Entity);
	
	if (target) then
		if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
			if (!player:GetSharedVar("tied")) then
				if (target:GetSharedVar("tied")) then
					if (target:GetVelocity():Length() == 0) then
						if (!player.searching) then
							target.beingSearched = true;
							player.searching = target;
							
							Clockwork.storage:Open(player, {
								name = Clockwork.player:FormatRecognisedText(player, "%s", target),
								weight = target:GetMaxWeight(),
								entity = target,
								distance = 192,
								cash = target:GetCash(),
								inventory = target:GetInventory(),
								OnClose = function(player, storageTable, entity)
									player.searching = nil;
									
									if (IsValid(entity)) then
										entity.beingSearched = nil;
									end;
								end
							});
						else
							Clockwork.player:Notify(player, "You are already searching a character!");
						end;
					else
						Clockwork.player:Notify(player, "You cannot search a moving character!");
					end;
				else
					Clockwork.player:Notify(player, "This character is not tied!");
				end;
			else
				Clockwork.player:Notify(player, "You don't have permission to do this right now!");
			end;
		else
			Clockwork.player:Notify(player, "This character is too far away!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a character!");
	end;
end;

COMMAND:Register();