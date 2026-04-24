local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

local SpyReskin_Active = true

local WeizStyleBackdrop = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    tile = false, tileSize = 0, edgeSize = 1,
    insets = { left = 0, right = 0, top = 0, bottom = 0 }
}

-- FUNCTION: Apply DorisPP Font
local function ApplyCustomFonts()
    if not Spy or not Spy.MainWindow then return end

    if Spy.MainWindow.Title then
        Spy.MainWindow.Title:SetFont(SpyReskin_Font, SpyReskin_FontSize + 2, "OUTLINE")
    end

    if Spy.MainWindow.Rows then
        for i = 1, #Spy.MainWindow.Rows do
            local row = Spy.MainWindow.Rows[i]
            if row.LeftText then
                row.LeftText:SetFont(SpyReskin_Font, SpyReskin_FontSize, "OUTLINE")
            end
            if row.RightText then
                row.RightText:SetFont(SpyReskin_Font, SpyReskin_FontSize - 1, "OUTLINE")
            end
        end
    end
end

-- FUNCTION: Reskin Buttons to Flat Square
local function ReskinButton(btn, texturePath)
    if not btn then return end
    btn:SetNormalTexture("")
    btn:SetPushedTexture("")
    btn:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    btn:GetHighlightTexture():SetAlpha(0.2)
    btn:SetBackdrop(WeizStyleBackdrop)
    btn:SetBackdropColor(0, 0, 0, 0.6)
    btn:SetBackdropBorderColor(0, 0, 0, 1)
    
    if not btn.CustomIcon then
        btn.CustomIcon = btn:CreateTexture(nil, "OVERLAY")
        btn.CustomIcon:SetPoint("CENTER", 0, 0)
        btn.CustomIcon:SetSize(btn:GetWidth()-4, btn:GetHeight()-4)
    end
    btn.CustomIcon:SetTexture(texturePath)
end

-- 1. CORE SKINNING LOGIC
local function ApplySpySkin(r, g, b, a, isDefault)
    if not Spy or not Spy.MainWindow then return end

    if isDefault then
        -- Return to Blizzard Tooltip look
        Spy.MainWindow:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        Spy.MainWindow:SetBackdropColor(0, 0, 0, 0.8)
        Spy.MainWindow:SetBackdropBorderColor(1, 1, 1, 1)
        SpyReskin_Active = false
    else
        -- Apply Weiz Style
        Spy.MainWindow:SetBackdrop(WeizStyleBackdrop)
        Spy.MainWindow:SetBackdropColor(r, g, b, a or 0.8)
        Spy.MainWindow:SetBackdropBorderColor(0, 0, 0, 1)
        
        if Spy.MainWindow.TitleBar then
            Spy.MainWindow.TitleBar:SetBackdrop(WeizStyleBackdrop)
            Spy.MainWindow.TitleBar:SetBackdropColor(0.01, 0.01, 0.01, 1)
            Spy.MainWindow.TitleBar:SetBackdropBorderColor(0, 0, 0, 1)
        end

        ReskinButton(Spy.MainWindow.PrevButton, SpyReskin_ButtonTex.Prev)
        ReskinButton(Spy.MainWindow.NextButton, SpyReskin_ButtonTex.Next)
        ReskinButton(Spy.MainWindow.ClearButton, SpyReskin_ButtonTex.Reset)
        if Spy.MainWindow.StatsButton then
            ReskinButton(Spy.MainWindow.StatsButton, SpyReskin_ButtonTex.Stats)
        end

        SpyReskin_Active = true
        ApplyCustomFonts()
    end
end

-- 2. ROW FORMATTING (The Weiz Layout)
local function UpdateSpyRows()
    if not SpyReskin_Active or not Spy.MainWindow.Rows then return end

    for i = 1, #Spy.MainWindow.Rows do
        local row = Spy.MainWindow.Rows[i]
        if row:IsShown() and row.name and row.name ~= "" then
            local p = SpyPerCharDB.PlayerData[row.name]
            if p then
                local level = p.level or "??"
                local guild = p.guild or ""
                local class = p.class or "UNKNOWN"
                
                local roleIcon = SpyReskin_Icons["DAMAGER"]
                if class == "PRIEST" then roleIcon = SpyReskin_Icons["HEALER"] end
                
                row.LeftText:SetText(string.format("%s %s  %s", roleIcon, row.name, level))
                row.RightText:SetText("|cffcccccc" .. guild .. "|r")
                
                row:SetBackdrop(WeizStyleBackdrop)
                row:SetBackdropBorderColor(0, 0, 0, 0.5)
                
                row.LeftText:SetFont(SpyReskin_Font, SpyReskin_FontSize, "OUTLINE")
                row.RightText:SetFont(SpyReskin_Font, SpyReskin_FontSize - 1, "OUTLINE")
            end
        end
    end
end

if Spy then
    hooksecurefunc(Spy, "ManageExpirations", UpdateSpyRows)
end

-- 3. THE THEME PICKER UI
local SelectionFrame = CreateFrame("Frame", "SpyReskinSelection", UIParent)
SelectionFrame:SetSize(170, 200)
SelectionFrame:SetPoint("CENTER", 0, 0)
SelectionFrame:SetBackdrop(WeizStyleBackdrop)
SelectionFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.95)
SelectionFrame:SetBackdropBorderColor(0, 0, 0, 1)
SelectionFrame:EnableMouse(true)
SelectionFrame:SetMovable(true)
SelectionFrame:RegisterForDrag("LeftButton")
SelectionFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
SelectionFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
SelectionFrame:Hide()

local title = SelectionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -10)
title:SetText("Spy Reskin by xLT69x")
title:SetFont(SpyReskin_Font, 11, "OUTLINE")

local function CreateThemeButton(text, yOffset, onClickFunc)
    local btn = CreateFrame("Button", nil, SelectionFrame, "UIPanelButtonTemplate")
    btn:SetSize(140, 25)
    btn:SetPoint("TOP", 0, yOffset)
    btn:SetText(text)
    btn:SetScript("OnClick", onClickFunc)
    local btnText = btn:GetFontString()
    if btnText then btnText:SetFont(SpyReskin_Font, 11, "OUTLINE") end
    return btn
end

CreateThemeButton("Class Theme", -35, function()
    local _, playerClass = UnitClass("player")
    local c = SpyReskin_Colors[playerClass]
    ApplySpySkin(c.r, c.g, c.b, 0.8, false)
end)

CreateThemeButton("Dark Theme", -65, function()
    local c = SpyReskin_Themes["Dark"]
    ApplySpySkin(c.r, c.g, b, c.a, false)
end)

CreateThemeButton("White Theme", -95, function()
    local c = SpyReskin_Themes["White"]
    ApplySpySkin(c.r, c.g, c.b, c.a, false)
end)

CreateThemeButton("Default Spy", -125, function()
    ApplySpySkin(0, 0, 0, 1, true)
end)

CreateThemeButton("Close", -155, function()
    SelectionFrame:Hide()
end)

-- 4. SLASH COMMAND
SLASH_SPYRESKIN1 = "/spyreskin"
SlashCmdList["SPYRESKIN"] = function()
    if SelectionFrame:IsShown() then SelectionFrame:Hide() else SelectionFrame:Show() end
end

-- 5. AUTO-LOAD LOGIN LOGIC
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        local c = SpyReskin_Themes["Dark"]
        C_Timer.After(2, function() 
            ApplySpySkin(c.r, c.g, c.b, c.a, false) 
            UpdateSpyRows()
            ApplyCustomFonts()
            print("|cff00ff00SpyReskin by xLT69x Loaded!|r")
        end)
    end
end)