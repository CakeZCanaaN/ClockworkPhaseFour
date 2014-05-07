--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

--[[
	You don't have to do this, but I think it's nicer.
	Alternatively, you can simply use the Schema variable.
--]]
Schema:SetGlobalAlias("PhaseFour");

--[[ You don't have to do this either, but I prefer to seperate the functions. --]]
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_cloudax.lua");
Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_theme.lua");

Clockwork.attribute:FindByID("Stamina").isOnCharScreen = false;

Clockwork.option:SetKey("description_business", "Craft a variety of equipment with your rations.");
Clockwork.option:SetKey("intro_image", "phasefour/phasefour_logo");
Clockwork.option:SetKey("schema_logo", "phasefour/phasefour_logo");
Clockwork.option:SetKey("name_business", "Crafting");
Clockwork.option:SetKey("menu_music", "music/hl2_song19.mp3");
Clockwork.option:SetKey("model_shipment", "models/items/item_item_exper.mdl");
Clockwork.option:SetKey("model_cash", "models/props_lab/exp01a.mdl");
Clockwork.option:SetKey("name_cash", "Rations");
Clockwork.option:SetKey("gradient", "phasefour/bg_gradient");

-- Called when the Clockwork shared variables are added.
function PhaseFour:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Bool("beingChloro", true);
	playerVars:Bool("beingTied", true);
	playerVars:Bool("implant", true);
	playerVars:Number("nextDC", true);
	playerVars:Number("fuel", true);
	playerVars:Bool("ghostheart");
	playerVars:Bool("skullMask");
	playerVars:String("alliance");
	playerVars:Entity("disguise");
	playerVars:Entity("jetpack");
	playerVars:Number("bounty");
	playerVars:String("title");
	playerVars:Number("honor");
	playerVars:Number("rank");
	playerVars:Bool("tied");
end;

Clockwork.quiz:SetName("Agreement");
Clockwork.quiz:SetEnabled(true);
Clockwork.quiz:AddQuestion("I know that because of the logs, I will never get away with rule-breaking.", 1, "Yes.", "No.");
Clockwork.quiz:AddQuestion("When creating a character, I will use a full and appropriate name.", 1, "Yes.", "No.");
Clockwork.quiz:AddQuestion("I understand that the script has vast logs that are checked often.", 1, "Yes.", "No.");
Clockwork.quiz:AddQuestion("I will read the directory in the main menu for help and guides.", 1, "Yes.", "No.");

RANK_RCT = 0;
RANK_PVT = 1;
RANK_SGT = 2;
RANK_LT = 3;
RANK_CPT = 4;
RANK_MAJ = 5;

-- A function to get a player's honor text.
function PhaseFour:PlayerGetHonorText(player, honor)
	if (honor >= 90) then
		return "This character is worshiped!";
	elseif (honor >= 80) then
		return "This character is divine."
	elseif (honor >= 70) then
		return "This character is blessed."
	elseif (honor >= 60) then
		return "This character is a nice guy.";
	elseif (honor >= 50) then
		return "This character is friendly.";
	elseif (honor >= 40) then
		return "This character is nasty.";
	elseif (honor >= 30) then
		return "This character is a bad guy.";
	elseif (honor >= 20) then
		return "This character is cursed.";
	elseif (honor >= 10) then
		return "This character is evil.";
	else
		return "This character is satanic!";
	end;
end;

local modelGroups = {60, 61, 62};

for _, group in pairs(modelGroups) do
	for k, v in pairs(cwFile.Find("models/humans/group"..group.."/*.mdl", "GAME")) do
		if (string.find(string.lower(v), "female")) then
			Clockwork.animation:AddFemaleHumanModel("models/humans/group"..group.."/"..v);
		else
			Clockwork.animation:AddMaleHumanModel("models/humans/group"..group.."/"..v);
		end;
	end;
end;

for k, v in pairs(cwFile.Find("models/napalm_atc/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/napalm_atc/"..v);
end;

for k, v in pairs(cwFile.Find("models/nailgunner/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/nailgunner/"..v);
end;

for k, v in pairs(cwFile.Find("models/salem/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/salem/"..v);
end;

for k, v in pairs(cwFile.Find("models/bio_suit/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/bio_suit/"..v);
end;

for k, v in pairs(cwFile.Find("models/srp/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/srp/"..v);
end;

Clockwork.animation:AddMaleHumanModel("models/humans/group03/male_experim.mdl");
Clockwork.animation:AddMaleHumanModel("models/pmc/pmc_4/pmc__07.mdl");
Clockwork.animation:AddMaleHumanModel("models/tactical_rebel.mdl");
Clockwork.animation:AddMaleHumanModel("models/riot_ex2.mdl");

local MODEL_SPX7 = Clockwork.animation:AddMaleHumanModel("models/spx7.mdl");
local MODEL_SPX2 = Clockwork.animation:AddMaleHumanModel("models/spx2.mdl");
local MODEL_SPEX = Clockwork.animation:AddMaleHumanModel("models/spex.mdl");
local SPEX_MODELS = {MODEL_SPEX, MODEL_SPX2, MODEL_SPX7};

for k, v in ipairs(SPEX_MODELS) do
	Clockwork.animation:AddOverride(v, "stand_grenade_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_pistol_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_blunt_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_slam_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_fist_idle", "LineIdle03");
end;