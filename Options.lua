local _, L = ...;

----------------------------------------------------------------------------------
----------------------------- OPTION PANEL FUNCTIONS -----------------------------
----------------------------------------------------------------------------------

-- Creating Interface/AddOns options tab
function MCF_CreateOptionsFrame()
    MCF.OptionsFrame = CreateFrame("Frame", "MCF_OptionsFrame", nil, "MCF_OptionsFrameTemplate");
end

-- TACOTIP INTEGRATION ENABLE BUTTON FUNCTIONS
function MCF_OptionsFrameTTEnableButton_OnEvent(self, event, ...)
    local arg = ...;

    if ( (event == "ADDON_LOADED") and (arg == "ModernCharacterFrame") ) then
        if ( not MCF_GetSettings("TT_IntegrationEnabled") ) then
            self:SetChecked(false);
        else
            self:SetChecked(true);
        end
        self:UnregisterEvent(event);
    end
end
function MCF_OptionsFrameTTEnableButton_OnShow(self)
    if ( not IsAddOnLoaded("TacoTip") ) then
        self:Disable();
        self.Text:SetFontObject(GameFontDisable);
        _G[self:GetParent():GetName().."Title"]:SetText(MCF_OPTIONS_TT_INTEGRATION_TITLE_DISABLED);
    end
end
function MCF_OptionsFrameTTEnableButton_HookOnClick(self)
    local ColorEnableButton = _G[self:GetParent():GetName().."GSColorEnableButton"];
    if ( self:GetChecked() ) then
        MCF_SetSettings("TT_IntegrationEnabled", true);
        ColorEnableButton:Enable();
        ColorEnableButton.Text:SetFontObject(GameFontHighlight);
        UIDropDownMenu_EnableDropDown(MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown);
    else
        MCF_SetSettings("TT_IntegrationEnabled", false);
        ColorEnableButton:Disable();
        ColorEnableButton.Text:SetFontObject(GameFontDisable);
        UIDropDownMenu_DisableDropDown(MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown);
    end
end

-- TACOTIP GEARSCORE TEXT TYPE DROPDOWN MENU FUNCTIONS
function MCF_OptionsFrameGSTextTypeDropDown_Initialize()
    local selectedValue = UIDropDownMenu_GetSelectedValue(MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown);
    local info = UIDropDownMenu_CreateInfo();

    info.text = "ILVL / GS";
    info.func = MCF_OptionsFrameGSTextTypeDropDown_OnClick;
    info.value = 1;
    if (info.value == selectedValue) then
        info.checked = 1;
    else
        info.checked = nil;
    end
    UIDropDownMenu_AddButton(info);

    info.text = "ILVL (GS)";
    info.func = MCF_OptionsFrameGSTextTypeDropDown_OnClick;
    info.value = 2;
    if (info.value == selectedValue) then
        info.checked = 1;
    else
        info.checked = nil;
    end
    UIDropDownMenu_AddButton(info);

    info.text = "GS";
    info.func = MCF_OptionsFrameGSTextTypeDropDown_OnClick;
    info.value = 3;
    if (info.value == selectedValue) then
        info.checked = 1;
    else
        info.checked = nil;
    end
    UIDropDownMenu_AddButton(info);


end
function MCF_OptionsFrameGSTextTypeDropDown_OnEvent(self, event, ...)
    if ( (event == "ADDON_LOADED") and (... == "ModernCharacterFrame") ) then
        self.defaultValue = 1;
        self.oldValue = MCF_GetSettings("TT_IntegrationType");
        self.value = self.defaultValue;
        self.tooltip = _G["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_TOOLTIP"];

        UIDropDownMenu_SetWidth(self, 90);
        UIDropDownMenu_Initialize(self, MCF_OptionsFrameGSTextTypeDropDown_Initialize);
        UIDropDownMenu_SetSelectedValue(self, self.value);

        self.SetValue =
            function(self, value)
                self.value = value;
                UIDropDownMenu_SetSelectedValue(self, value);
                MCF_SetSettings("TT_IntegrationType", value);
            end;
        self.GetValue =
            function(self)
                return UIDropDownMenu_GetSelectedValue(self);
            end;
        self.RefreshValue =
            function(self)
                UIDropDownMenu_Initialize(self, MCF_OptionsFrameGSTextTypeDropDown_Initialize);
                UIDropDownMenu_SetSelectedValue(self, self.value);
            end;
        self:UnregisterEvent(event);
    end
end
function MCF_OptionsFrameGSTextTypeDropDown_OnShow(self)
    local EnableButton = _G[self:GetParent():GetName().."EnableButton"];
    if ( (not EnableButton:GetChecked()) or (not EnableButton:IsEnabled()) ) then
        UIDropDownMenu_DisableDropDown(self);
        self.Text:SetFontObject(GameFontDisable);
    end
end
function MCF_OptionsFrameGSTextTypeDropDown_OnClick(self)
	MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown:SetValue(self.value);
end

-- TACOTIP GEARSCORE COLOR ENABLE BUTTON FUNCTIONS
function MCF_OptionsFrameGSColorEnableButton_OnEvent(self, event, ...)
    local arg = ...;

    if ( (event == "ADDON_LOADED") and (arg == "ModernCharacterFrame") ) then
        if ( not MCF_GetSettings("TT_IntegrationColorEnabled") ) then
            self:SetChecked(false);
        else
            self:SetChecked(true);
        end
        self:UnregisterEvent(event);
    end
end
function MCF_OptionsFrameGSColorEnableButton_OnShow(self)
    local EnableButton = _G[self:GetParent():GetName().."EnableButton"];
    if ( (not EnableButton:GetChecked()) or (not EnableButton:IsEnabled()) ) then
        self:Disable();
        self.Text:SetFontObject(GameFontDisable);
    end
end
function MCF_OptionsFrameGSColorEnableButton_HookOnClick(self)
    if ( self:GetChecked() ) then
        MCF_SetSettings("TT_IntegrationColorEnabled", true);
    else
        MCF_SetSettings("TT_IntegrationColorEnabled", false);
    end
end