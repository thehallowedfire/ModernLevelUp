print("Hello! Initializing ModernCharacterFrame.lua!");

ModernCharacterFrame1 = CreateFrame("Frame", "MCFCharacterFrame", UIParent, "MCFCharacterFrame");
ModernCharacterFrame2 = CreateFrame("Frame", "MCFPaperDollFrame", MCFCharacterFrame, "MCFPaperDollFrame");
ModernCharacterFrame3 = CreateFrame("Frame", "MCFPetPaperDollFrame", MCFCharacterFrame);
ModernCharacterFrame3 = CreateFrame("Frame", "MCFReputationFrame", MCFCharacterFrame);
ModernCharacterFrame3 = CreateFrame("Frame", "MCFTokenFrame", MCFCharacterFrame);

--[[ MCFPaperDollFrame:Hide();
MCFPetPaperDollFrame:Hide();
MCFReputationFrame:Hide();
MCFTokenFrame:Hide(); ]]
--[[ _G["MCFCharacterFrame"].hidden = true; ]]

if (_G["MCFCharacterFrame"] ~= nil) then
    print("MCFCharacterFrame exists!");
else
    print("MCFCharacterFrame doesn't exist!");
end;

if (_G["MCFPaperDollFrame"] ~= nil) then
    print("MCFPaperDollFrame exists!");
else
    print("MCFPaperDollFrame doesn't exist!");
end;
