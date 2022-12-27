---------------------------------------------------------------------------------------------------------
-- MCFFIX added these lines
---------------------------------------------------------------------------------------------------------
MCF_DEFAULT_SETTINGS = {
	["characterFrameCollapsed"] = "0",

	["statCategoryOrder"] = "", --"1,2,3,4,5,6,7",
	["statCategoryOrder_2"] = "", --"1,2,3,4,5,6,7",

	["statCategoriesCollapsed"] = {false, false, false, false, false, false, false},
	["statCategoriesCollapsed_2"] = {false, false, false, false, false, false, false},
}

function MCF_SetSettings(setting, value, id)
	if (id) then
		MCF_SETTINGS[setting][id] = value;
	else
		MCF_SETTINGS[setting] = value;
	end
end

function MCF_GetSettings(query, id)
	if ( MCF_SETTINGS[query] == nil ) then
		MCF_SETTINGS[query] = MCF_DEFAULT_SETTINGS[query];
	end
	if (id) then
		return MCF_SETTINGS[query][id];
	else
		return MCF_SETTINGS[query];
	end
end

--Added this function because built-in is calling CharacterFrame
function MCFUpdateMicroButtons()
	if ( MCFCharacterFrame and MCFCharacterFrame:IsShown() ) then
		CharacterMicroButton:SetButtonState("PUSHED", true);
		CharacterMicroButton_SetPushed();
	else
		CharacterMicroButton:SetButtonState("NORMAL");
		CharacterMicroButton_SetNormal();
	end
end
---------------------------------------------------------------------------------------------------------

MCFCHARACTERFRAME_SUBFRAMES = { "MCFPaperDollFrame", "MCFPetPaperDollFrame", "MCFReputationFrame", "MCFTokenFrame" };
MCFCHARACTERFRAME_EXPANDED_WIDTH = 540;

local MCFNUM_CHARACTERFRAME_TABS = 4;

--MCFFIX READY
function MCFToggleCharacter (tab)
	local subFrame = _G[tab];
	if ( subFrame ) then
		if (not subFrame.hidden) then
			PanelTemplates_SetTab(MCFCharacterFrame, subFrame:GetID());
			if ( MCFCharacterFrame:IsShown() ) then
				if ( subFrame:IsShown() ) then
					--[[ HideUIPanel(MCFCharacterFrame); ]] --MCFFIX swapped to :Hide() because HideUIPanel doesn't work in combat
					MCFCharacterFrame:Hide();
				else
					PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);
					MCFCharacterFrame_ShowSubFrame(tab);
				end
			else
				--[[ ShowUIPanel(MCFCharacterFrame); ]] --MCFFIX swapped to :Show() because HideUIPanel doesn't work in combat
				MCFCharacterFrame:Show();
				MCFCharacterFrame_ShowSubFrame(tab);
			end
		end
	end
end

--MCFFIX READY
function MCFCharacterFrame_ShowSubFrame (frameName)
	for index, value in pairs(MCFCHARACTERFRAME_SUBFRAMES) do
		if ( value ~= frameName ) then
			_G[value]:Hide();	
		end	
	end 
	for index, value in pairs(MCFCHARACTERFRAME_SUBFRAMES) do
		if ( value == frameName ) then
			_G[value]:Show()
		end	
	end 
end

--MCFFIX READY
function MCFCharacterFrameTab_OnClick (self, button)
	local name = self:GetName();
	
	if ( name == "MCFCharacterFrameTab1" ) then
		MCFToggleCharacter("MCFPaperDollFrame");
	elseif ( name == "MCFCharacterFrameTab2" ) then
		MCFToggleCharacter("MCFPetPaperDollFrame");
	elseif ( name == "MCFCharacterFrameTab3" ) then
		MCFToggleCharacter("MCFReputationFrame");	
	elseif ( name == "MCFCharacterFrameTab4" ) then
		MCFToggleCharacter("MCFTokenFrame");	
	end
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);
end

