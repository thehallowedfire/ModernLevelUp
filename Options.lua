----------------------------------------------------------------------------------
----------------------------- OPTION PANEL FUNCTIONS -----------------------------
----------------------------------------------------------------------------------

-- Creating Interface/AddOns options tab
function MCF_CreateOptionsFrame()
    MCF.name = "Modern Character Frame";
    InterfaceOptions_AddCategory(MCF);
end

-- Title and description
function MCF_CreateOptionsText()
    local title = MCF:CreateFontString("ARTWORK", nil, "GameFontNormalLarge");
    title:SetPoint("TOPLEFT", 16, -16);
    title:SetText("Modern Character Frame");

    local description = MCF:CreateFontString("ARTWORK", nil, "GameFontHighlightSmall");
    --[[ description:SetSize(0, 32); ]]
    description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8);
    --[[ description:SetPoint("RIGHT", -32, 0); ]]
    description:SetJustifyH("LEFT");
    description:SetJustifyV("TOP");
    description:SetText("Version: "..GetAddOnMetadata("ModernCharacterFrame", "Version").."\nAuthor: Профессия — Flamegor (EU).\n\nRe-skins default Character frame into modern version.");
end
