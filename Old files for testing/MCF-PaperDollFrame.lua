-- copied
local itemSlotButtons = {};

-- copied
local STATCATEGORY_PADDING = 4;
local STATCATEGORY_MOVING_INDENT = 4;
-- copied
MCFMOVING_STAT_CATEGORY = nil;
-- copied
local StatCategoryFrames = {};
-- copied
local STRIPE_COLOR = {r=0.9, g=0.9, b=1};

-- copied
MCFPAPERDOLL_SIDEBARS = {
	{
		name=PAPERDOLL_SIDEBAR_STATS;
		frame="MCFCharacterStatsPane";
		icon = nil;  -- Uses the character portrait
		texCoords = {0.109375, 0.890625, 0.09375, 0.90625};
	},
	{
		name=PAPERDOLL_SIDEBAR_TITLES;
		frame="MCFPaperDollTitlesPane";
		icon = "Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.32421875, 0.46093750};
	},
	{
		name=PAPERDOLL_EQUIPMENTMANAGER;
		frame="MCFPaperDollEquipmentManagerPane";
		icon = "Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.46875000, 0.60546875};
	},
};

--MCFFIX READY copied
--Commented out a few events that don't exist anymore
function MCFPaperDollFrame_OnLoad (self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("UNIT_MODEL_CHANGED");
	self:RegisterEvent("UNIT_LEVEL");
	self:RegisterEvent("UNIT_RESISTANCES");
	self:RegisterEvent("UNIT_STATS");
	self:RegisterEvent("UNIT_DAMAGE");
	self:RegisterEvent("UNIT_RANGEDDAMAGE");
	self:RegisterEvent("UNIT_ATTACK_SPEED");
	self:RegisterEvent("UNIT_ATTACK_POWER");
	self:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
	self:RegisterEvent("UNIT_ATTACK");
	self:RegisterEvent("UNIT_SPELL_HASTE");
	self:RegisterEvent("PLAYER_GUILD_UPDATE");
	self:RegisterEvent("SKILL_LINES_CHANGED");
	self:RegisterEvent("COMBAT_RATING_UPDATE");
	--self:RegisterEvent("MASTERY_UPDATE");
	--self:RegisterEvent("KNOWN_TITLES_UPDATE");
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	--self:RegisterEvent("PLAYER_BANKSLOTS_CHANGED");
	--self:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_READY");
	self:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	self:RegisterEvent("UNIT_MAXHEALTH");
	-- flyout settings
	MCFPaperDollItemsFrame.flyoutSettings = {
		onClickFunc = MCFPaperDollFrameItemFlyoutButton_OnClick,
		getItemsFunc = MCFPaperDollFrameItemFlyout_GetItems,
		postGetItemsFunc = MCFPaperDollFrameItemFlyout_PostGetItems, 
		hasPopouts = true,
		parent = MCFPaperDollFrame,
		anchorX = 0,
		anchorY = -3,
		verticalAnchorX = 0,
		verticalAnchorY = 0,
	};
	MCFPaperDollFrame_UpdateStats(); -- MCFFIX added this force update because for some reason stats don't get updated at first open
end

--MCFFIX READY need to replace old event handlers - copied
function MCFPaperDollFrame_OnEvent (self, event, ...)
	local unit = ...;
	if ( event == "PLAYER_ENTERING_WORLD" or
		event == "UNIT_MODEL_CHANGED" and unit == "player" ) then
		MCFCharacterModelFrame:SetUnit("player");
		return;
	
	elseif ( --[[ event == "KNOWN_TITLES_UPDATE" or ( ]]event == "UNIT_NAME_UPDATE" and unit == "player"--[[ ) ]]) then
		if (MCFPaperDollTitlesPane:IsShown()) then
			MCFPaperDollTitlesPane_Update();
		end
	end
	
	if ( not self:IsVisible() ) then
		return;
	end
	
	if ( unit == "player" ) then
		if ( event == "UNIT_LEVEL" ) then
			MCFPaperDollFrame_SetLevel();
		elseif ( event == "UNIT_DAMAGE" or event == "UNIT_ATTACK_SPEED" or event == "UNIT_RANGEDDAMAGE" or event == "UNIT_ATTACK" or event == "UNIT_STATS" or event == "UNIT_RANGED_ATTACK_POWER" or event == "UNIT_RESISTANCES" or event == "UNIT_SPELL_HASTE" or event == "UNIT_MAXHEALTH" ) then
			self:SetScript("OnUpdate", MCFPaperDollFrame_QueuedUpdate);
		end
	end
	
	if ( event == "COMBAT_RATING_UPDATE" or event=="MASTERY_UPDATE" or event == "BAG_UPDATE" or event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_BANKSLOTS_CHANGED" or event == "PLAYER_AVG_ITEM_LEVEL_READY" or event == "PLAYER_DAMAGE_DONE_MODS") then
		self:SetScript("OnUpdate", MCFPaperDollFrame_QueuedUpdate);
	elseif (event == "VARIABLES_LOADED") then
		if (MCF_GetSettings("characterFrameCollapsed") ~= "0") then
			MCFCharacterFrame_Collapse();
		else
			MCFCharacterFrame_Expand();
		end
		
		local activeSpec = GetActiveTalentGroup();
		if (activeSpec == 1) then
			MCFPaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
		else
			MCFPaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
		end
	elseif (event == "PLAYER_TALENT_UPDATE") then
		MCFPaperDollFrame_SetLevel();
		self:SetScript("OnUpdate", MCFPaperDollFrame_QueuedUpdate);
	elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
		local activeSpec = GetActiveTalentGroup();
		if (activeSpec == 1) then
			MCFPaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
		else
			MCFPaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollFrame_OnShow (self)
	MCFCharacterStatsPane.initialOffsetY = 0;
	MCFCharacterFrameTitleText:SetText(UnitPVPName("player"));
	MCFPaperDollFrame_SetLevel();
	local activeSpec = GetActiveTalentGroup();
	if (activeSpec == 1) then
		MCFPaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
	else
		MCFPaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
	end
	if (MCF_GetSettings("characterFrameCollapsed") ~= "0") then
		MCFCharacterFrame_Collapse();
	else
		MCFCharacterFrame_Expand();
	end
	MCFCharacterFrameExpandButton:Show();
	MCFCharacterFrameExpandButton.collapseTooltip = MCF_STATS_COLLAPSE_TOOLTIP;
	MCFCharacterFrameExpandButton.expandTooltip = MCF_STATS_EXPAND_TOOLTIP;
	
	MCFSetPaperDollBackground(MCFCharacterModelFrame, "player");
	MCFPaperDollBgDesaturate(1);
	MCFPaperDollSidebarTabs:Show();
end

--MCFFIX READY copied
function MCFPaperDollFrame_OnHide (self)
	MCFCharacterStatsPane.initialOffsetY = 0;
	MCFCharacterFrame_Collapse();
	MCFCharacterFrameExpandButton:Hide();
	if (MCFMOVING_STAT_CATEGORY) then
		MCFPaperDollStatCategory_OnDragStop(MCFMOVING_STAT_CATEGORY);
	end
	MCFPaperDollSidebarTabs:Hide();
end

--MCFFIX READY
function MCFPaperDoll_IsEquippedSlot (slot)
	if ( slot ) then
		slot = tonumber(slot);
		if ( slot ) then
			return slot >= EQUIPPED_FIRST and slot <= EQUIPPED_LAST;
		end
	end
	return false;
end

--MCFFIX READY copied
function MCFCharacterModelFrame_OnMouseUp (self, button)
	if ( button == "LeftButton" ) then
		AutoEquipCursorItem();
	end
	Model_OnMouseUp(self, button);
end

--MCFFIX READY copied
function MCFPaperDollFrame_SetLevel()
	local primaryTalentTree = MCF_GetPrimaryTalentTree();
	local classDisplayName, class = UnitClass("player"); 
	local classColor = RAID_CLASS_COLORS[class];
	local classColorString = format("ff%.2x%.2x%.2x", classColor.r * 255, classColor.g * 255, classColor.b * 255);
	local specName, _;
	
	if (primaryTalentTree) then
		specName = GetTalentTabInfo(primaryTalentTree);
	end
	
	if (specName and specName ~= "") then
		MCFCharacterLevelText:SetFormattedText(MCF_PLAYER_LEVEL, UnitLevel("player"), classColorString, specName, classDisplayName);
	else
		MCFCharacterLevelText:SetFormattedText(MCF_PLAYER_LEVEL_NO_SPEC, UnitLevel("player"), classColorString, classDisplayName);
	end
	
	-- Hack: if the string is very long, move it a bit so that it has more room (although it will no longer be centered)
	if (MCFCharacterLevelText:GetWidth() > 210) then
		if (MCFCharacterFrameInsetRight:IsVisible()) then
			MCFCharacterLevelText:SetPoint("TOP", -10, -36);
		else
			MCFCharacterLevelText:SetPoint("TOP", 10, -36);
		end
	else
		MCFCharacterLevelText:SetPoint("TOP", 0, -36);
	end
end

--MCFFIX READY copied
-- This makes sure the update only happens once at the end of the frame
function MCFPaperDollFrame_QueuedUpdate(self)
	MCFPaperDollFrame_UpdateStats();
	self:SetScript("OnUpdate", nil);
end

--MCFFIX READY copied
function MCFPaperDollFrame_ClearIgnoredSlots ()
	--[[ EquipmentManagerClearIgnoredSlotsForSave(); ]] --MCFFIX replaced with modern version below
	C_EquipmentSet.ClearIgnoredSlotsForSave()
	for k, button in next, itemSlotButtons do
		if ( button.ignored ) then
			button.ignored = nil;
			MCFPaperDollItemSlotButton_Update(button);
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollFrame_IgnoreSlotsForSet (setID)
	--[[ local set = GetEquipmentSetItemIDs(setName); ]] --MCFFIX replaced with modern version
	local set = C_EquipmentSet.GetItemIDs(setID);
	for slot, item in ipairs(set) do
		if ( item == EQUIPMENT_SET_IGNORED_SLOT ) then
			--[[ EquipmentManagerIgnoreSlotForSave(slot); ]] --MCFFIX replaced with modern version
			C_EquipmentSet.IgnoreSlotForSave(slot);
			itemSlotButtons[slot].ignored = true;
			MCFPaperDollItemSlotButton_Update(itemSlotButtons[slot]);
		end
	end
end

--MCFFIXWORKINPROGRESS copied
function MCFPaperDollFrame_IgnoreSlot(slot)
	--[[ EquipmentManagerIgnoreSlotForSave(slot); ]] --MCFFIX replaced with modern version
	C_EquipmentSet.IgnoreSlotForSave(slot);
	itemSlotButtons[slot].ignored = true;
	MCFPaperDollItemSlotButton_Update(itemSlotButtons[slot]);
end

--MCFFIX READY
function MCFPaperDollItemSlotButton_OnLoad (self)
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	local slotName = self:GetName();
	local id, textureName, checkRelic = GetInventorySlotInfo(strsub(slotName,13));
	self:SetID(id);
	local texture = _G[slotName.."IconTexture"];
	texture:SetTexture(textureName);
	self.backgroundTextureName = textureName;
	self.checkRelic = checkRelic;
	self.UpdateTooltip = MCFPaperDollItemSlotButton_OnEnter;
	itemSlotButtons[id] = self;
	self.verticalFlyout = MCF_VERTICAL_FLYOUTS[id];
	
	local popoutButton = self.popoutButton;
	if ( popoutButton ) then
		if ( self.verticalFlyout ) then
			popoutButton:SetHeight(16);
			popoutButton:SetWidth(38);
			
			popoutButton:GetNormalTexture():SetTexCoord(0.15625, 0.84375, 0.5, 0);
			popoutButton:GetHighlightTexture():SetTexCoord(0.15625, 0.84375, 1, 0.5);
			popoutButton:ClearAllPoints();
			popoutButton:SetPoint("TOP", self, "BOTTOM", 0, 4);
		else
			popoutButton:SetHeight(38);
			popoutButton:SetWidth(16);
			
			popoutButton:GetNormalTexture():SetTexCoord(0.15625, 0.5, 0.84375, 0.5, 0.15625, 0, 0.84375, 0);
			popoutButton:GetHighlightTexture():SetTexCoord(0.15625, 1, 0.84375, 1, 0.15625, 0.5, 0.84375, 0.5);
			popoutButton:ClearAllPoints();
			popoutButton:SetPoint("LEFT", self, "RIGHT", -8, 0);
		end
	end
end

--MCFFIX READY probably need to replace SHOW_COMPARE_TOOLTIP with something modern
function MCFPaperDollItemSlotButton_OnShow (self, isBag)
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("MERCHANT_UPDATE");
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	self:RegisterEvent("ITEM_LOCK_CHANGED");
	self:RegisterEvent("CURSOR_CHANGED");
	--self:RegisterEvent("SHOW_COMPARE_TOOLTIP");
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	if ( not isBag ) then
		self:RegisterEvent("BAG_UPDATE_COOLDOWN");
	end
	MCFPaperDollItemSlotButton_Update(self);
end

--MCFFIX READY probably need to replace SHOW_COMPARE_TOOLTIP with something modern
function MCFPaperDollItemSlotButton_OnHide (self)
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:UnregisterEvent("MERCHANT_UPDATE");
	self:UnregisterEvent("PLAYERBANKSLOTS_CHANGED");
	self:UnregisterEvent("ITEM_LOCK_CHANGED");
	self:UnregisterEvent("CURSOR_CHANGED");
	self:UnregisterEvent("BAG_UPDATE_COOLDOWN");
	--self:UnregisterEvent("SHOW_COMPARE_TOOLTIP");
	self:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
end

--MCFFIX ready (kinda)
--Probably needs rework because I just commented out part of code
function MCFPaperDollItemSlotButton_OnEvent (self, event, ...)
	local arg1, arg2 = ...;
	if ( event == "PLAYER_EQUIPMENT_CHANGED" ) then
		if ( self:GetID() == arg1 ) then
			MCFPaperDollItemSlotButton_Update(self);
		end
	elseif ( event == "ITEM_LOCK_CHANGED" ) then
		if ( not arg2 and arg1 == self:GetID() ) then
			MCFPaperDollItemSlotButton_UpdateLock(self);
		end
	elseif ( event == "BAG_UPDATE_COOLDOWN" ) then
		MCFPaperDollItemSlotButton_Update(self);
	elseif ( event == "CURSOR_CHANGED" ) then
		if ( CursorCanGoInSlot(self:GetID()) ) then
			self:LockHighlight();
		else
			self:UnlockHighlight();
		end
	--MCFFIX disabled condition because it uses event that doesn't exist anymore
	--[[
	elseif ( event == "SHOW_COMPARE_TOOLTIP" ) then
		if ( (arg1 ~= self:GetID()) or (arg2 > NUM_SHOPPING_TOOLTIPS) ) then
			return;
		end

		local tooltip = _G["ShoppingTooltip"..arg2];
		local anchor = "ANCHOR_RIGHT";
		if ( arg2 > 1 ) then
			anchor = "ANCHOR_BOTTOMRIGHT";
		end
		tooltip:SetOwner(self, anchor);
		local hasItem, hasCooldown = tooltip:SetInventoryItem("player", self:GetID());
		if ( not hasItem ) then
			tooltip:Hide();
		end
	]]--
	elseif ( event == "UPDATE_INVENTORY_ALERTS" ) then
		MCFPaperDollItemSlotButton_Update(self);
	elseif ( event == "MODIFIER_STATE_CHANGED" ) then
		if ( IsModifiedClick("SHOWITEMFLYOUT") and self:IsMouseOver() ) then
			MCFPaperDollItemSlotButton_OnEnter(self);
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollItemSlotButton_OnClick (self, button)
	MerchantFrame_ResetRefundItem();
	if ( button == "LeftButton" ) then
		local type = GetCursorInfo();
		if ( type == "merchant" and MerchantFrame.extendedCost ) then
			MerchantFrame_ConfirmExtendedItemCost(MerchantFrame.extendedCost);
		else
			PickupInventoryItem(self:GetID());
			if ( CursorHasItem() ) then
				MerchantFrame_SetRefundItem(self, 1);
			end
		end
	else
		UseInventoryItem(self:GetID());
	end
end

--MCFFIX READY copied
function MCFPaperDollItemSlotButton_OnModifiedClick (self, button)
	if ( HandleModifiedItemClick(GetInventoryItemLink("player", self:GetID())) ) then
		return;
	end
	if ( IsModifiedClick("SOCKETITEM") ) then
		SocketInventoryItem(self:GetID());
	end
end

--MCFFIX ready - needs fix for call of Cooldown related function - copied
function MCFPaperDollItemSlotButton_Update (self)
	local textureName = GetInventoryItemTexture("player", self:GetID());
	local cooldown = _G[self:GetName().."Cooldown"];
	if ( textureName ) then
		SetItemButtonTexture(self, textureName);
		SetItemButtonCount(self, GetInventoryItemCount("player", self:GetID()));
		if ( GetInventoryItemBroken("player", self:GetID()) ) then
			SetItemButtonTextureVertexColor(self, 0.9, 0, 0);
			SetItemButtonNormalTextureVertexColor(self, 0.9, 0, 0);
		else
			SetItemButtonTextureVertexColor(self, 1.0, 1.0, 1.0);
			SetItemButtonNormalTextureVertexColor(self, 1.0, 1.0, 1.0);
		end
		--[[ if ( cooldown ) then
			local start, duration, enable = GetInventoryItemCooldown("player", self:GetID());
			CooldownFrame_SetTimer(cooldown, start, duration, enable);
		end ]] --MCFFIX temporary disabled, doesn't show cooldown texture
		
		self.hasItem = 1;
	else
		local textureName = self.backgroundTextureName;
		if ( self.checkRelic and UnitHasRelicSlot("player") ) then
			textureName = "Interface\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp";
		end
		SetItemButtonTexture(self, textureName);
		SetItemButtonCount(self, 0);
		SetItemButtonTextureVertexColor(self, 1.0, 1.0, 1.0);
		SetItemButtonNormalTextureVertexColor(self, 1.0, 1.0, 1.0);
		--[[ if ( cooldown ) then
			cooldown:Hide();
		end ]] --MCFFIX temporary disabled, doesn't show cooldown texture
		self.hasItem = nil;
	end
	
	if (not MCFPaperDollEquipmentManagerPane:IsShown()) then
		self.ignored = nil;
	end
	
	if ( self.ignored and self.ignoreTexture ) then
		self.ignoreTexture:Show();
	elseif ( self.ignoreTexture ) then
		self.ignoreTexture:Hide();
	end

	MCFPaperDollItemSlotButton_UpdateLock(self);

	-- Update repair all button status
	MerchantFrame_UpdateGuildBankRepair();
	MerchantFrame_UpdateCanRepairAll();
end

--MCFFIX READY copied
function MCFPaperDollItemSlotButton_UpdateLock (self)
	if ( IsInventoryItemLocked(self:GetID()) ) then
		--this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		SetItemButtonDesaturated(self, 1);
	else 
		--this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		SetItemButtonDesaturated(self, nil);
	end
end

--MCFFIXWORKINPROGRESS copied
function MCFPaperDollItemSlotButton_OnEnter (self)
	self:RegisterEvent("MODIFIER_STATE_CHANGED");
	--[[ EquipmentFlyout_UpdateFlyout(self);
	if ( not EquipmentFlyout_SetTooltipAnchor(self) ) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end ]]
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); --MCFTEST added this line without if condition because EquipmentFlyout function doesn't exist

	local hasItem, hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", self:GetID());
	if ( not hasItem ) then
		local text = _G[strupper(strsub(self:GetName(), 13))];
		if ( self.checkRelic and UnitHasRelicSlot("player") ) then
			text = RELICSLOT;
		end
		GameTooltip:SetText(text);
	end
	if ( InRepairMode() and repairCost and (repairCost > 0) ) then
		GameTooltip:AddLine(REPAIR_COST, "", 1, 1, 1);
		SetTooltipMoney(GameTooltip, repairCost);
		GameTooltip:Show();
	else
		CursorUpdate(self);
	end
end

--MCFFIX READY copied
function MCFPaperDollItemSlotButton_OnLeave (self)
	self:UnregisterEvent("MODIFIER_STATE_CHANGED");
	GameTooltip:Hide();
	ResetCursor();
end

--MCFFIX READY copied
function MCFPaperDollStatTooltip (self)
	if (MCFMOVING_STAT_CATEGORY ~= nil) then return; end
	if ( not self.tooltip ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.tooltip);
	if ( self.tooltip2 ) then
		GameTooltip:AddLine(self.tooltip2, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	GameTooltip:Show();
end

--MCFFIX READY
function MCFFormatPaperDollTooltipStat(name, base, posBuff, negBuff)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..name.." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end
	end
	return text;
end

--MCFFIX READY copied
function MCFPaperDollFrame_CollapseStatCategory(categoryFrame)
	if (not categoryFrame.collapsed) then
		categoryFrame.collapsed = true;
		local index = 1;
		while (_G[categoryFrame:GetName().."Stat"..index]) do 
			_G[categoryFrame:GetName().."Stat"..index]:Hide();
			index = index + 1;
		end
		categoryFrame.CollapsedIcon:Show();
		categoryFrame.ExpandedIcon:Hide();
		categoryFrame:SetHeight(18);
		MCFPaperDollFrame_UpdateStatScrollChildHeight();
		categoryFrame.BgMinimized:Show();
		categoryFrame.BgTop:Hide();
		categoryFrame.BgMiddle:Hide();
		categoryFrame.BgBottom:Hide();
	end
end

--MCFFIX READY copied
function MCFPaperDollFrame_ExpandStatCategory(categoryFrame)
	if (categoryFrame.collapsed) then
		categoryFrame.collapsed = false;
		categoryFrame.CollapsedIcon:Hide();
		categoryFrame.ExpandedIcon:Show();
		MCFPaperDollFrame_UpdateStatCategory(categoryFrame);
		MCFPaperDollFrame_UpdateStatScrollChildHeight();
		categoryFrame.BgMinimized:Hide();
		categoryFrame.BgTop:Show();
		categoryFrame.BgMiddle:Show();
		categoryFrame.BgBottom:Show();
	end
end

--MCFFIX READY copied
function MCFPaperDollFrame_UpdateStatCategory(categoryFrame)
	if (not categoryFrame.Category) then
		categoryFrame:Hide();
		return;
	end
	
	local categoryInfo = MCF_PAPERDOLL_STATCATEGORIES[categoryFrame.Category];
	
	categoryFrame.NameText:SetText(_G["STAT_CATEGORY_"..categoryFrame.Category]);
	
	if (categoryFrame.collapsed) then
		return;
	end
	
	local stat;
	local totalHeight = categoryFrame.NameText:GetHeight() + 10;
	local numVisible = 0;
	if (categoryInfo) then
		local prevStatFrame = nil;
		for index, stat in next, categoryInfo.stats do
			local statInfo = MCF_PAPERDOLL_STATINFO[stat];
			if (statInfo) then
				local statFrame = _G[categoryFrame:GetName().."Stat"..numVisible+1];
				if (not statFrame) then
					statFrame = CreateFrame("FRAME", categoryFrame:GetName().."Stat"..numVisible+1, categoryFrame, "MCFStatFrameTemplate");
					if (prevStatFrame) then
						statFrame:SetPoint("TOPLEFT", prevStatFrame, "BOTTOMLEFT", 0, 0);
						statFrame:SetPoint("TOPRIGHT", prevStatFrame, "BOTTOMRIGHT", 0, 0);
					end
				end
				statFrame:Show();
				-- Reset tooltip script in case it's been changed
				statFrame:SetScript("OnEnter", MCFPaperDollStatTooltip);
				statFrame.tooltip = nil;
				statFrame.tooltip2 = nil;
				statFrame.UpdateTooltip = nil;
				statFrame:SetScript("OnUpdate", nil);
				statInfo.updateFunc(statFrame, MCFCharacterStatsPane.unit);
				if (statFrame:IsShown()) then
					numVisible = numVisible+1;
					totalHeight = totalHeight + statFrame:GetHeight();
					prevStatFrame = statFrame;
					-- Update Tooltip
					if (GameTooltip:GetOwner() == statFrame) then
						statFrame:GetScript("OnEnter")(statFrame);
					end
				end
			end
		end
	end
	
	local i;
	for index=1, numVisible do
		if (index%2 == 0) then
			local statFrame = _G[categoryFrame:GetName().."Stat"..index];
			if (not statFrame.Bg) then
				statFrame.Bg = statFrame:CreateTexture(statFrame:GetName().."Bg", "BACKGROUND");
				statFrame.Bg:SetPoint("LEFT", categoryFrame, "LEFT", 1, 0);
				statFrame.Bg:SetPoint("RIGHT", categoryFrame, "RIGHT", 0, 0);
				statFrame.Bg:SetPoint("TOP");
				statFrame.Bg:SetPoint("BOTTOM");
				statFrame.Bg:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				statFrame.Bg:SetAlpha(0.1);
			end
		end
	end
	
	-- Hide all other stats
	local index = numVisible + 1;
	while (_G[categoryFrame:GetName().."Stat"..index]) do 
		_G[categoryFrame:GetName().."Stat"..index]:Hide();
		index = index + 1;
	end
	
	-- Hack to fix category frames that only have 1 item in them
	if (totalHeight < 44) then
		categoryFrame.BgBottom:SetHeight(totalHeight - 2);
	else
		categoryFrame.BgBottom:SetHeight(46);
	end
	
	categoryFrame:SetHeight(totalHeight);
end

--MCFFIX READY copied
function MCFPaperDollFrame_UpdateStats()
	local index = 1;
	while(_G["MCFCharacterStatsPaneCategory"..index]) do
		MCFPaperDollFrame_UpdateStatCategory(_G["MCFCharacterStatsPaneCategory"..index]);
		index = index + 1;
	end
	MCFPaperDollFrame_UpdateStatScrollChildHeight();
end

--MCFFIX READY copied
function MCFPaperDollFrame_UpdateStatScrollChildHeight()
	local index = 1;
	local totalHeight = 0;
	while(_G["MCFCharacterStatsPaneCategory"..index]) do
		if (_G["MCFCharacterStatsPaneCategory"..index]:IsShown()) then
			totalHeight = totalHeight + _G["MCFCharacterStatsPaneCategory"..index]:GetHeight() + STATCATEGORY_PADDING;
		end
		index = index + 1;
	end
	MCFCharacterStatsPaneScrollChild:SetHeight(totalHeight+10-(MCFCharacterStatsPane.initialOffsetY or 0));
end

--MCFFIX READY copied
function MCFPaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, label));
	if ( isPercentage ) then
		text = format("%.2F%%", text);
	end
	_G[statFrame:GetName().."StatText"]:SetText(text);