--MCFFIX READY
function MCFCharacterFrame_OnLoad(self)
	PortraitFrameTemplateMixin.OnLoad(self);

	self:RegisterEvent("ADDON_LOADED"); --MCFFIX added this line for SavedVariables system
	self:RegisterEvent("UNIT_PORTRAIT_UPDATE"); --MCFFIX added event
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("PLAYER_PVP_RANK_CHANGED");
	self:RegisterEvent("PREVIEW_TALENT_POINTS_CHANGED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");

	ButtonFrameTemplate_HideButtonBar(self);
	self.Inset:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", PANEL_DEFAULT_WIDTH + PANEL_INSET_RIGHT_OFFSET, PANEL_INSET_BOTTOM_OFFSET);
	self.TitleText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

	SetTextStatusBarTextPrefix(PlayerFrameHealthBar, HEALTH);
	SetTextStatusBarTextPrefix(PlayerFrameManaBar, MANA);
	SetTextStatusBarTextPrefix(MainMenuExpBar, XP);
	--TextStatusBar_UpdateTextString(MainMenuExpBar); --MCFFIX disabled function
	ExpBar_UpdateTextString(); --MCFFIX added function call

	-- Tab Handling code
	PanelTemplates_SetNumTabs(self, MCFNUM_CHARACTERFRAME_TABS);
	PanelTemplates_SetTab(self, 1);
end

--MCFFIX READY
function MCFCharacterFrame_UpdatePortrait()
	local masteryIndex = MCF_GetPrimaryTalentTree();
	if (masteryIndex == 0) then
		local _, class = UnitClass("player");
		MCFCharacterFramePortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
		MCFCharacterFramePortrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]));
	else
		local _, icon, _, iconName = GetTalentTabInfo(masteryIndex);

		MCFCharacterFramePortrait:SetTexCoord(0, 1, 0, 1);
		SetPortraitToTexture(MCFCharacterFramePortrait, icon);
	end
end

--MCFFIX READY
function MCFCharacterFrame_OnEvent(self, event, ...)
	if ( event == "ADDON_LOADED" and ... == "ModernCharacterFrame") then
		if MCF_SETTINGS == nil then
			MCF_SETTINGS = MCF_DEFAULT_SETTINGS;
		end
	end

	if ( not self:IsShown() ) then
		return;
	end

	local arg1 = ...;
	if ( event == "UNIT_NAME_UPDATE" ) then
		if ( arg1 == "player" and not MCFPetPaperDollFrame:IsShown()) then
			MCFCharacterFrameTitleText:SetText(UnitPVPName("player"));
		end
		return;
	elseif ( event == "PLAYER_PVP_RANK_CHANGED" ) then
		if (not MCFPetPaperDollFrame:IsShown()) then
			MCFCharacterFrameTitleText:SetText(UnitPVPName("player"));
		end
	elseif (	event == "PREVIEW_TALENT_POINTS_CHANGED"
				or event == "PLAYER_TALENT_UPDATE"
				or event == "ACTIVE_TALENT_GROUP_CHANGED") then
		MCFCharacterFrame_UpdatePortrait();
	end
end

