local _, L = ...;

local function defaultFunc(L, key)
    --[[ print("MLU debug - send it to author - key is missing:", key); ]]
    return key;
end
setmetatable(L, {__index=defaultFunc});

if GetLocale() == ("enUS") then
    L["MLU_LEVEL_UP"] = LEVEL_UP;
    L["MLU_LEVEL_UP_TALENT_MAIN"] = LEVEL_UP_TALENT_MAIN;
    L["MLU_LEVEL_GAINED"] = LEVEL_GAINED;
    L["MLU_LEVEL_UP_GLYPH1_LINK"] = "New |cffFF4E00|Hgarrmission:MLU:glyphpane|h[Major Glyph]|h|r Available!";
    L["MLU_LEVEL_UP_GLYPH2_LINK"] = "New |cffFF4E00|Hgarrmission:MLU:glyphpane|h[Minor Glyph]|h|r Available!";
end