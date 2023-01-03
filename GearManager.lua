----------------------------------------------------------------------------------
-------------------------- EQUIPMENT MANAGER FUNCTIONS ---------------------------
----------------------------------------------------------------------------------

local STRIPE_COLOR = {r=0.9, g=0.9, b=1};
local itemSlotButtons = {
    CharacterHeadSlot,          -- 1
    CharacterNeckSlot,          -- 2
    CharacterShoulderSlot,      -- 3
    CharacterShirtSlot,         -- 4
    CharacterChestSlot,         -- 5
    CharacterWaistSlot,         -- 6
    CharacterLegsSlot,          -- 7
    CharacterFeetSlot,          -- 8
    CharacterWristSlot,         -- 9
    CharacterHandsSlot,         -- 10
    CharacterFinger0Slot,       -- 11
    CharacterFinger1Slot,       -- 12
    CharacterTrinket0Slot,      -- 13
    CharacterTrinket1Slot,      -- 14
    CharacterBackSlot,          -- 15
    CharacterMainHandSlot,      -- 16
    CharacterSecondaryHandSlot, -- 17
    CharacterRangedSlot,        -- 18
    CharacterTabardSlot         -- 19
};

-- Create EquipmentManager pane scrollbar frame
function MCF_CreateEquipmentManagerPane(frame)
    frame.TitlesPane = CreateFrame("ScrollFrame", "PaperDollEquipmentManagerPane", frame, "MCF-PaperDollEquipmentManagerPaneTemplate");
    frame.DialogPopup = CreateFrame("Frame", "MCF_GearManagerDialogPopup", frame, "MCF-GearManagerDialogPopupTemplate");
    MCF_GearManagerDialogPopup_OnLoad(MCF_GearManagerDialogPopup);
end

-- PaperDollEquipmentManagerPane scripts
function MCF_PaperDollEquipmentManagerPane_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = MCF_PaperDollEquipmentManagerPane_Update;	
	HybridScrollFrame_CreateButtons(self, "MCF-GearSetButtonTemplate", 2, -(self.EquipSet:GetHeight()+4));
	
	self:RegisterEvent("EQUIPMENT_SWAP_FINISHED");
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("BAG_UPDATE");
end
-- NOT READY
function MCF_PaperDollEquipmentManagerPane_OnShow(self)
	HybridScrollFrame_CreateButtons(PaperDollEquipmentManagerPane, "MCF-GearSetButtonTemplate");
	MCF_PaperDollEquipmentManagerPane_Update();

    C_EquipmentSet.ClearIgnoredSlotsForSave(); -- added this line because default one has it

    PaperDollFrameItemPopoutButton_ShowAll();
end
-- NOT READY
function MCF_PaperDollEquipmentManagerPane_OnHide(self)
	PaperDollFrameItemPopoutButton_HideAll();

	MCF_PaperDollFrame_ClearIgnoredSlots();

	MCF_GearManagerDialogPopup:Hide();
	StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET");
	StaticPopup_Hide("MCF_CONFIRM_OVERWRITE_EQUIPMENT_SET");
end
function MCF_PaperDollEquipmentManagerPane_OnEvent(self, event, ...)

	if ( event == "EQUIPMENT_SWAP_FINISHED" ) then
		local completed, setID = ...;
		if ( completed ) then
			PlaySound(SOUNDKIT.PUT_DOWN_SMALL_CHAIN); -- plays the equip sound for plate mail
			if (self:IsShown()) then
				self.selectedSetID = setID;
				MCF_PaperDollEquipmentManagerPane_Update();
			end
		end
	end


	if (self:IsShown()) then
		if ( event == "EQUIPMENT_SETS_CHANGED" ) then
			MCF_PaperDollEquipmentManagerPane_Update();
		elseif ( event == "PLAYER_EQUIPMENT_CHANGED" or event == "BAG_UPDATE" ) then
			MCF_PaperDollEquipmentManagerPane_Update();
			-- This queues the update to only happen once at the end of the frame
			self.queuedUpdate = true;
		end
	end
end
function MCF_PaperDollEquipmentManagerPane_OnUpdate(self)
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
		MCF_PaperDollEquipmentManagerPane_Update();
		self.queuedUpdate = false;
	end
end

function MCF_PaperDollEquipmentManagerPaneEquipSet_OnClick (self)
	local selectedSetID = PaperDollEquipmentManagerPane.selectedSetID;
    --[[ if ( selectedSetName and selectedSetName ~= "") then ]]
	if ( selectedSetID ) then
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);	-- inappropriately named, but a good sound.
		--[[ C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID(selectedSetName)); ]]
        EquipmentManager_EquipSet(selectedSetID);
	end
end