end

--MCFFIX READY copied
function MCFPaperDoll_FindCategoryById(id)
	for categoryName, category in pairs(MCF_PAPERDOLL_STATCATEGORIES) do
		if (category.id == id) then
			return categoryName;
		end
	end
	return nil;
end

--MCFFIX READY copied
function MCFPaperDoll_InitStatCategories(defaultOrder, orderCVarName, collapsedCVarName, unit)
	local category;
	local order = defaultOrder;

	-- Load order from cvar
	if (orderCVarName) then
		local orderString = MCF_GetSettings(orderCVarName); --MCFFIX replased GetCVar() with own MCF_GetSettings()
		local savedOrder = {};
		if (orderString and orderString ~= "") then
			for i in gmatch(orderString, "%d+,?") do
				i = gsub(i, ",", "");
				i = tonumber(i);
				if (i) then
					local categoryName = MCFPaperDoll_FindCategoryById(i);
					if (categoryName) then
						tinsert(savedOrder, categoryName);
					end
				end
			end
			 
			-- Validate the saved order
			local valid = true;
			if (#savedOrder == #defaultOrder) then
				for i, category1 in next, defaultOrder do
					local found = false;
					for j, category2 in next, savedOrder do
						if (category1 == category2) then
							found = true;
							break;
						end
					end
					if (not found) then
						valid = false;
						break;
					end
				end
			else
				valid = false;
			end
			
			if (valid) then
				order = savedOrder;
			else
				MCF_SetSettings(orderCVarName, ""); --MCFFIX replaced SetCVar with own function MCF_SetSettings()
			end
		end
	end

	-- Initialize stat frames
	table.wipe(StatCategoryFrames);
	for index=1, #order do
		local frame = _G["MCFCharacterStatsPaneCategory"..index];
		assert(frame);
		tinsert(StatCategoryFrames, frame);
		frame.Category = order[index];
		frame:Show();
		
		-- Expand or collapse
		local categoryInfo = MCF_PAPERDOLL_STATCATEGORIES[frame.Category];
		if (categoryInfo and collapsedCVarName and MCF_GetSettings(collapsedCVarName, categoryInfo.id)) then -- MCFFIX replaced GetCVarBitfield() with own function MCF_GetSettings()
			MCFPaperDollFrame_CollapseStatCategory(frame);
		else
			MCFPaperDollFrame_ExpandStatCategory(frame);
		end
	end
	
	-- Hide unused stat frames
	local index = #order+1;
	while(_G["MCFCharacterStatsPaneCategory"..index]) do
		_G["MCFCharacterStatsPaneCategory"..index]:Hide();
		_G["MCFCharacterStatsPaneCategory"..index].Category = nil;
		index = index + 1;
	end	
	
	-- Set up stats data
	MCFCharacterStatsPane.defaultOrder = defaultOrder;
	MCFCharacterStatsPane.orderCVarName = orderCVarName;
	MCFCharacterStatsPane.collapsedCVarName = collapsedCVarName;
	MCFCharacterStatsPane.unit = unit;
	
	-- Update
	MCFPaperDoll_UpdateCategoryPositions();
	MCFPaperDollFrame_UpdateStats();
end

--MCFFIX READY copied
function MCFPaperDoll_SaveStatCategoryOrder()
	if (not MCFCharacterStatsPane.orderCVarName) then
		return;
	end

	-- Check if the current order matches the default order
	if (MCFCharacterStatsPane.defaultOrder and #MCFCharacterStatsPane.defaultOrder == #StatCategoryFrames) then
		local same = true;
		for index=1, #StatCategoryFrames do
			if (StatCategoryFrames[index].Category ~= MCFCharacterStatsPane.defaultOrder[index]) then
				same = false;
				break;
			end
		end
		if (same) then
			MCF_SetSettings(MCFCharacterStatsPane.orderCVarName, ""); --MCFFIX SetCVar() replaced with own function MCF_SetSettings()
			return;
		end
	end
		
	local cvarString = "";
	for index=1, #StatCategoryFrames do
		if (index ~= #StatCategoryFrames) then
			cvarString = cvarString..MCF_PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id..",";
		else
			cvarString = cvarString..MCF_PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id;
		end
	end
	MCF_SetSettings(MCFCharacterStatsPane.orderCVarName, cvarString); --MCFFIX SetCVar() replaced with own function MCF_SetSettings()
end

--MCFFIX READY copied
function MCFPaperDoll_UpdateCategoryPositions()
	local prevFrame = nil;
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		frame:ClearAllPoints();
	end
	
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		
		-- Indent the one we are currently dragging
		local xOffset = 0;
		if (frame == MCFMOVING_STAT_CATEGORY) then
			xOffset = STATCATEGORY_MOVING_INDENT;
		elseif (prevFrame and prevFrame == MCFMOVING_STAT_CATEGORY) then
			xOffset = -STATCATEGORY_MOVING_INDENT;
		end
		
		if (prevFrame) then
			frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0+xOffset, -STATCATEGORY_PADDING);
		else
			frame:SetPoint("TOPLEFT", 1+xOffset, -STATCATEGORY_PADDING+(MCFCharacterStatsPane.initialOffsetY or 0));
		end
		prevFrame = frame;
	end
end

--MCFFIX READY copied
function MCFPaperDoll_MoveCategoryUp(self)
	for index = 2, #StatCategoryFrames do
		if (StatCategoryFrames[index] == self) then
			tremove(StatCategoryFrames, index);
			tinsert(StatCategoryFrames, index-1, self);
			break;
		end
	end
	
	MCFPaperDoll_UpdateCategoryPositions();
	MCFPaperDoll_SaveStatCategoryOrder();
end

--MCFFIX READY copied
function MCFPaperDoll_MoveCategoryDown(self)
	for index = 1, #StatCategoryFrames-1 do
		if (StatCategoryFrames[index] == self) then
			tremove(StatCategoryFrames, index);
			tinsert(StatCategoryFrames, index+1, self);
			break;
		end
	end
	MCFPaperDoll_UpdateCategoryPositions();
	MCFPaperDoll_SaveStatCategoryOrder();
end

--MCFFIX READY copied
function MCFPaperDollStatCategory_OnDragUpdate(self)
	local _, cursorY = GetCursorPosition();
	cursorY = cursorY*GetScreenHeightScale();
	
	local myIndex = nil;
	local insertIndex = nil;
	local closestPos;
	
	-- Find position that will put the dragged frame closest to the cursor
	for index=1, #StatCategoryFrames+1 do -- +1 is to check the very last position at the bottom
		if (StatCategoryFrames[index] == self) then
			myIndex = index;
		end

		local frameY;
		if (index <= #StatCategoryFrames) then
			frameY = StatCategoryFrames[index]:GetTop();
		else
			frameY = StatCategoryFrames[#StatCategoryFrames]:GetBottom();
		end
		frameY = frameY - 8;  -- compensate for height of the toolbar area
		if (myIndex and index > myIndex) then
			-- Remove height of the dragged frame, since it's going to be moved out of it's current position
			frameY = frameY + self:GetHeight();
		end
		if (not closestPos or abs(cursorY - frameY)<closestPos) then
			insertIndex = index;
			closestPos = abs(cursorY-frameY);
		end
	end
	
	if (insertIndex > myIndex) then
		insertIndex = insertIndex - 1;
	end
	
	if ( myIndex ~= insertIndex) then
		tremove(StatCategoryFrames, myIndex);
		tinsert(StatCategoryFrames, insertIndex, self);
		MCFPaperDoll_UpdateCategoryPositions();
	end
end

--MCFFIX READY copied
function MCFPaperDollStatCategory_OnDragStart(self)
	MCFMOVING_STAT_CATEGORY = self;
	MCFPaperDoll_UpdateCategoryPositions();
	GameTooltip:Hide();
	self:SetScript("OnUpdate", MCFPaperDollStatCategory_OnDragUpdate);
	local i;
	local frame;
	for i, frame in next, StatCategoryFrames do
		if (frame ~= self) then
			frame:SetAlpha(0.6);
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollStatCategory_OnDragStop(self)
	MCFMOVING_STAT_CATEGORY = nil;
	MCFPaperDoll_UpdateCategoryPositions();
	self:SetScript("OnUpdate", nil);
	local i;
	local frame;
	for i, frame in next, StatCategoryFrames do
		if (frame ~= self) then
			frame:SetAlpha(1);
		end
	end
	MCFPaperDoll_SaveStatCategoryOrder();
end





--MCFFIXWORKINPROGRESS (needs complete reworking (changing to modern flyout system))
function MCFPaperDollFrameItemFlyoutButton_OnClick (self)
	print("Function MCFPaperDollFrameItemFlyoutButton_OnClick just tried to run.");
	
	if ( self.location == PDFITEMFLYOUT_IGNORESLOT_LOCATION ) then
		local slot = MCFEquipmentFlyoutFrame.button;
		--[[ EquipmentManagerIgnoreSlotForSave(slot:GetID()); ]] --MCFFIX replaced with modern version
		C_EquipmentSet.IgnoreSlotForSave(slot:GetID());
		slot.ignored = true;
		MCFPaperDollItemSlotButton_Update(slot);
		EquipmentFlyout_Show(slot);
		MCFPaperDollEquipmentManagerPaneSaveSet:Enable();
	elseif ( self.location == PDFITEMFLYOUT_UNIGNORESLOT_LOCATION ) then
		local slot = MCFEquipmentFlyoutFrame.button;
		--[[ EquipmentManagerUnignoreSlotForSave(slot:GetID()); ]] --MCFFIX replaced with modern version
		C_EquipmentSet.UnignoreSlotForSave(slot:GetID());
		slot.ignored = nil;
		MCFPaperDollItemSlotButton_Update(slot);
		EquipmentFlyout_Show(slot);
		MCFPaperDollEquipmentManagerPaneSaveSet:Enable();
	elseif ( self.location == PDFITEMFLYOUT_PLACEINBAGS_LOCATION ) then
		if ( UnitAffectingCombat("player") and not INVSLOTS_EQUIPABLE_IN_COMBAT[MCFEquipmentFlyoutFrame.button:GetID()] ) then
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
			return;
		end
		local action = EquipmentManager_UnequipItemInSlot(MCFEquipmentFlyoutFrame.button:GetID());
		EquipmentManager_RunAction(action);
	elseif ( self.location ) then
		if ( UnitAffectingCombat("player") and not INVSLOTS_EQUIPABLE_IN_COMBAT[MCFEquipmentFlyoutFrame.button:GetID()] ) then
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
			return;
		end
		local action = EquipmentManager_EquipItemByLocation(self.location, self.id);
		EquipmentManager_RunAction(action);
	end
	
end

--MCFFIX READY
function MCFPaperDollFrameItemFlyout_GetItems(paperDollItemSlot, itemTable)
	GetInventoryItemsForSlot(paperDollItemSlot, itemTable);
end

--MCFFIXWORKINPROGRESS
function MCFPaperDollFrameItemFlyout_PostGetItems(itemSlotButton, itemDisplayTable, numItems)
	if (MCFPaperDollEquipmentManagerPane:IsShown() and (MCFPaperDollEquipmentManagerPane.selectedSetName or MCFGearManagerDialogPopup:IsShown())) then 
		if ( not itemSlotButton.ignored ) then
			tinsert(itemDisplayTable, 1, PDFITEMFLYOUT_IGNORESLOT_LOCATION);
		else
			tinsert(itemDisplayTable, 1, PDFITEMFLYOUT_UNIGNORESLOT_LOCATION);
		end
		numItems = numItems + 1;
	end
	if ( itemSlotButton.hasItem ) then
		tinsert(itemDisplayTable, 1, PDFITEMFLYOUT_PLACEINBAGS_LOCATION);
		numItems = numItems + 1;
	end
	return numItems;
end

-- copied
function MCFGearSetDeleteButton_OnClick(self)
	local dialog = StaticPopup_Show("CONFIRM_DELETE_EQUIPMENT_SET", self:GetParent().setID);
	if ( dialog ) then
		dialog.data = self:GetParent().setID;
	else
		UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
	end
end

--MCFFIXWORKINPROGRESS copied
function MCFGearSetButton_OnClick (self, button, down)
	if ( self.setID ) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);		-- inappropriately named, but a good sound.
		MCFPaperDollEquipmentManagerPane.selectedSetName = self.name;
		MCFPaperDollEquipmentManagerPane.selectedSetID = self.setID;
		-- mark the ignored slots
		MCFPaperDollFrame_ClearIgnoredSlots();
		MCFPaperDollFrame_IgnoreSlotsForSet(self.setID);
		MCFPaperDollEquipmentManagerPane_Update();
		MCFGearManagerDialogPopup:Hide();
	else
		-- This is the "New Set" button
		MCFGearManagerDialogPopup:Show();
		MCFPaperDollEquipmentManagerPane.setID = nil;
		MCFPaperDollEquipmentManagerPane.selectedSetName = nil;
		MCFPaperDollEquipmentManagerPane.selectedSetID = nil;
		MCFPaperDollFrame_ClearIgnoredSlots();
		MCFPaperDollEquipmentManagerPane_Update();
		-- Ignore shirt and tabard by default
		MCFPaperDollFrame_IgnoreSlot(4);
		MCFPaperDollFrame_IgnoreSlot(19);
	end
	StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET");
	StaticPopup_Hide("MCF_CONFIRM_OVERWRITE_EQUIPMENT_SET");
end

--MCFFIXWORKINPROGRESS need to test :SetEquipmentSet(name) if it uses only names or can use IDs - copied
function MCFGearSetButton_OnEnter (self)
	if ( self.name and self.name ~= "" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		GameTooltip:SetEquipmentSet(self.name);
	end
end

--MCFFIX
--Commented out these constants because they exist in the game (with another values)
--[[
NUM_GEARSET_ICONS_SHOWN = 15; --80
NUM_GEARSET_ICONS_PER_ROW = 5; --10
NUM_GEARSET_ICON_ROWS = 3; --8
GEARSET_ICON_ROW_HEIGHT = 36;
]]
--copied
local MCFEM_ICON_FILENAMES = {};

--MCFFIX READY (need to test built-in template GearSetPopupButtonTemplate) - copied
function MCFGearManagerDialogPopup_OnLoad (self)
	self.buttons = {};
	
	local rows = 0;
	
	local button = CreateFrame("CheckButton", "MCFGearManagerDialogPopupButton1", MCFGearManagerDialogPopup, "MCFGearSetPopupButtonTemplate");
	button:SetPoint("TOPLEFT", 24, -85);
	button:SetID(1);
	tinsert(self.buttons, button);
	
	local lastPos;
	for i = 2, NUM_GEARSET_ICONS_SHOWN do
		button = CreateFrame("CheckButton", "MCFGearManagerDialogPopupButton" .. i, MCFGearManagerDialogPopup, "MCFGearSetPopupButtonTemplate");
		button:SetID(i);
		
		lastPos = (i - 1) / NUM_GEARSET_ICONS_PER_ROW;
		if ( lastPos == math.floor(lastPos) ) then
			button:SetPoint("TOPLEFT", self.buttons[i-NUM_GEARSET_ICONS_PER_ROW], "BOTTOMLEFT", 0, -8);
		else
			button:SetPoint("TOPLEFT", self.buttons[i-1], "TOPRIGHT", 10, 0);
		end
		tinsert(self.buttons, button);
	end

	self.SetSelection = function(self, fTexture, Value)
		if(fTexture) then
			self.selectedTexture = Value;
			self.selectedIcon = nil;
		else
			self.selectedTexture = nil;
			self.selectedIcon = Value;
		end
	end
end

--MCFFIX ready - copied
function MCFGearManagerDialogPopup_OnShow (self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
	self.name = nil;
	self.isEdit = false;
	MCFRecalculateGearManagerDialogPopup();
end

--MCFFIXWORKINPROGRESS - copied
function MCFGearManagerDialogPopup_OnHide (self)
	MCFGearManagerDialogPopup.name = nil;
	MCFGearManagerDialogPopup:SetSelection(true, nil);
	MCFGearManagerDialogPopupEditBox:SetText("");
	if (not MCFPaperDollEquipmentManagerPane.selectedSetName) then
		MCFPaperDollFrame_ClearIgnoredSlots();
	end
	MCFEM_ICON_FILENAMES = nil;
	collectgarbage();
end

--MCFFIX ready (probably) copied
function MCFRecalculateGearManagerDialogPopup(setName, iconTexture)
	local popup = MCFGearManagerDialogPopup;
	if ( setName and setName ~= "") then
		MCFGearManagerDialogPopupEditBox:SetText(setName);
		MCFGearManagerDialogPopupEditBox:HighlightText(0);
	else
		MCFGearManagerDialogPopupEditBox:SetText("");
	end
	
	if (iconTexture) then
		popup:SetSelection(true, iconTexture);
	else
		popup:SetSelection(false, 1);
	end
	
	--[[ 
	Scroll and ensure that any selected equipment shows up in the list.
	When we first press "save", we want to make sure any selected equipment set shows up in the list, so that
	the user can just make his changes and press Okay to overwrite.
	To do this, we need to find the current set (by icon) and move the offset of the GearManagerDialogPopup
	to display it. Issue ID: 171220
	]]
	MCFRefreshEquipmentSetIconInfo();
	local totalItems = #MCFEM_ICON_FILENAMES;
	local texture, _;
	if(popup.selectedTexture) then
		local foundIndex = nil;
		for index=1, totalItems do
			texture = MCFGetEquipmentSetIconInfo(index);
			if ( texture == popup.selectedTexture ) then
				foundIndex = index;
				break;
			end
		end
		if (foundIndex == nil) then

			foundIndex = 1;

		end
		-- now make it so we always display at least NUM_GEARSET_ICON_ROWS of data
		local offsetnumIcons = floor((totalItems-1)/NUM_GEARSET_ICONS_PER_ROW);
		local offset = floor((foundIndex-1) / NUM_GEARSET_ICONS_PER_ROW);
		offset = offset + min((NUM_GEARSET_ICON_ROWS-1), offsetnumIcons-offset) - (NUM_GEARSET_ICON_ROWS-1);
		if(foundIndex<=NUM_GEARSET_ICONS_SHOWN) then
			offset = 0;			--Equipment all shows at the same place.
		end
		FauxScrollFrame_OnVerticalScroll(MCFGearManagerDialogPopupScrollFrame, offset*GEARSET_ICON_ROW_HEIGHT, GEARSET_ICON_ROW_HEIGHT, nil);
	else
		FauxScrollFrame_OnVerticalScroll(MCFGearManagerDialogPopupScrollFrame, 0, GEARSET_ICON_ROW_HEIGHT, nil);
	end
	MCFGearManagerDialogPopup_Update();
end

--MCFFIX ready - copied
--[[
RefreshEquipmentSetIconInfo() counts how many uniquely textured inventory items the player has equipped. 
]]
function MCFRefreshEquipmentSetIconInfo ()
	MCFEM_ICON_FILENAMES = {};
	--[[ MCFEM_ICON_FILENAMES[1] = "INV_MISC_QUESTIONMARK"; ]] --MCFFIX replaced with modern version
	MCFEM_ICON_FILENAMES[1] = 134400;
	local index = 2;

	for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		local itemTexture = GetInventoryItemTexture("player", i); --MCFFIX returns number instead of texture path now
		if ( itemTexture ) then
			--[[ MCFEM_ICON_FILENAMES[index] = gsub( strupper(itemTexture), "INTERFACE\\ICONS\\", "" ); ]] --MCFFIX replaced with modern version
			MCFEM_ICON_FILENAMES[index] = itemTexture;
			if(MCFEM_ICON_FILENAMES[index]) then
				index = index + 1;
				--[[
				Currently checks all for duplicates, even though only rings, trinkets, and weapons may be duplicated. 
				This version is clean and maintainable.
				]]
				for j=INVSLOT_FIRST_EQUIPPED, (index-1) do
					if(MCFEM_ICON_FILENAMES[index] == MCFEM_ICON_FILENAMES[j]) then
						MCFEM_ICON_FILENAMES[index] = nil;
						index = index - 1;
						break;
					end
				end
			end
		end
	end
	GetMacroItemIcons(MCFEM_ICON_FILENAMES);
	GetMacroIcons(MCFEM_ICON_FILENAMES);
end

--MCFFIX READY copied
--[[ 
GetEquipmentSetIconInfo(index) determines the texture and real index of a regular index
	Input: 	index = index into a list of equipped items followed by the macro items. Only tricky part is the equipped items list keeps changing.
	Output: the associated texture for the item, and a index relative to the join point between the lists, i.e. negative for the equipped items
			and positive for the macro items//
]]
function MCFGetEquipmentSetIconInfo(index)
	return MCFEM_ICON_FILENAMES[index];

end

--MCFFIX READY copied
function MCFGearManagerDialogPopup_Update ()
	MCFRefreshEquipmentSetIconInfo();

	local popup = MCFGearManagerDialogPopup;
	local buttons = popup.buttons;
	local offset = FauxScrollFrame_GetOffset(MCFGearManagerDialogPopupScrollFrame) or 0;
	local button;	
	-- Icon list
	local texture, index, button, realIndex, _;
	for i=1, NUM_GEARSET_ICONS_SHOWN do
		local button = buttons[i];
		index = (offset * NUM_GEARSET_ICONS_PER_ROW) + i;
		if ( index <= #MCFEM_ICON_FILENAMES ) then
			texture = MCFGetEquipmentSetIconInfo(index);
			-- button.name:SetText(index); --dcw
			--[[ button.icon:SetTexture("INTERFACE\\ICONS\\"..texture); ]] --MCFFIX replaced with modern version
			button.icon:SetTexture(texture);
			button:Show();
			if ( index == popup.selectedIcon ) then
				button:SetChecked(1);
			elseif ( texture == popup.selectedTexture ) then
				button:SetChecked(1);
				popup:SetSelection(false, index);
			else
				button:SetChecked(nil);
			end
		else
			button.icon:SetTexture("");
			button:Hide();
		end
		
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(MCFGearManagerDialogPopupScrollFrame, ceil(#MCFEM_ICON_FILENAMES / NUM_GEARSET_ICONS_PER_ROW) , NUM_GEARSET_ICON_ROWS, GEARSET_ICON_ROW_HEIGHT );
end

--MCFFIX READY copied
function MCFGearManagerDialogPopupOkay_Update ()
	local popup = MCFGearManagerDialogPopup;
	local button = MCFGearManagerDialogPopupOkay;
	
	if ( popup.selectedIcon and popup.name ) then
		button:Enable();
	else
		button:Disable();
	end
end

--MCFFIXWORKINPROGRESS copied
function MCFGearManagerDialogPopupOkay_OnClick (self, button, pushed)
	local popup = MCFGearManagerDialogPopup;

	local icon = MCFGetEquipmentSetIconInfo(popup.selectedIcon);
	local setID = C_EquipmentSet.GetEquipmentSetID(popup.name);

	if ( setID ) then
		local dialog = StaticPopup_Show("MCF_CONFIRM_OVERWRITE_EQUIPMENT_SET", popup.name);
		if ( dialog ) then
			dialog.data = setID;
			dialog.selectedIcon = icon;
		else
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
		end
		return;
	elseif ( C_EquipmentSet.GetNumEquipmentSets() >= MAX_EQUIPMENT_SETS_PER_PLAYER ) then
		UIErrorsFrame:AddMessage(EQUIPMENT_SETS_TOO_MANY, 1.0, 0.1, 0.1, 1.0);
		return;
	end
	C_EquipmentSet.CreateEquipmentSet(popup.name, icon);
	popup:Hide();
end

--MCFFIX READY copied
function MCFGearManagerDialogPopupCancel_OnClick ()
	MCFGearManagerDialogPopup:Hide();
end

--MCFFIX ready - copied
function MCFGearSetPopupButton_OnClick (self, button)
	local popup = MCFGearManagerDialogPopup;
	local offset = FauxScrollFrame_GetOffset(MCFGearManagerDialogPopupScrollFrame) or 0;
	popup.selectedIcon = (offset * NUM_GEARSET_ICONS_PER_ROW) + self:GetID();
 	popup.selectedTexture = nil;
	MCFGearManagerDialogPopup_Update();
	MCFGearManagerDialogPopupOkay_Update();
end

--MCFFIX ready (needs rework) copied
function MCFPaperDollEquipmentManagerPane_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = MCFPaperDollEquipmentManagerPane_Update;	
	HybridScrollFrame_CreateButtons(self, "MCFGearSetButtonTemplate", 2, -(self.EquipSet:GetHeight()+4));
	
	self:RegisterEvent("EQUIPMENT_SWAP_FINISHED");
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("BAG_UPDATE");
end

--MCFFIX ready copied
function MCFPaperDollEquipmentManagerPane_OnUpdate(self)
	for i = 1, #self.buttons do
		local button = self.buttons[i];
		if (button:IsMouseOver()) then
			if (button.name) then
				button.DeleteButton:Show();
				button.EditButton:Show();
			else
				button.DeleteButton:Hide();
				button.EditButton:Hide();
			end
			button.HighlightBar:Show();
		else
			button.DeleteButton:Hide();
			button.EditButton:Hide();
			button.HighlightBar:Hide();
		end
	end
	if (self.queuedUpdate) then
		MCFPaperDollEquipmentManagerPane_Update();
		self.queuedUpdate = false;
	end
end

--MCFFIXWORKINPROGRESS copied
function MCFPaperDollEquipmentManagerPane_OnShow(self)
	HybridScrollFrame_CreateButtons(MCFPaperDollEquipmentManagerPane, "MCFGearSetButtonTemplate");
	MCFPaperDollEquipmentManagerPane_Update();
	--[[ EquipmentFlyoutPopoutButton_ShowAll(); ]]
end

--MCFFIX READY copied
function MCFPaperDollEquipmentManagerPane_OnEvent(self, event, ...)

	if ( event == "EQUIPMENT_SWAP_FINISHED" ) then
		local completed, setID = ...;
		if ( completed ) then
			PlaySound(SOUNDKIT.PUT_DOWN_SMALL_CHAIN); -- plays the equip sound for plate mail
			if (self:IsShown()) then
				self.selectedSetID = setID;
				MCFPaperDollEquipmentManagerPane_Update();
			end
		end
	end


	if (self:IsShown()) then
		if ( event == "EQUIPMENT_SETS_CHANGED" ) then
			MCFPaperDollEquipmentManagerPane_Update();
		elseif ( event == "PLAYER_EQUIPMENT_CHANGED" or event == "BAG_UPDATE" ) then
			MCFPaperDollEquipmentManagerPane_Update();
			-- This queues the update to only happen once at the end of the frame
			self.queuedUpdate = true;
		end
	end
end

--MCFFIXWORKINPROGRESS copied
function MCFPaperDollEquipmentManagerPane_OnHide(self)
	--[[ EquipmentFlyoutPopoutButton_HideAll(); ]]
	MCFPaperDollFrame_ClearIgnoredSlots();
	MCFGearManagerDialogPopup:Hide();
	StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET");
	StaticPopup_Hide("MCF_CONFIRM_OVERWRITE_EQUIPMENT_SET");
end

--MCFFIX ready copied
function MCFPaperDollEquipmentManagerPane_Update()
	--MCFFIX replaced with a few lines below
	--[[ local _, setID, isEquipped = GetEquipmentSetInfoByName(MCFPaperDollEquipmentManagerPane.selectedSetName or ""); ]]
	local _, _, setID, isEquipped = MCF_GetEquipmentSetInfoByName(MCFPaperDollEquipmentManagerPane.selectedSetName or "");
	if (setID) then
		if (isEquipped) then
			MCFPaperDollEquipmentManagerPaneSaveSet:Disable();
			MCFPaperDollEquipmentManagerPaneEquipSet:Disable();
		else
			MCFPaperDollEquipmentManagerPaneSaveSet:Enable();
			MCFPaperDollEquipmentManagerPaneEquipSet:Enable();
		end
	else
		MCFPaperDollEquipmentManagerPaneSaveSet:Disable();
		MCFPaperDollEquipmentManagerPaneEquipSet:Disable();
		
		-- Clear selected equipment set if it doesn't exist
		if (MCFPaperDollEquipmentManagerPane.selectedSetID) then
			MCFPaperDollEquipmentManagerPane.selectedSetID = nil;
			MCFPaperDollFrame_ClearIgnoredSlots();
		end
	end

	local numSets = C_EquipmentSet.GetNumEquipmentSets();
	local numRows = numSets;
	if (numSets < MAX_EQUIPMENT_SETS_PER_PLAYER) then
		numRows = numRows + 1;  -- "Add New Set" button
	end

	HybridScrollFrame_Update(MCFPaperDollEquipmentManagerPane, numRows * MCF_EQUIPMENTSET_BUTTON_HEIGHT + MCFPaperDollEquipmentManagerPaneEquipSet:GetHeight() + 20 , MCFPaperDollEquipmentManagerPane:GetHeight());
	
	local scrollOffset = HybridScrollFrame_GetOffset(MCFPaperDollEquipmentManagerPane);
	local buttons = MCFPaperDollEquipmentManagerPane.buttons;
	local selectedSetID = MCFPaperDollEquipmentManagerPane.selectedSetID;
	local name, icon, button, numLost;
	for i = 1, #buttons do
		if (i+scrollOffset <= numRows) then
			button = buttons[i];
			buttons[i]:Show();
			button:Enable();
			button.setID = nil;
			
			if (i+scrollOffset <= numSets) then
				-- Normal equipment set button
				local sets = C_EquipmentSet.GetEquipmentSetIDs();
				name, icon, setID, isEquipped, _, _, _, numLost, _ = C_EquipmentSet.GetEquipmentSetInfo(sets[i+scrollOffset]);
				button.name = name;
				button.setID = setID;
				button.text:SetText(name);
				if (numLost > 0) then
					button.text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				else
					button.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				end
				if (icon) then
					button.icon:SetTexture(icon);
				else
					button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
				end
								
				if (selectedSetID and button.setID == selectedSetID) then
					button.SelectedBar:Show();
				else
					button.SelectedBar:Hide();
				end
					
				if (isEquipped) then
					button.Check:Show();
				else
					button.Check:Hide();
				end
				button.icon:SetSize(36, 36);
				button.icon:SetPoint("LEFT", 4, 0);
			else
				-- This is the Add New button
				button.name = nil;
				button.text:SetText(PAPERDOLL_NEWEQUIPMENTSET);
				button.text:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				button.icon:SetTexture("Interface\\PaperDollInfoFrame\\Character-Plus");
				button.icon:SetSize(30, 30);
				button.icon:SetPoint("LEFT", 7, 0);
				button.Check:Hide();
				button.SelectedBar:Hide();
			end
			
			if ((i+scrollOffset) == 1) then
				buttons[i].BgTop:Show();
				buttons[i].BgMiddle:SetPoint("TOP", buttons[i].BgTop, "BOTTOM");
			else
				buttons[i].BgTop:Hide();
				buttons[i].BgMiddle:SetPoint("TOP");
			end
			
			if ((i+scrollOffset) == numRows) then
				buttons[i].BgBottom:Show();
				buttons[i].BgMiddle:SetPoint("BOTTOM", buttons[i].BgBottom, "TOP");
			else
				buttons[i].BgBottom:Hide();
				buttons[i].BgMiddle:SetPoint("BOTTOM");
			end
			
			if ((i+scrollOffset)%2 == 0) then
				buttons[i].Stripe:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				buttons[i].Stripe:SetAlpha(0.1);
				buttons[i].Stripe:Show();
			else
				buttons[i].Stripe:Hide();
			end
		else
			buttons[i]:Hide();
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollEquipmentManagerPaneSaveSet_OnClick (self)
	local selectedSetName = MCFPaperDollEquipmentManagerPane.selectedSetName;
	local selectedSetID = MCFPaperDollEquipmentManagerPane.selectedSetID;
	if ( selectedSetID ) then
		local dialog = StaticPopup_Show("CONFIRM_SAVE_EQUIPMENT_SET", selectedSetName);
		if ( dialog ) then
			dialog.data = selectedSetID;
		else
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollEquipmentManagerPaneEquipSet_OnClick (self)
	local selectedSetName = MCFPaperDollEquipmentManagerPane.selectedSetName;
	if ( selectedSetName and selectedSetName ~= "") then
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);	-- inappropriately named, but a good sound.
		--EquipmentManager_EquipSet(selectedSetName); --MCFFIX replaced with modern version
		C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID(selectedSetName));
	end
end

--MCFFIX READY copied
function MCFPaperDollTitlesPane_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = MCFPaperDollTitlesPane_UpdateScrollFrame;	
	HybridScrollFrame_CreateButtons(self, "MCFPlayerTitleButtonTemplate", 2, -4);
end

--MCFFIX READY copied
function MCFPaperDollTitlesPane_UpdateScrollFrame()
	local buttons = MCFPaperDollTitlesPane.buttons;
	local playerTitles = MCFPaperDollTitlesPane.titles;
	local numButtons = #buttons;
	local scrollOffset = HybridScrollFrame_GetOffset(MCFPaperDollTitlesPane);
	local playerTitle;
	for i = 1, numButtons do
		playerTitle = playerTitles[i + scrollOffset];
		if ( playerTitle ) then
			buttons[i]:Show();
			buttons[i].text:SetText(playerTitle.name);
			buttons[i].titleId = playerTitle.id;
			if ( MCFPaperDollTitlesPane.selected == playerTitle.id ) then
				buttons[i].Check:Show();
				buttons[i].SelectedBar:Show();
			else
				buttons[i].Check:Hide();
				buttons[i].SelectedBar:Hide();
			end
			
			if ((i+scrollOffset) == 1) then
				buttons[i].BgTop:Show();
				buttons[i].BgMiddle:SetPoint("TOP", buttons[i].BgTop, "BOTTOM");
			else
				buttons[i].BgTop:Hide();
				buttons[i].BgMiddle:SetPoint("TOP");
			end
			
			if ((i+scrollOffset) == #playerTitles) then
				buttons[i].BgBottom:Show();
				buttons[i].BgMiddle:SetPoint("BOTTOM", buttons[i].BgBottom, "TOP");
			else
				buttons[i].BgBottom:Hide();
				buttons[i].BgMiddle:SetPoint("BOTTOM");
			end
			
			if ((i+scrollOffset)%2 == 0) then
				buttons[i].Stripe:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				buttons[i].Stripe:SetAlpha(0.1);
				buttons[i].Stripe:Show();
			else
				buttons[i].Stripe:Hide();
			end
		else
			buttons[i]:Hide();
		end
	end
end

-- copied
local function MCFPlayerTitleSort(a, b) return a.name < b.name; end 

--MCFFIX READY copied
function MCFPaperDollTitlesPane_Update()
	local playerTitles = { };
	local currentTitle = GetCurrentTitle();		
	local titleCount = 1;
	local buttons = MCFPaperDollTitlesPane.buttons;
	local fontstringText = buttons[1].text;
	local fontstringWidth;			
	local playerTitle = false;
	local tempName = 0;
	MCFPaperDollTitlesPane.selected = -1;
	playerTitles[1] = { };
	-- reserving space for None so it doesn't get sorted out of the top position
	playerTitles[1].name = "       ";
	playerTitles[1].id = -1;		
	for i = 1, GetNumTitles() do
		if ( IsTitleKnown(i) ~= false ) then		
			tempName, playerTitle = GetTitleName(i);
			if ( tempName and playerTitle ) then
				titleCount = titleCount + 1;
				playerTitles[titleCount] = playerTitles[titleCount] or { };
				playerTitles[titleCount].name = strtrim(tempName);
				playerTitles[titleCount].id = i;
				if ( i == currentTitle ) then
					MCFPaperDollTitlesPane.selected = i;
				end					
				fontstringText:SetText(playerTitles[titleCount].name);
			end
		end
	end

	table.sort(playerTitles, MCFPlayerTitleSort);
	playerTitles[1].name = PLAYER_TITLE_NONE;
	MCFPaperDollTitlesPane.titles = playerTitles;	

	HybridScrollFrame_Update(MCFPaperDollTitlesPane, titleCount * MCF_PLAYER_TITLE_HEIGHT + 20 , MCFPaperDollTitlesPane:GetHeight());
	MCFPaperDollTitlesPane_UpdateScrollFrame();
end

--MCFFIX READY copied
function MCFPlayerTitleButton_OnClick(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	SetCurrentTitle(self.titleId);
end

--MCFFIX READY copied
function MCFSetTitleByName(name)
	name = strlower(name);
	for i = 1, GetNumTitles() do
		if ( IsTitleKnown(i) ~= false ) then
			local title = GetTitleName(i);
			title = strlower(strtrim(title));
			if(title:find(name) == 1) then
				SetCurrentTitle(i);
				return true;
			end
		end
	end
	return false;
end

--MCFFIX READY copied
function MCFSetPaperDollBackground(model, unit)
	local race, fileName = UnitRace(unit);
	local texture = DressUpTexturePath(fileName);
	--MCFFIX hack to make troll's texture actual troll's instead of orc's. Need to check other races (like gnomes). Files are in the game.
	if ( fileName == "Troll" ) then
		texture = "Interface\\DressUpFrame\\DressUpBackground-Troll"
	end

	model.BackgroundTopLeft:SetTexture(texture..1);
	model.BackgroundTopRight:SetTexture(texture..2);
	model.BackgroundBotLeft:SetTexture(texture..3);
	model.BackgroundBotRight:SetTexture(texture..4);
	
	-- HACK - Adjust background brightness for different races
	if ( strupper(fileName) == "BLOODELF") then
		model.BackgroundOverlay:SetAlpha(0.8);
	elseif (strupper(fileName) == "NIGHTELF") then
		model.BackgroundOverlay:SetAlpha(0.6);
	elseif ( strupper(fileName) == "SCOURGE") then
		model.BackgroundOverlay:SetAlpha(0.3);
	elseif ( strupper(fileName) == "TROLL" or strupper(fileName) == "ORC") then
		model.BackgroundOverlay:SetAlpha(0.6);
	elseif ( strupper(fileName) == "WORGEN" ) then
		model.BackgroundOverlay:SetAlpha(0.5);
	elseif ( strupper(fileName) == "GOBLIN" ) then
		model.BackgroundOverlay:SetAlpha(0.6);
	else
		model.BackgroundOverlay:SetAlpha(0.7);
	end
end

--MCFFIX READY copied
function MCFPaperDollBgDesaturate(on)
	MCFCharacterModelFrameBackgroundTopLeft:SetDesaturated(on);
	MCFCharacterModelFrameBackgroundTopRight:SetDesaturated(on);
	MCFCharacterModelFrameBackgroundBotLeft:SetDesaturated(on);
	MCFCharacterModelFrameBackgroundBotRight:SetDesaturated(on);
end

--MCFFIX READY copied
function MCFPaperDollFrame_UpdateSidebarTabs()
	for i = 1, #MCFPAPERDOLL_SIDEBARS do
		local tab = _G["MCFPaperDollSidebarTab"..i];
		if (tab) then
			if (_G[MCFPAPERDOLL_SIDEBARS[i].frame]:IsShown()) then
				tab.Hider:Hide();
				tab.Highlight:Hide();
				tab.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.78906250, 0.95703125);
			else
				tab.Hider:Show();
				tab.Highlight:Show();
				tab.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.61328125, 0.78125000);
			end
		end
	end
end

--MCFFIX READY copied
function MCFPaperDollFrame_SetSidebar(self, index)
	if (not _G[MCFPAPERDOLL_SIDEBARS[index].frame]:IsShown()) then
		for i = 1, #MCFPAPERDOLL_SIDEBARS do
			_G[MCFPAPERDOLL_SIDEBARS[i].frame]:Hide();
		end
		_G[MCFPAPERDOLL_SIDEBARS[index].frame]:Show();
		MCFPaperDollFrame.currentSideBar = _G[MCFPAPERDOLL_SIDEBARS[index].frame];
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		MCFPaperDollFrame_UpdateSidebarTabs();
	end
end
