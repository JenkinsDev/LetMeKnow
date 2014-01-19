LetMeKnow = LibStub("AceAddon-3.0"):NewAddon("LetMeKnow", "AceEvent-3.0")


--[-----------------------------------------------------
--                   Event Functions                  --
-----------------------------------------------------]--

function LetMeKnow:UNIT_AURA(_, _)
    local buffOn = UnitBuff("player", "Deadly Poison")
    
    if buffOn then
        self.deadlyPoisonIcon:Hide()
    else
        self.deadlyPoisonIcon:Show()
    end
end

--[-----------------------------------------------------
--                 Generic Functions                  --
-----------------------------------------------------]--

function CreateUIFrame()
    local deadlyPoisonIconTexture,
          deadlyPoisonFrame,
          frameWidth,
          frameHeight = nil, nil, 64, 64

    -- Create the frame for our alert icon.
    deadlyPoisonFrame = CreateFrame("Button", "LetMeKnowDeadlyPoison")
    deadlyPoisonFrame:SetFrameStrata("BACKGROUND")
    deadlyPoisonFrame:SetWidth(frameWidth)
    deadlyPoisonFrame:SetHeight(frameHeight)
    deadlyPoisonFrame:SetPoint("CENTER", 0, 0)

    -- Create the texture for our alert icon and attach it to our frame from above.
    deadlyPoisonIconTexture = deadlyPoisonFrame:CreateTexture(nil, "BACKGROUND")
    deadlyPoisonIconTexture:SetTexture("Interface\\Icons\\Ability_Rogue_DualWeild")
    deadlyPoisonIconTexture:SetAllPoints(deadlyPoisonFrame)

    -- Attach our icon texture to the frame.
    deadlyPoisonFrame.texture = deadlyPoisonIconTexture
    deadlyPoisonFrame:Hide()

    return deadlyPoisonFrame
end


--[-----------------------------------------------------
--              AceAddon Startup Methods.             --
-----------------------------------------------------]--

function LetMeKnow:OnInitialize()
    local _, className, _ = UnitClass("player")

    if className ~= "ROGUE" then
        return nil
    end

    -- Create our "alert icon"
    self.deadlyPoisonIcon = CreateUIFrame()

    self:RegisterEvent("UNIT_AURA")
end

function LetMeKnow:OnEnable()
    self:OnInitialize()
end

function LetMeKnow:OnDisable()
    self.UnregisterEvent("UNIT_AURA")
end