function MCF_PaperDollEquipmentManagerPaneSaveSet_OnClick (self)
	local selectedSetName = PaperDollEquipmentManagerPane.selectedSetName;
	local selectedSetID = PaperDollEquipmentManagerPane.selectedSetID;
	if ( selectedSetID ) then
		local dialog = StaticPopup_Show("CONFIRM_SAVE_EQUIPMENT_SET", selectedSetName);
		if ( dialog ) then
			dialog.data = selectedSetID;
		else
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
		end
	end
end

function MCF_GearSetDeleteButton_OnClick(self)
	local dialog = StaticPopup_Show("CONFIRM_DELETE_EQUIPMENT_SET", self:GetParent().name);
	if ( dialog ) then
		dialog.data = self:GetParent().setID;
	else
		UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
	end
end

-- GearSet button scripts
function MCF_GearSetButton_OnEnter (self)
	if ( self.name and self.name ~= "" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		GameTooltip:SetEquipmentSet(self.name);
	end
end
-- NOT READY
function MCF_GearSetButton_OnClick (self, button, down)
	if ( self.setID ) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);		-- inappropriately named, but a good sound.
		PaperDollEquipmentManagerPane.selectedSetName = self.name;
		PaperDollEquipmentManagerPane.selectedSetID = self.setID;
		-- mark the ignored slots
		MCF_PaperDollFrame_ClearIgnoredSlots();
		MCF_PaperDollFrame_IgnoreSlotsForSet(self.setID);
		MCF_PaperDollEquipmentManagerPane_Update();
		MCF_GearManagerDialogPopup:Hide();
	else
		-- This is the "New Set" button
		MCF_GearManagerDialogPopup:Show();
		PaperDollEquipmentManagerPane.setID = nil;
		PaperDollEquipmentManagerPane.selectedSetName = nil;
		PaperDollEquipmentManagerPane.selectedSetID = nil;
		MCF_PaperDollFrame_ClearIgnoredSlots();
		MCF_PaperDollEquipmentManagerPane_Update();
		-- Ignore shirt and tabard by default
		MCF_PaperDollFrame_IgnoreSlot(4);
		MCF_PaperDollFrame_IgnoreSlot(19);
	end
	StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET");
	StaticPopup_Hide("MCF_CONFIRM_OVERWRITE_EQUIPMENT_SET");
end

function MCF_PaperDollFrame_ClearIgnoredSlots()
	C_EquipmentSet.ClearIgnoredSlotsForSave();		
	for k, button in next, itemSlotButtons do
		if ( button.ignored ) then
			button.ignored = nil;
			PaperDollItemSlotButton_Update(button);
		end
	end
end

function MCF_PaperDollFrame_IgnoreSlotsForSet (setID)
	local set = C_EquipmentSet.GetIgnoredSlots(setID);
	for slot, ignored in ipairs(set) do
		if ( ignored == EQUIPMENT_SET_IGNORED_SLOT ) then
			C_EquipmentSet.IgnoreSlotForSave(slot);
			itemSlotButtons[slot].ignored = true;
			PaperDollItemSlotButton_Update(itemSlotButtons[slot]);
		end
	end
end

function MCF_PaperDollFrame_IgnoreSlot(slot)
	C_EquipmentSet.IgnoreSlotForSave(slot);
	itemSlotButtons[slot].ignored = true;
	PaperDollItemSlotButton_Update(itemSlotButtons[slot]);
end

function MCF_GetEquipmentSetInfoByName(arg) -- arg could be: "", "name", 1 (number),
    if ( type(arg) =="string" and arg ~= "" ) then
        if ( C_EquipmentSet.GetEquipmentSetID(arg) ~= nil ) then
            return C_EquipmentSet.GetEquipmentSetInfo(C_EquipmentSet.GetEquipmentSetID(arg));
        else
            return nil;
        end
    elseif ( arg == "" ) then
        return nil;
    else
        return C_EquipmentSet.GetEquipmentSetInfo(arg);
    end
end

