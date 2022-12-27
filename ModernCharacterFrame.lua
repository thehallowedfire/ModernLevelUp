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
    ["AchievementFrame"] = 952,
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
    GossipFrame, --ok
    MerchantFrame, --ok
    FriendsFrame, --ok
    PVPFrame, --ok
    LFGParentFrame, -- CHECK Loads a little bit later than others
    SpellBookFrame, --ok
    PlayerTalentFrame, --ok
    ChannelFrame, --ok
    QuestLogFrame, --ok
    CommunitiesFrame,-- CHECK Loads on first open
    AuctionFrame,-- CHECK Loads on first open
    AchievementFrame,-- CHECK Loads on first open
};

function MCF_SetHookOnDefaultFrames()
    for _,frame in pairs(tblFrame) do
        print(frame:GetName(),
        frame:HookScript("OnShow",function(self)
                        MCF_ChangePosition(self);
                        end),
        frame:HookScript("OnHide",function(self)
                        MCF_ChangePosition(self,"left");
                        end));
    end
end
MCF_SetHookOnDefaultFrames()


-- Makes addon's frame closable by pressing Esc
table.insert(UISpecialFrames, "MCFCharacterFrame");

-- Sets up Micromenu button call of addon's frame instead of default one
CharacterMicroButton:SetScript("OnMouseDown", nil);
CharacterMicroButton:SetScript("OnMouseUp", nil);        
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
