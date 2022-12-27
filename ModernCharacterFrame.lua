print("Hello! Thank you for testing Modern Character Frame!");
print("Don't forget to bind a key in settings.");

ModernCharacterFrame3 = CreateFrame("Frame", "MCFPetPaperDollFrame", MCFCharacterFrame);
ModernCharacterFrame4 = CreateFrame("Frame", "MCFReputationFrame", MCFCharacterFrame);
ModernCharacterFrame5 = CreateFrame("Frame", "MCFTokenFrame", MCFCharacterFrame);

--[[ 
ToggleGameMenu() - Game menu (Esc)
ToggleCharacter("PaperDollFrame") - Character frame
    ToggleCharacter("PetPaperDollFrame")
    ToggleCharacter("ReputationFrame")
    ToggleCharacter("SkillFrame")
    ToggleCharacter("TokenFrame")
ToggleSpellBook(BOOKTYPE_SPELL)
    ToggleSpellBook(BOOKTYPE_PET)
ToggleTalentFrame()
    ToggleGlyphFrame()
ToggleQuestLog()
ToggleWorldMap()
ToggleWorldStateScoreFrame() - ?
ToggleAchievementFrame()
    ToggleAchievementFrame(1)
ToggleFriendsFrame()
    ToggleFriendsFrame(FRIEND_TAB_FRIENDS)
    ToggleFriendsFrame(FRIEND_TAB_WHO)
    ToggleFriendsFrame(FRIEND_TAB_GUILD)
ToggleRaidFrame()
ToggleCommunitiesFrame()
ToggleChannelFrame()
]]

MCF_FRAME_OFFSETS = {
    ["GossipFrame"] = 370,
    ["MerchantFrame"] = 370,
    ["FriendsFrame"] = 370,
    ["PVPFrame"] = 370,
    ["LFGParentFrame"] = 370,
    ["SpellBookFrame"] = 400,
    ["PlayerTalentFrame"] = 400,
    ["ChannelFrame"] = 434,
    ["QuestLogFrame"] = 698,
    ["CommunitiesFrame"] = 878,
    ["AuctionFrame"] = 952,
    ["AchievementFrame"] = 952, -- LoadOnDemand, doesn't work
}

function MCF_ChangePosition(frame, dir)
    local _, _, _, currentPos, _ = MCFCharacterFrame:GetPoint();
    local offset = MCF_FRAME_OFFSETS[frame:GetName()];
    if ( dir and (dir == "left") ) then
        offset = -1 * offset;
    end
    local xCoord = currentPos + offset;
    MCFCharacterFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", xCoord, -116);
end

local tblFrame = {
    GossipFrame,
    MerchantFrame,
    FriendsFrame,
    PVPFrame,
    LFGParentFrame,
    SpellBookFrame,
    PlayerTalentFrame,
    ChannelFrame,
    QuestLogFrame,
    CommunitiesFrame,
    AuctionFrame,
    AchievementFrame, -- LoadOnDemand, doesn't work
};

for _,frame in pairs(tblFrame) do
frame:HookScript("OnShow",function(self)
                MCF_ChangePosition(self);
                end);
frame:HookScript("OnHide",function(self)
                MCF_ChangePosition(self,"left");
                end);
end

table.insert(UISpecialFrames, "MCFCharacterFrame");

--[[ GameMenuFrame:HookScript("OnShow",function()
                MCFCharacterFrame:Hide();
                end); ]]


CharacterMicroButton:SetScript("OnMouseDown", nil);
CharacterMicroButton:SetScript("OnMouseUp", nil);        
--[[ CharacterMicroButton:SetScript("OnClick", nil); ]]
CharacterMicroButton:SetScript("OnMouseDown", function(self)
                                if ( self.down ) then
                                    self.down = nil;
                                    MCFToggleCharacter("MCFPaperDollFrame");
                                    return;
                                end
                                CharacterMicroButton_SetPushed();
                                self.down = 1;
                                end);
CharacterMicroButton:SetScript("OnMouseUp", function(self)
                                if ( self.down ) then
                                    self.down = nil;
                                    if ( self:IsMouseOver() ) then
                                        MCFToggleCharacter("MCFPaperDollFrame");
                                    end
                                    MCFUpdateMicroButtons();
                                    return;
                                end
                                if ( self:GetButtonState() == "NORMAL" ) then
                                    CharacterMicroButton_SetPushed(); self.down = 1;
                                else
                                    CharacterMicroButton_SetNormal(); self.down = 1;
                                end
                                end);
--[[ CharacterMicroButton:SetScript("OnClick", function(self) MCFToggleCharacter("MCFPaperDollFrame") end); ]]