function MCF_PaperDollEquipmentManagerPane_Update()
	local _, _, setID, isEquipped = MCF_GetEquipmentSetInfoByName(PaperDollEquipmentManagerPane.selectedSetName or "");
	if (setID) then
		if (isEquipped) then
			PaperDollEquipmentManagerPaneSaveSet:Disable();
			PaperDollEquipmentManagerPaneEquipSet:Disable();
		else
			PaperDollEquipmentManagerPaneSaveSet:Enable();
			PaperDollEquipmentManagerPaneEquipSet:Enable();
		end
	else
		PaperDollEquipmentManagerPaneSaveSet:Disable();
		PaperDollEquipmentManagerPaneEquipSet:Disable();
		
		-- Clear selected equipment set if it doesn't exist
		if (PaperDollEquipmentManagerPane.selectedSetID) then
			PaperDollEquipmentManagerPane.selectedSetID = nil;
			MCF_PaperDollFrame_ClearIgnoredSlots();
		end
	end

	local numSets = C_EquipmentSet.GetNumEquipmentSets();
	local numRows = numSets;
	if (numSets < MAX_EQUIPMENT_SETS_PER_PLAYER) then
		numRows = numRows + 1;  -- "Add New Set" button
	end

	HybridScrollFrame_Update(PaperDollEquipmentManagerPane, numRows * MCF_EQUIPMENTSET_BUTTON_HEIGHT + PaperDollEquipmentManagerPaneEquipSet:GetHeight() + 20 , PaperDollEquipmentManagerPane:GetHeight());
	
	local scrollOffset = HybridScrollFrame_GetOffset(PaperDollEquipmentManagerPane);
	local buttons = PaperDollEquipmentManagerPane.buttons;
	local selectedSetID = PaperDollEquipmentManagerPane.selectedSetID;
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

----------------------------------------------------------------------------------
------------------------------- GEAR MANAGER DIALOG ------------------------------
----------------------------------------------------------------------------------
local EM_ICON_FILENAMES = {};

