print("Hello! Thank you for testing Modern Character Frame! Don't forget to bind a key in settings.");

ModernCharacterFrame3 = CreateFrame("Frame", "MCFPetPaperDollFrame", MCFCharacterFrame);
ModernCharacterFrame4 = CreateFrame("Frame", "MCFReputationFrame", MCFCharacterFrame);
ModernCharacterFrame5 = CreateFrame("Frame", "MCFTokenFrame", MCFCharacterFrame);

--[[ if (_G["MCFCharacterFrame"] ~= nil) then
    print("MCFCharacterFrame exists!");
else
    print("MCFCharacterFrame doesn't exist!");
end;

if (_G["MCFPaperDollFrame"] ~= nil) then
    print("MCFPaperDollFrame exists!");
else
    print("MCFPaperDollFrame doesn't exist!");
end; ]]
