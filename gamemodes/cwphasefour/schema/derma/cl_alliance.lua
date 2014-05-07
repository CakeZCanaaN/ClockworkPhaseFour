--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PANEL = {};

AccessorFunc(PANEL, "m_bPaintBackground", "PaintBackground");
AccessorFunc(PANEL, "m_bgColor", "BackgroundColor");
AccessorFunc(PANEL, "m_bDisabled", "Disabled");

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetSize(Clockwork.menu:GetWidth(), Clockwork.menu:GetHeight());
	
	self.panelList = vgui.Create("cwPanelList", self);
 	self.panelList:SetPadding(2);
 	self.panelList:SetSpacing(3);
 	self.panelList:SizeToContents();
	self.panelList:EnableVerticalScrollbar();
	
	PhaseFour.alliancePanel = self;
	
	self:Rebuild();
end;

-- Called when the panel is painted.
function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Frame", self, w, h);
	
	return true;
end;

-- A function to rebuild the panel.
function PANEL:Rebuild()
	self.panelList:Clear(true);
	
	local myAlliance = Clockwork.Client:GetAlliance();
	
	if (myAlliance) then
		local label = vgui.Create("cwInfoText", self);
			label:SetText("Click here if you want to leave the alliance permanently.");
			label:SetButton(true);
			label:SetInfoColor("red");
		self.panelList:AddItem(label);
		
		-- Called when the button is clicked.
		function label.DoClick(button)
			Derma_Query("Are you sure that you want to leave the alliance?", "Leave the alliance.", "Yes", function()
				Clockwork.kernel:RunCommand("AllyLeave");
			end, "No", function() end);
		end;
		
		local alliancePlayers = {};
		
		for k, v in ipairs(_player.GetAll()) do
			if (v:HasInitialized()) then
				local playerAlliance = v:GetAlliance();
				
				if (playerAlliance and playerAlliance == myAlliance) then
					alliancePlayers[#alliancePlayers + 1] = v;
				end;
			end;
		end;
		
		table.sort(alliancePlayers, function(a, b)
			return a:GetRank() > b:GetRank();
		end);
		
		if (#alliancePlayers > 0) then
			if (Clockwork.Client:IsLeader()) then
				local label = vgui.Create("cwInfoText", self);
					label:SetText("You can manage characters in your alliance by clicking their name.");
					label:SetInfoColor("blue");
				self.panelList:AddItem(label);
			end;
			
			local allianceForm = vgui.Create("DForm", self);
			local panelList = vgui.Create("cwPanelList", self);
			
			for k, v in ipairs(alliancePlayers) do
				local label = vgui.Create("cwInfoText", self);
					label:SetText(v:GetRank(true)..". "..v:Name());
					label:SetInfoColor(_team.GetColor(v:Team()));
				panelList:AddItem(label);
				
				if (Clockwork.Client:IsLeader()) then
					label:SetButton(true);
					
					-- Called when the button is clicked.
					function label.DoClick(button)
						if (IsValid(v) and !v:IsLeader()) then
							local options = {};
							
							options["Kick"] = function()
								Clockwork.datastream:Start("AllyKick", v);
							end;
							
							options["Rank"] = {};
							options["Rank"]["1. Recruit"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_RCT});
							end;
							options["Rank"]["2. Private"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_PVT});
							end;
							options["Rank"]["3. Sergeant"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_SGT});
							end;
							options["Rank"]["4. Lieutenant"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_LT});
							end;
							options["Rank"]["5. Captain"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_CPT});
							end;
							options["Rank"]["6. Major"] = function()
								Derma_Query("Are you sure that you want to make them a leader?", "Make them a leader.", "Yes", function()
									Clockwork.datastream:Start("AllyMakeLeader", v);
								end, "No", function() end);
							end;
							
							Clockwork.kernel:AddMenuFromData(nil, options);
						end;
					end;
				end;
			end;
			
			panelList:SetAutoSize(true);
			panelList:SetPadding(4);
			panelList:SetSpacing(4);
			
			allianceForm:SetName(myAlliance);
			allianceForm:AddItem(panelList);
			allianceForm:SetPadding(4);
			
			self.panelList:AddItem(allianceForm);
		else
			local label = vgui.Create("cwInfoText", self);
				label:SetText("No characters in your alliance are playing.");
				label:SetInfoColor("orange");
			self.panelList:AddItem(label);
		end;
	else
		local label = vgui.Create("cwInfoText", self);
			label:SetText("Creating an alliance will cost you "..Clockwork.kernel:FormatCash(Clockwork.config:Get("alliance_cost"):Get(), nil, true)..".");
			label:SetInfoColor("blue");
		self.panelList:AddItem(label);
		
		local createForm = vgui.Create("DForm", self);
		createForm:SetName("Create an alliance");
		createForm:SetPadding(4);
		
		local textEntry = createForm:TextEntry("Name");
			textEntry:SetToolTip("Choose a nice name for your alliance.");
		local okayButton = createForm:Button("Okay");
		
		-- Called when the button is clicked.
		function okayButton.DoClick(okayButton)
			Clockwork.datastream:Start("CreateAlliance", textEntry:GetValue());
		end;
		
		self.panelList:AddItem(createForm);
	end;

	self.panelList:InvalidateLayout(true);
end;

-- Called when the menu is opened.
function PANEL:OnMenuOpened()
	if (Clockwork.menu:GetActivePanel() == self) then
		self:Rebuild();
	end;
end;

-- Called when the panel is selected.
function PANEL:OnSelected() self:Rebuild(); end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	self.panelList:StretchToParent(4, 28, 4, 4);
	self:SetSize(self:GetWide(), math.min(self.panelList.pnlCanvas:GetTall() + 32, ScrH() * 0.75));
	
	derma.SkinHook("Layout", "Frame", self);
end;

-- Called each frame.
function PANEL:Think()
	self:InvalidateLayout(true);
end;

vgui.Register("cw_Alliance", PANEL, "EditablePanel");