--MCFFIX READY
function MCFCharacterFrame_OnShow(self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
	MCFCharacterFrame_UpdatePortrait();
	MCFUpdateMicroButtons();
	PlayerFrameHealthBar.showNumeric = true;
	PlayerFrameManaBar.showNumeric = true;
	PlayerFrameAlternateManaBar.showNumeric = true;
	MainMenuExpBar.showNumeric = true;
	PetFrameHealthBar.showNumeric = true;
	PetFrameManaBar.showNumeric = true;
	ShowTextStatusBarText(PlayerFrameHealthBar);
	ShowTextStatusBarText(PlayerFrameManaBar);
	ShowTextStatusBarText(PlayerFrameAlternateManaBar);
	ShowTextStatusBarText(MainMenuExpBar);
	ShowTextStatusBarText(PetFrameHealthBar);
	ShowTextStatusBarText(PetFrameManaBar);

	--MCFFIX disabled function because makes error. Not sure what it does
	--ShowWatchedReputationBarText();
	MicroButtonPulseStop(CharacterMicroButton);	--Stop the button pulse
end

--MCFFIX READY
function MCFCharacterFrame_OnHide(self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE);
	MCFUpdateMicroButtons();
	PlayerFrameHealthBar.showNumeric = nil;
	PlayerFrameManaBar.showNumeric = nil;
	PlayerFrameAlternateManaBar.showNumeric = nil;
	MainMenuExpBar.showNumeric = nil;
	PetFrameHealthBar.showNumeric = nil;
	PetFrameManaBar.showNumeric = nil;
	HideTextStatusBarText(PlayerFrameHealthBar);
	HideTextStatusBarText(PlayerFrameManaBar);
	HideTextStatusBarText(PlayerFrameAlternateManaBar);
	HideTextStatusBarText(MainMenuExpBar);
	HideTextStatusBarText(PetFrameHealthBar);
	HideTextStatusBarText(PetFrameManaBar);
	--[[ HideWatchedReputationBarText(); ]] --MCFFIX
	MCFPaperDollFrame.currentSideBar = nil;
end

--MCFFIX READY
function MCFCharacterFrame_Collapse()
	MCFCharacterFrame:SetWidth(PANEL_DEFAULT_WIDTH);
	MCFCharacterFrame.Expanded = false;
	MCFCharacterFrameExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	MCFCharacterFrameExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	MCFCharacterFrameExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	
	for i = 1, #MCFPAPERDOLL_SIDEBARS do
		_G[MCFPAPERDOLL_SIDEBARS[i].frame]:Hide();
	end
	
	MCFCharacterFrameInsetRight:Hide();
	UpdateUIPanelPositions(MCFCharacterFrame);
	MCFPaperDollFrame_SetLevel();

	--MCFFIX disabled trial related thing
	--CharacterTrialLevelErrorText:SetPoint("TOP", CharacterLevelText, "BOTTOM", 0, -3);
end

--MCFFIX ready
function MCFCharacterFrame_Expand()
	MCFCharacterFrame:SetWidth(MCFCHARACTERFRAME_EXPANDED_WIDTH);
	MCFCharacterFrame.Expanded = true;
	MCFCharacterFrameExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	MCFCharacterFrameExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	MCFCharacterFrameExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	if (MCFPaperDollFrame:IsShown() and MCFPaperDollFrame.currentSideBar) then
		MCFPaperDollFrame.currentSideBar:Show();
	else
		MCFCharacterStatsPane:Show();
	end
	MCFPaperDollFrame_UpdateSidebarTabs();
	MCFCharacterFrameInsetRight:Show();
	UpdateUIPanelPositions(MCFCharacterFrame);
	MCFPaperDollFrame_SetLevel();

	--MCFFIX disabled trial related things
	--[[ -- trial edition
	local width = CharacterTrialLevelErrorText:GetWidth();
	if ( width > 190 ) then
		CharacterTrialLevelErrorText:SetPoint("TOP", CharacterLevelText, "BOTTOM", -((width-190)/2), -3);
	end ]]
end

--MCFFIX READY
local function CompareFrameSize(frame1, frame2)
	return frame1:GetWidth() > frame2:GetWidth();
end
local CharTabtable = {};
--MCFFIX READY
function MCFCharacterFrame_TabBoundsCheck(self)
	if ( string.sub(self:GetName(), 1, 20) ~= "MCFCharacterFrameTab" ) then
		return;
	end
	
	for i=1, MCFNUM_CHARACTERFRAME_TABS do
		_G["MCFCharacterFrameTab"..i.."Text"]:SetWidth(0);
		PanelTemplates_TabResize(_G["MCFCharacterFrameTab"..i], 0, nil, 36, 88);
	end
	
	local diff = _G["MCFCharacterFrameTab"..MCFNUM_CHARACTERFRAME_TABS]:GetRight() - MCFCharacterFrame:GetRight();

	if ( diff > 0 and MCFCharacterFrameTab4:IsShown() and MCFCharacterFrameTab2:IsShown()) then
		--Find the biggest tab
		for i=1, MCFNUM_CHARACTERFRAME_TABS do
			CharTabtable[i]=_G["MCFCharacterFrameTab"..i];
		end
		table.sort(CharTabtable, CompareFrameSize);
		
		local i=1;
		while ( diff > 0 and i <= MCFNUM_CHARACTERFRAME_TABS) do
			local tabText = _G[CharTabtable[i]:GetName().."Text"]
			local change = min(10, diff);
			diff = diff - change;
			tabText:SetWidth(0);
			PanelTemplates_TabResize(CharTabtable[i], -change, nil, 36-change, 88);
			i = i+1;
		end
	end
end
