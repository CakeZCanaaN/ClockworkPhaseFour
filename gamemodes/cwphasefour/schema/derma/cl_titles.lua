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
	
	PhaseFour.titlesPanel = self;
	
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
	local unlockedTitle = false;
	
	local label = vgui.Create("cwInfoText", self);
		label:SetText("Some victories unlock new titles when you achieve them.");
		label:SetInfoColor("blue");
	self.panelList:AddItem(label);
	
	for k, v in pairs(PhaseFour.victory:GetAll()) do
		if (v.unlockTitle and PhaseFour.victories:Has(k)) then
			local label = vgui.Create("cwInfoText", self);
				label:SetText(string.Replace(v.unlockTitle, "%n", Clockwork.Client:Name()));
				label:SetButton(true);
				label:SetInfoColor("orange");
				label:SetShowIcon(false);
			self.panelList:AddItem(label);
			
			if (Clockwork.Client:GetSharedVar("title") == k) then
				label:SetInfoColor("green");
			end;
			
			-- Called when the button is clicked.
			function label.DoClick(button)
				Derma_Query("Are you sure that you want to set your title to this?", "Set your title.", "Yes", function()
					Clockwork.datastream:Start("SetTitle", k);
				end, "No", function() end);
			end;
			
			unlockedTitle = true;
		end;
	end;
	
	if (!unlockedTitle) then
		local label = vgui.Create("cwInfoText", self);
			label:SetText("You have not unlocked any titles yet, try achieving some victories!");
			label:SetInfoColor("red");
		self.panelList:AddItem(label);
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

vgui.Register("cw_Titles", PANEL, "EditablePanel");