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
	
	PhaseFour.augments.panel = self;
	
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
	
	local permaPanels = {};
	local goodPanels = {};
	local evilPanels = {};
	
	for k, v in pairs(PhaseFour.augment:GetAll()) do
		if (v.honor == "perma") then
			permaPanels[#permaPanels + 1] = v;
		elseif (v.honor == "good") then
			goodPanels[#goodPanels + 1] = v;
		elseif (v.honor == "evil") then
			evilPanels[#evilPanels + 1] = v;
		end;
	end;
	
	local label = vgui.Create("cwInfoText", self);
		label:SetText("Yellow augments give you an advantage regardless of honor.");
		label:SetInfoColor("orange");
		label:SetShowIcon(false);
	self.panelList:AddItem(label);
	
	local label = vgui.Create("cwInfoText", self);
		label:SetText("Red augments give you an advantage as long as you are evil.");
		label:SetInfoColor("red");
		label:SetShowIcon(false);
	self.panelList:AddItem(label);
	
	local label = vgui.Create("cwInfoText", self);
		label:SetText("Blue augments give you an advantage as long as you are good.");
		label:SetInfoColor("blue");
		label:SetShowIcon(false);
	self.panelList:AddItem(label);
	
	table.sort(permaPanels, function(a, b) return a.cost > b.cost; end);
	table.sort(goodPanels, function(a, b) return a.cost > b.cost; end);
	table.sort(evilPanels, function(a, b) return a.cost > b.cost; end);
	
	if (#permaPanels > 0) then
		local permaForm = vgui.Create("DForm", self);
		local panelList = vgui.Create("cwPanelList", self);
		
		for k, v in pairs(permaPanels) do
			self.currentAugment = v;
			panelList:AddItem(vgui.Create("cw_Augment"));
		end;
		
		panelList:SetAutoSize(true);
		panelList:SetPadding(4);
		panelList:SetSpacing(4);
		
		permaForm:SetName("Permanent");
		permaForm:AddItem(panelList);
		permaForm:SetPadding(4);
		
		self.panelList:AddItem(permaForm);
	end;
	
	if (#goodPanels > 0) then
		local goodForm = vgui.Create("DForm", self);
		local panelList = vgui.Create("cwPanelList", self);
		
		for k, v in pairs(goodPanels) do
			self.currentAugment = v;
			panelList:AddItem(vgui.Create("cw_Augment"));
		end;
		
		panelList:SetAutoSize(true);
		panelList:SetPadding(4);
		panelList:SetSpacing(4);
		
		goodForm:SetName("Good Honor");
		goodForm:AddItem(panelList);
		goodForm:SetPadding(4);
		
		self.panelList:AddItem(goodForm);
	end;
	
	if (#evilPanels > 0) then
		local evilForm = vgui.Create("DForm", self);
		local panelList = vgui.Create("cwPanelList", self);
		
		for k, v in pairs(evilPanels) do
			self.currentAugment = v;
			panelList:AddItem(vgui.Create("cw_Augment"));
		end;
		
		panelList:SetAutoSize(true);
		panelList:SetPadding(4);
		panelList:SetSpacing(4);
		
		evilForm:SetName("Evil Honor");
		evilForm:AddItem(panelList);
		evilForm:SetPadding(4);
		
		self.panelList:AddItem(evilForm);
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

vgui.Register("cw_Augments", PANEL, "EditablePanel");

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), 34);
	
	self.augment = PhaseFour.augments:GetPanel().currentAugment;
	self.nameLabel = vgui.Create("DLabel", self);
	self.nameLabel:SetText(self.augment.name);
	self.nameLabel:SetDark(true);
	self.nameLabel:SizeToContents();
	
	self.costLabel = vgui.Create("DLabel", self); 
	self.costLabel:SetText("Get this augment for "..Clockwork.kernel:FormatCash(self.augment.cost)..".");
	self.costLabel:SetDark(true);
	self.costLabel:SizeToContents();
	
	self.spawnIcon = vgui.Create("DImageButton", self);
	self.spawnIcon:SetToolTip(self.augment.description);
	self.spawnIcon:SetSize(32, 32);
	
	if (PhaseFour.augments:Has(self.augment.name, true)) then
		self.spawnIcon:SetImage("augments/augmented.png");
		self.costLabel:SetText("You have this augment.");
		self.costLabel:SizeToContents();
	else
		self.spawnIcon:SetImage(self.augment.image..".png");
	end;
	
	-- Called when the spawn icon is clicked.
	function self.spawnIcon.DoClick(spawnIcon)
		Clockwork.datastream:Start("GetAugment", self.augment.uniqueID);
	end;
end;

-- Called each frame.
function PANEL:Think()
	self.spawnIcon:SetPos(1, 1);
	self.spawnIcon:SetSize(32, 32);
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	self.spawnIcon:SetPos(1, 1);
	self.spawnIcon:SetSize(32, 32);
	self.nameLabel:SetPos(36, 2);
	self.costLabel:SetPos(36, 32 - self.costLabel:GetTall());
	self.nameLabel:SizeToContents();
	self.costLabel:SizeToContents();
end;

vgui.Register("cw_Augment", PANEL, "DPanel");