function MCF_GearManagerDialogPopup_OnLoad (self)
	self.buttons = {};
	
	local rows = 0;
	
	local button = CreateFrame("CheckButton", "MCF_GearManagerDialogPopupButton1", MCF_GearManagerDialogPopup, "MCF-GearSetPopupButtonTemplate");
	button:SetPoint("TOPLEFT", 24, -85);
	button:SetID(1);
	tinsert(self.buttons, button);
	
	local lastPos;
	for i = 2, NUM_GEARSET_ICONS_SHOWN do
		button = CreateFrame("CheckButton", "MCF_GearManagerDialogPopupButton" .. i, MCF_GearManagerDialogPopup, "MCF-GearSetPopupButtonTemplate");
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
function MCF_GearManagerDialogPopup_OnShow (self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
	self.name = nil;
	self.isEdit = false;
	MCF_RecalculateGearManagerDialogPopup();
end
function MCF_GearManagerDialogPopup_OnHide (self)
	MCF_GearManagerDialogPopup.name = nil;
	MCF_GearManagerDialogPopup:SetSelection(true, nil);
	MCF_GearManagerDialogPopupEditBox:SetText("");
	if (not PaperDollEquipmentManagerPane.selectedSetName) then
		MCF_PaperDollFrame_ClearIgnoredSlots();
	end
	EM_ICON_FILENAMES = nil;
	collectgarbage();
end

--[[
GetEquipmentSetIconInfo(index) determines the texture and real index of a regular index
	Input: 	index = index into a list of equipped items followed by the macro items. Only tricky part is the equipped items list keeps changing.
	Output: the associated texture for the item, and a index relative to the join point between the lists, i.e. negative for the equipped items
			and positive for the macro items//
]]
function MCF_GetEquipmentSetIconInfo(index)
	return EM_ICON_FILENAMES[index];
end

function MCF_GearManagerDialogPopup_Update ()
	MCF_RefreshEquipmentSetIconInfo();

	local popup = MCF_GearManagerDialogPopup;
	local buttons = popup.buttons;
	local offset = FauxScrollFrame_GetOffset(MCF_GearManagerDialogPopupScrollFrame) or 0;
	local button;	
	-- Icon list
	local texture, index, button, realIndex, _;
	for i=1, NUM_GEARSET_ICONS_SHOWN do
		local button = buttons[i];
		index = (offset * NUM_GEARSET_ICONS_PER_ROW) + i;
		if ( index <= #EM_ICON_FILENAMES ) then
			texture = MCF_GetEquipmentSetIconInfo(index);
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
	FauxScrollFrame_Update(MCF_GearManagerDialogPopupScrollFrame, ceil(#EM_ICON_FILENAMES / NUM_GEARSET_ICONS_PER_ROW) , NUM_GEARSET_ICON_ROWS, GEARSET_ICON_ROW_HEIGHT );
end

function MCF_RecalculateGearManagerDialogPopup(setName, iconTexture)
	local popup = MCF_GearManagerDialogPopup;
	if ( setName and setName ~= "") then
		MCF_GearManagerDialogPopupEditBox:SetText(setName);
		MCF_GearManagerDialogPopupEditBox:HighlightText(0);
	else
		MCF_GearManagerDialogPopupEditBox:SetText("");
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
	MCF_RefreshEquipmentSetIconInfo();
	local totalItems = #EM_ICON_FILENAMES;
	local texture, _;
	if(popup.selectedTexture) then
		local foundIndex = nil;
		for index=1, totalItems do
			texture = MCF_GetEquipmentSetIconInfo(index);
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
		FauxScrollFrame_OnVerticalScroll(MCF_GearManagerDialogPopupScrollFrame, offset*GEARSET_ICON_ROW_HEIGHT, GEARSET_ICON_ROW_HEIGHT, nil);
	else
		FauxScrollFrame_OnVerticalScroll(MCF_GearManagerDialogPopupScrollFrame, 0, GEARSET_ICON_ROW_HEIGHT, nil);
	end
	MCF_GearManagerDialogPopup_Update();
end

-- RefreshEquipmentSetIconInfo() counts how many uniquely textured inventory items the player has equipped. 
function MCF_RefreshEquipmentSetIconInfo()
	EM_ICON_FILENAMES = {};
	--[[ MCFEM_ICON_FILENAMES[1] = "INV_MISC_QUESTIONMARK"; ]] --MCFFIX replaced with modern version
	EM_ICON_FILENAMES[1] = 134400;
	local index = 2;

	for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		local itemTexture = GetInventoryItemTexture("player", i); --MCFFIX returns number instead of texture path now
		if ( itemTexture ) then
			--[[ MCFEM_ICON_FILENAMES[index] = gsub( strupper(itemTexture), "INTERFACE\\ICONS\\", "" ); ]] --MCFFIX replaced with modern version
			EM_ICON_FILENAMES[index] = itemTexture;
			if(EM_ICON_FILENAMES[index]) then
				index = index + 1;
				--[[
				Currently checks all for duplicates, even though only rings, trinkets, and weapons may be duplicated. 
				This version is clean and maintainable.
				]]
				for j=INVSLOT_FIRST_EQUIPPED, (index-1) do
					if(EM_ICON_FILENAMES[index] == EM_ICON_FILENAMES[j]) then
						EM_ICON_FILENAMES[index] = nil;
						index = index - 1;
						break;
					end
				end
			end
		end
	end
	GetMacroItemIcons(EM_ICON_FILENAMES);
	GetMacroIcons(EM_ICON_FILENAMES);
end

function MCF_GearManagerDialogPopupOkay_Update()
	local popup = MCF_GearManagerDialogPopup;
	local button = MCF_GearManagerDialogPopupOkay;
	
	if ( popup.selectedIcon and popup.name ) then
		button:Enable();
	else
		button:Disable();
	end
end
function MCF_GearManagerDialogPopupOkay_OnClick(self, button, pushed)
	local popup = MCF_GearManagerDialogPopup;

	local icon = MCF_GetEquipmentSetIconInfo(popup.selectedIcon);
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
function MCF_GearManagerDialogPopupCancel_OnClick()
	MCF_GearManagerDialogPopup:Hide();
end
function MCF_GearSetPopupButton_OnClick(self, button)
	local popup = MCF_GearManagerDialogPopup;
	local offset = FauxScrollFrame_GetOffset(MCF_GearManagerDialogPopupScrollFrame) or 0;
	popup.selectedIcon = (offset * NUM_GEARSET_ICONS_PER_ROW) + self:GetID();
 	popup.selectedTexture = nil;
	MCF_GearManagerDialogPopup_Update();
	MCF_GearManagerDialogPopupOkay_Update();
end

----------------------------------------------------------------------------------
--------------------------------- ITEM SLOT BUTTON -------------------------------
----------------------------------------------------------------------------------
function MCF_PaperDollItemSlotButton_OnClick (self, button)
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

function MCF_PaperDollItemSlotButton_OnModifiedClick (self, button)
	if ( HandleModifiedItemClick(GetInventoryItemLink("player", self:GetID())) ) then
		return;
	end
	if ( IsModifiedClick("SOCKETITEM") ) then
		SocketInventoryItem(self:GetID());
	end
end

function MCF_PaperDollItemSlotButton_Update (self)
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
	
	if (not PaperDollEquipmentManagerPane:IsShown()) then
		self.ignored = nil;
	end
	
	if ( self.ignored and self.ignoreTexture ) then
		self.ignoreTexture:Show();
	elseif ( self.ignoreTexture ) then
		self.ignoreTexture:Hide();
	end

	PaperDollItemSlotButton_UpdateLock(self);

	-- Update repair all button status
	MerchantFrame_UpdateGuildBankRepair();
	MerchantFrame_UpdateCanRepairAll();
end

function MCF_PaperDollItemSlotButton_UpdateLock (self)
	if ( IsInventoryItemLocked(self:GetID()) ) then
		--this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		SetItemButtonDesaturated(self, 1);
	else 
		--this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		SetItemButtonDesaturated(self, nil);
	end
end

function MCF_PaperDollItemSlotButton_OnEnter (self)
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

function MCF_PaperDollItemSlotButton_OnLeave (self)
	self:UnregisterEvent("MODIFIER_STATE_CHANGED");
	GameTooltip:Hide();
	ResetCursor();
end