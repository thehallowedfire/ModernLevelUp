--MCFFIX Added this constant(s) because they don't exist in modern version
MCFVERTICAL_FLYOUTS = { [16] = true, [17] = true, [18] = true };

--MCFFIX these constants are already in the game with same values
--[[
EQUIPPED_FIRST = 1;
EQUIPPED_LAST = 19;
]]--

--MCFFIX these constants are already in the game with same values
--[[
NUM_RESISTANCE_TYPES = 5;
NUM_STATS = 5;
NUM_SHOPPING_TOOLTIPS = 2;
MAX_SPELL_SCHOOLS = 7;
]]--

--MCFFIX these constants are already in the game with same values
--[[
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15;
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
CR_ARMOR_PENETRATION = 25;
CR_MASTERY = 26;
]]--

--MCFFIX these constants are already in the game with same values
--[[
ATTACK_POWER_MAGIC_NUMBER = 14;
BLOCK_PER_STRENGTH = 0.5;
MANA_PER_INTELLECT = 15;
BASE_MOVEMENT_SPEED = 7;
]]--

--MCFFIX these constants are already in the game with same values
--[[
--Pet scaling:
HUNTER_PET_BONUS = {};
HUNTER_PET_BONUS["PET_BONUS_RAP_TO_AP"] = 0.22;
HUNTER_PET_BONUS["PET_BONUS_RAP_TO_SPELLDMG"] = 0.1287;
HUNTER_PET_BONUS["PET_BONUS_STAM"] = 0.3;
HUNTER_PET_BONUS["PET_BONUS_RES"] = 0.4;
HUNTER_PET_BONUS["PET_BONUS_ARMOR"] = 0.7; --MCFFIX value is 0.35 on Wrath
HUNTER_PET_BONUS["PET_BONUS_SPELLDMG_TO_SPELLDMG"] = 0.0;
HUNTER_PET_BONUS["PET_BONUS_SPELLDMG_TO_AP"] = 0.0;
HUNTER_PET_BONUS["PET_BONUS_INT"] = 0.0;
]]--

--MCFFIX these constants are already in the game with same values
--[[
WARLOCK_PET_BONUS = {};
WARLOCK_PET_BONUS["PET_BONUS_RAP_TO_AP"] = 0.0;
WARLOCK_PET_BONUS["PET_BONUS_RAP_TO_SPELLDMG"] = 0.0;
WARLOCK_PET_BONUS["PET_BONUS_STAM"] = 0.3;
WARLOCK_PET_BONUS["PET_BONUS_RES"] = 0.4;
WARLOCK_PET_BONUS["PET_BONUS_ARMOR"] = 1.00; --MCFFIX value is 0.35 on Wrath
WARLOCK_PET_BONUS["PET_BONUS_SPELLDMG_TO_SPELLDMG"] = 0.15;
WARLOCK_PET_BONUS["PET_BONUS_SPELLDMG_TO_AP"] = 0.57;
WARLOCK_PET_BONUS["PET_BONUS_INT"] = 0.3;
]]--

MCFPLAYER_DISPLAYED_TITLES = 6;
MCFPLAYER_TITLE_HEIGHT = 22;

MCFEQUIPMENTSET_BUTTON_HEIGHT = 44;

local itemSlotButtons = {};

local STATCATEGORY_PADDING = 4;
local STATCATEGORY_MOVING_INDENT = 4;

MCFMOVING_STAT_CATEGORY = nil;

local StatCategoryFrames = {};

local STRIPE_COLOR = {r=0.9, g=0.9, b=1};

CLASS_MASTERY_SPELLS = {
	["DEATHKNIGHT"] = 86471,
	["DRUID"] = 86470 ,
	["HUNTER"] = 86472,
	["MAGE"] = 86473,
	["PALADIN"] = 86474,
	["PRIEST"] = 86475,
	["ROGUE"] = 86476, 
	["SHAMAN"] = 86477,
	["WARLOCK"] = 86478,
	["WARRIOR"] = 86479,
};

MCFPAPERDOLL_SIDEBARS = {
	{
		name=PAPERDOLL_SIDEBAR_STATS;
		frame="MCFCharacterStatsPane";
		icon = nil;  -- Uses the character portrait
		texCoords = {0.109375, 0.890625, 0.09375, 0.90625};
	},
	{
		name=PAPERDOLL_SIDEBAR_TITLES;
		frame="MCFPaperDollTitlesPane";
		icon = "Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.32421875, 0.46093750};
	},
	{
		name=PAPERDOLL_EQUIPMENTMANAGER;
		frame="MCFPaperDollEquipmentManagerPane";
		icon = "Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.46875000, 0.60546875};
	},
};

MCFPAPERDOLL_STATINFO = {

	-- General
	["HEALTH"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetHealth(statFrame, unit); end
	},
	["POWER"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetPower(statFrame, unit); end
	},
	["DRUIDMANA"] = {
		-- Only appears for Druids when in shapeshift form
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetDruidMana(statFrame, unit); end
	},
	--[[ ["MASTERY"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetMastery(statFrame, unit); end
	}, ]] --MCFFIX disabled Mastery because it doesn't exist in WotLK Classic
	["ITEMLEVEL"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetItemLevel(statFrame, unit); end
	},
	["MOVESPEED"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetMovementSpeed(statFrame, unit); end
	},
	
	-- Base stats
	["STRENGTH"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetStat(statFrame, unit, 1); end 
	},
	["AGILITY"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetStat(statFrame, unit, 2); end 
	},
	["STAMINA"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetStat(statFrame, unit, 3); end 
	},
	["INTELLECT"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetStat(statFrame, unit, 4); end 
	},
	["SPIRIT"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetStat(statFrame, unit, 5); end 
	},
	
	-- Melee
	["MELEE_DAMAGE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetDamage(statFrame, unit); end
	},
	["MELEE_DPS"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetMeleeDPS(statFrame, unit); end
	},
	["MELEE_AP"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetAttackPower(statFrame, unit); end
	},
	["MELEE_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetAttackSpeed(statFrame, unit); end
	},
	["HASTE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetMeleeHaste(statFrame, unit); end
	},
	["HITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetMeleeHitChance(statFrame, unit); end
	}, 
	["CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetMeleeCritChance(statFrame, unit); end
	},
	["EXPERTISE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetExpertise(statFrame, unit); end
	}, 
	["ENERGY_REGEN"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetEnergyRegen(statFrame, unit); end
	},
	["RUNE_REGEN"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRuneRegen(statFrame, unit); end
	},
	
	-- Ranged
	["RANGED_DAMAGE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedDamage(statFrame, unit); end
	},
	["RANGED_DPS"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedDPS(statFrame, unit); end
	},
	["RANGED_AP"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedAttackPower(statFrame, unit); end
	},
	["RANGED_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedAttackSpeed(statFrame, unit); end
	},
	["RANGED_CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedCritChance(statFrame, unit); end
	},
	["RANGED_HITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedHitChance(statFrame, unit); end
	}, 
	["RANGED_HASTE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetRangedHaste(statFrame, unit); end
	},
	["FOCUS_REGEN"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetFocusRegen(statFrame, unit); end
	},
	
	-- Spell
	["SPELLDAMAGE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetSpellBonusDamage(statFrame, unit); end
	},
	["SPELLHEALING"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetSpellBonusHealing(statFrame, unit); end
	},
	["SPELL_HASTE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetSpellHaste(statFrame, unit); end
	},
	["SPELL_HITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetSpellHitChance(statFrame, unit); end
	},
	["SPELL_PENETRATION"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetSpellPenetration(statFrame, unit); end
	},
	["MANAREGEN"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetManaRegen(statFrame, unit); end
	},
	["COMBATMANAREGEN"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetCombatManaRegen(statFrame, unit); end
	},
	["SPELLCRIT"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetSpellCritChance(statFrame, unit); end
	},
	
	-- Defense
	["ARMOR"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetArmor(statFrame, unit); end
	},
	["DODGE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetDodge(statFrame, unit); end
	},
	["PARRY"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetParry(statFrame, unit); end
	},
	["BLOCK"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetBlock(statFrame, unit); end
	},
	["RESILIENCE_REDUCTION"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResilience(statFrame, unit); end
	},
	["RESILIENCE_CRIT"] = {
		-- TODO
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResilience(statFrame, unit); end
	},
	
	-- Resistance
	["ARCANE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResistance(statFrame, unit, 6); end
	},
	["FIRE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResistance(statFrame, unit, 2); end
	},
	["FROST"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResistance(statFrame, unit, 3); end
	},
	["NATURE"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResistance(statFrame, unit, 4); end
	},
	["SHADOW"] = {
		updateFunc = function(statFrame, unit) MCFPaperDollFrame_SetResistance(statFrame, unit, 5); end
	},
};

-- Warning: Avoid changing the IDs, since this will screw up the cvars that remember which categories a player has collapsed
MCFPAPERDOLL_STATCATEGORIES = {
	["GENERAL"] = {
			id = 1,
			stats = { 
				"HEALTH",
				"DRUIDMANA",  -- Only appears for Druids when in bear/cat form
				"POWER",
				"ITEMLEVEL",
				"MOVESPEED",
			}
	},
						
	["ATTRIBUTES"] = {
			id = 2,
			stats = {
				"STRENGTH",
				"AGILITY",
				"STAMINA",
				"INTELLECT",
				"SPIRIT"
			}
	},
					
	["MELEE"] = {
			id = 3,
			stats = {
				"MELEE_DAMAGE", 
				"MELEE_DPS", 
				"MELEE_AP", 
				"MELEE_ATTACKSPEED", 
				"HASTE", 
				"ENERGY_REGEN",
				"RUNE_REGEN",
				"HITCHANCE", 
				"CRITCHANCE", 
				"EXPERTISE", 
				--[[ "MASTERY", ]] --MCFFIX disabled Mastery because it doesn't exist in WotLK Classic
			}
	},
				
	["RANGED"] = {
			id = 4,
			stats = {
				"RANGED_DAMAGE", 
				"RANGED_DPS", 
				"RANGED_AP", 
				"RANGED_ATTACKSPEED", 
				"RANGED_HASTE",
				"FOCUS_REGEN",
				"RANGED_HITCHANCE",
				"RANGED_CRITCHANCE", 
				--[[ "MASTERY", ]] --MCFFIX disabled Mastery because it doesn't exist in WotLK Classic
			}
	},
				
	["SPELL"] = {
			id = 5,
			stats = {
				"SPELLDAMAGE",    -- If Damage and Healing are the same, this changes to Spell Power
				"SPELLHEALING",    -- If Damage and Healing are the same, this is hidden
				"SPELL_HASTE", 
				"SPELL_HITCHANCE",
				"SPELL_PENETRATION",
				"MANAREGEN",
				"COMBATMANAREGEN",
				"SPELLCRIT",
				--[[ "MASTERY", ]] --MCFFIX disabled Mastery because it doesn't exist in WotLK Classic
			}
	},
			
	["DEFENSE"] = {
			id = 6,
			stats = {
				"ARMOR", 
				"DODGE",
				"PARRY", 
				"BLOCK",
				"RESILIENCE_REDUCTION", 
				--"RESILIENCE_CRIT",
			}
	},

	["RESISTANCE"] = {
			id = 7,
			stats = {
				"ARCANE", 
				"FIRE", 
				"FROST", 
				"NATURE", 
				"SHADOW",
			}
	},
};

MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER = {
	"GENERAL",
	"ATTRIBUTES",
	"MELEE",
	"RANGED",
	"SPELL",
	"DEFENSE",
	"RESISTANCE",
};

MCFBASE_MISS_CHANCE_PHYSICAL = {
	[0] = 5.0;
	[1] = 5.5;
	[2] = 6.0;
	[3] = 8.0;
};

MCFBASE_MISS_CHANCE_SPELL = {
	[0] = 4.0;
	[1] = 5.0;
	[2] = 6.0;
	[3] = 17.0;
};

MCFBASE_ENEMY_DODGE_CHANCE = {
	[0] = 5.0;
	[1] = 5.5;
	[2] = 6.0;
	[3] = 6.5;
};

MCFBASE_ENEMY_PARRY_CHANCE = {
	[0] = 5.0;
	[1] = 5.5;
	[2] = 6.0;
	[3] = 14.0;
};

MCFDUAL_WIELD_HIT_PENALTY = 19.0;

--MCFFIX READY
--Commented out a few events that don't exist anymore
function MCFPaperDollFrame_OnLoad (self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("UNIT_MODEL_CHANGED");
	self:RegisterEvent("UNIT_LEVEL");
	self:RegisterEvent("UNIT_RESISTANCES");
	self:RegisterEvent("UNIT_STATS");
	self:RegisterEvent("UNIT_DAMAGE");
	self:RegisterEvent("UNIT_RANGEDDAMAGE");
	self:RegisterEvent("UNIT_ATTACK_SPEED");
	self:RegisterEvent("UNIT_ATTACK_POWER");
	self:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
	self:RegisterEvent("UNIT_ATTACK");
	self:RegisterEvent("UNIT_SPELL_HASTE");
	self:RegisterEvent("PLAYER_GUILD_UPDATE");
	self:RegisterEvent("SKILL_LINES_CHANGED");
	self:RegisterEvent("COMBAT_RATING_UPDATE");
	--self:RegisterEvent("MASTERY_UPDATE");
	--self:RegisterEvent("KNOWN_TITLES_UPDATE");
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	--self:RegisterEvent("PLAYER_BANKSLOTS_CHANGED");
	--self:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_READY");
	self:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	self:RegisterEvent("UNIT_MAXHEALTH");
	-- flyout settings
	MCFPaperDollItemsFrame.flyoutSettings = {
		onClickFunc = MCFPaperDollFrameItemFlyoutButton_OnClick,
		getItemsFunc = MCFPaperDollFrameItemFlyout_GetItems,
		postGetItemsFunc = MCFPaperDollFrameItemFlyout_PostGetItems, 
		hasPopouts = true,
		parent = MCFPaperDollFrame,
		anchorX = 0,
		anchorY = -3,
		verticalAnchorX = 0,
		verticalAnchorY = 0,
	};
	MCFPaperDollFrame_UpdateStats(); -- MCFFIX added this force update because for some reason stats don't get updated at first open
end

--MCFFIX READY
function MCFPaperDoll_IsEquippedSlot (slot)
	if ( slot ) then
		slot = tonumber(slot);
		if ( slot ) then
			return slot >= EQUIPPED_FIRST and slot <= EQUIPPED_LAST;
		end
	end
	return false;
end

--MCFFIX READY
function MCFCharacterModelFrame_OnMouseUp (self, button)
	if ( button == "LeftButton" ) then
		AutoEquipCursorItem();
	end
	Model_OnMouseUp(self, button);
end

--MCFFIX READY
-- This makes sure the update only happens once at the end of the frame
function MCFPaperDollFrame_QueuedUpdate(self)
	MCFPaperDollFrame_UpdateStats();
	self:SetScript("OnUpdate", nil);
end

--MCFFIX READY need to replace old event handlers
function MCFPaperDollFrame_OnEvent (self, event, ...)
	local unit = ...;
	if ( event == "PLAYER_ENTERING_WORLD" or
		event == "UNIT_MODEL_CHANGED" and unit == "player" ) then
		MCFCharacterModelFrame:SetUnit("player");
		return;
	
	elseif ( --[[ event == "KNOWN_TITLES_UPDATE" or ( ]]event == "UNIT_NAME_UPDATE" and unit == "player"--[[ ) ]]) then
		if (MCFPaperDollTitlesPane:IsShown()) then
			MCFPaperDollTitlesPane_Update();
		end
	end
	
	if ( not self:IsVisible() ) then
		return;
	end
	
	if ( unit == "player" ) then
		if ( event == "UNIT_LEVEL" ) then
			MCFPaperDollFrame_SetLevel();
		elseif ( event == "UNIT_DAMAGE" or event == "UNIT_ATTACK_SPEED" or event == "UNIT_RANGEDDAMAGE" or event == "UNIT_ATTACK" or event == "UNIT_STATS" or event == "UNIT_RANGED_ATTACK_POWER" or event == "UNIT_RESISTANCES" or event == "UNIT_SPELL_HASTE" or event == "UNIT_MAXHEALTH" ) then
			self:SetScript("OnUpdate", MCFPaperDollFrame_QueuedUpdate);
		end
	end
	
	if ( event == "COMBAT_RATING_UPDATE" or event=="MASTERY_UPDATE" or event == "BAG_UPDATE" or event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_BANKSLOTS_CHANGED" or event == "PLAYER_AVG_ITEM_LEVEL_READY" or event == "PLAYER_DAMAGE_DONE_MODS") then
		self:SetScript("OnUpdate", MCFPaperDollFrame_QueuedUpdate);
	elseif (event == "VARIABLES_LOADED") then
		if (MCF_GetSettings("characterFrameCollapsed") ~= "0") then
			MCFCharacterFrame_Collapse();
		else
			MCFCharacterFrame_Expand();
		end
		
		local activeSpec = GetActiveTalentGroup();
		if (activeSpec == 1) then
			MCFPaperDoll_InitStatCategories(MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
		else
			MCFPaperDoll_InitStatCategories(MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
		end
	elseif (event == "PLAYER_TALENT_UPDATE") then
		MCFPaperDollFrame_SetLevel();
		self:SetScript("OnUpdate", MCFPaperDollFrame_QueuedUpdate);
	elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
		local activeSpec = GetActiveTalentGroup();
		if (activeSpec == 1) then
			MCFPaperDoll_InitStatCategories(MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
		else
			MCFPaperDoll_InitStatCategories(MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
		end
	end
end

function MCF_GetPrimaryTalentTree(tab)
	local cache = {};
	if (tab) then
		TalentFrame_UpdateSpecInfoCache(cache, false, false, tab);
	else
		TalentFrame_UpdateSpecInfoCache(cache, false, false, GetActiveTalentGroup());
	end
	return cache.primaryTabIndex;
end

--MCFFIX READY
function MCFPaperDollFrame_SetLevel()
	local primaryTalentTree = MCF_GetPrimaryTalentTree();
	local classDisplayName, class = UnitClass("player"); 
	local classColor = RAID_CLASS_COLORS[class];
	local classColorString = format("ff%.2x%.2x%.2x", classColor.r * 255, classColor.g * 255, classColor.b * 255);
	local specName, _;
	
	if (primaryTalentTree) then
		specName = GetTalentTabInfo(primaryTalentTree);
	end
	
	if (specName and specName ~= "") then
		MCFCharacterLevelText:SetFormattedText(MCF_PLAYER_LEVEL, UnitLevel("player"), classColorString, specName, classDisplayName);
	else
		MCFCharacterLevelText:SetFormattedText(MCF_PLAYER_LEVEL_NO_SPEC, UnitLevel("player"), classColorString, classDisplayName);
	end
	
	-- Hack: if the string is very long, move it a bit so that it has more room (although it will no longer be centered)
	if (MCFCharacterLevelText:GetWidth() > 210) then
		if (MCFCharacterFrameInsetRight:IsVisible()) then
			MCFCharacterLevelText:SetPoint("TOP", -10, -36);
		else
			MCFCharacterLevelText:SetPoint("TOP", 10, -36);
		end
	else
		MCFCharacterLevelText:SetPoint("TOP", 0, -36);
	end
	
	--[[ if IsTrialAccount() then
		local rLevel = GetRestrictedAccountData();
		if UnitLevel("player") >= rLevel then
			MCFCharacterTrialLevelErrorText:Show();
		end
	end ]]
end

--MCFFIX READY
function MCFGetMeleeMissChance(levelOffset, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCFBASE_MISS_CHANCE_PHYSICAL[levelOffset];
	chance = chance - GetCombatRatingBonus(CR_HIT_MELEE);--[[  - GetHitModifier(); ]] --MCFFIX this function gives different result
	if (IsDualWielding() and not special) then
		chance = chance + MCFDUAL_WIELD_HIT_PENALTY;
	end
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

--MCFFIX READY
function MCFGetRangedMissChance(levelOffset, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCFBASE_MISS_CHANCE_PHYSICAL[levelOffset];
	chance = chance - GetCombatRatingBonus(CR_HIT_RANGED);--[[  - GetHitModifier(); ]] --MCFFIX this function gives different result
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

--MCFFIX READY
function MCFGetSpellMissChance(levelOffset, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCFBASE_MISS_CHANCE_SPELL[levelOffset];
	chance = chance - GetCombatRatingBonus(CR_HIT_SPELL);--[[  - GetSpellHitModifier(); ]] --MCFFIX this function gives different result
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

--MCFFIX READY
function MCFGetEnemyDodgeChance(levelOffset)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCFBASE_ENEMY_DODGE_CHANCE[levelOffset];
	local offhandChance = MCFBASE_ENEMY_DODGE_CHANCE[levelOffset];
	local expertisePct, offhandExpertisePct = GetExpertisePercent();
	chance = chance - expertisePct;
	offhandChance = offhandChance - offhandExpertisePct;
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	if (offhandChance < 0) then
		offhandChance = 0;
	elseif (offhandChance > 100) then
		offhandChance = 100;
	end
	return chance, offhandChance;
end

--MCFFIX ready
function MCFGetEnemyParryChance(levelOffset)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCFBASE_ENEMY_PARRY_CHANCE[levelOffset];
	local offhandChance = MCFBASE_ENEMY_PARRY_CHANCE[levelOffset];
	local expertisePct, offhandExpertisePct = GetExpertisePercent();
	chance = chance - expertisePct;
	offhandChance = offhandChance - offhandExpertisePct;
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	if (offhandChance < 0) then
		offhandChance = 0;
	elseif (offhandChance > 100) then
		offhandChance = 100;
	end
	return chance, offhandChance;
end

--MCFFIX ready
function MCFPaperDollFrame_SetHealth(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local health = UnitHealthMax(unit);
	MCFPaperDollFrame_SetLabelAndText(statFrame, HEALTH, health, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, HEALTH).." "..health..FONT_COLOR_CODE_CLOSE;
	if (unit == "player") then
		statFrame.tooltip2 = STAT_HEALTH_TOOLTIP;
	elseif (unit == "pet") then
		statFrame.tooltip2 = STAT_HEALTH_PET_TOOLTIP;
	end
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetPower(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local powerType, powerToken = UnitPowerType(unit);
	local power = UnitPowerMax(unit) or 0;
	if (powerToken and _G[powerToken]) then
		MCFPaperDollFrame_SetLabelAndText(statFrame, _G[powerToken], power, false);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G[powerToken]).." "..power..FONT_COLOR_CODE_CLOSE;
		statFrame.tooltip2 = _G["STAT_"..powerToken.."_TOOLTIP"];
		statFrame:Show();
	else
		statFrame:Hide();
	end
end

--MCFFIX ready
function MCFPaperDollFrame_SetDruidMana(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local _, class = UnitClass(unit);
	if (class ~= "DRUID") then
		statFrame:Hide();
		return;
	end
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken == "MANA") then
		statFrame:Hide();
		return;
	end
	
	local power = UnitPowerMax(unit, 0);
	MCFPaperDollFrame_SetLabelAndText(statFrame, MANA, power, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MANA).." "..power..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = _G["STAT_MANA_TOOLTIP"];
	statFrame:Show();
end

--MCFFIX READY (NEEDS INTELLECT REWORK)
function MCFPaperDollFrame_SetStat(statFrame, unit, statIndex)
	local label = _G[statFrame:GetName().."Label"];
	local text = _G[statFrame:GetName().."StatText"];
	local stat;
	local effectiveStat;
	local posBuff;
	local negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex);
	local statName = _G["SPELL_STAT"..statIndex.."_NAME"];
	label:SetText(format(STAT_FORMAT, statName));
	
	-- Set the tooltip text
	local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, statName).." ";

	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text:SetText(effectiveStat);
		statFrame.tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE;
	else 
		tooltipText = tooltipText..effectiveStat;
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end
		statFrame.tooltip = tooltipText;

		-- If there are any negative buffs then show the main number in red even if there are
		-- positive buffs. Otherwise show in green.
		if ( negBuff < 0 ) then
			text:SetText(RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
		else
			text:SetText(GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
		end
	end
	statFrame.tooltip2 = _G["MCF_DEFAULT_STAT"..statIndex.."_TOOLTIP"];
	
	if (unit == "player") then
		local _, unitClass = UnitClass("player");
		unitClass = strupper(unitClass);
		
		-- Strength
		if ( statIndex == 1 ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
		-- Agility
		elseif ( statIndex == 2 ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			if ( attackPower > 0 ) then
				statFrame.tooltip2 = format(STAT_TOOLTIP_BONUS_AP, attackPower) .. format(statFrame.tooltip2, GetCritChanceFromAgility("player"));
			else
				statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("player"));
			end
		-- Stamina
		elseif ( statIndex == 3 ) then
			local baseStam = min(20, effectiveStat);
			local moreStam = effectiveStat - baseStam;
			statFrame.tooltip2 = format(statFrame.tooltip2, (baseStam + (moreStam*UnitHPPerStamina("player")))*GetUnitMaxHealthModifier("player"));
		-- Intellect
		elseif ( statIndex == 4 ) then
			if ( UnitHasMana("player") ) then
				local baseInt = min(20, effectiveStat);
				local moreInt = effectiveStat - baseInt
				if ( UnitHasMana("player") ) then
					statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt*MANA_PER_INTELLECT, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("player"));
				else
					statFrame.tooltip2 = nil;
				end
				--[[ if (GetOverrideSpellPowerByAP() ~= nil) then
					statFrame.tooltip2 = format(STAT4_NOSPELLPOWER_TOOLTIP, baseInt + moreInt*MANA_PER_INTELLECT, GetSpellCritChanceFromIntellect("player"));
				else
					statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt*MANA_PER_INTELLECT, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("player"));
				end ]] --MCFFIX wrote another condition
			else
				statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
			end
		-- Spirit
		elseif ( statIndex == 5 ) then
			-- All mana regen stats are displayed as mana/5 sec.
			if ( UnitHasMana("player") ) then
				local regen = GetUnitManaRegenRateFromSpirit("player");
				regen = floor( regen * 5.0 );
				statFrame.tooltip2 = format(MCF_MANA_REGEN_FROM_SPIRIT, regen);
			else
				statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
			end
		end
	elseif (unit == "pet") then
		if ( statIndex == 1 ) then
			local attackPower = effectiveStat-20;
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
		elseif ( statIndex == 2 ) then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("pet"));
		elseif ( statIndex == 3 ) then
			local expectedHealthGain = (((stat - posBuff - negBuff)-20)*10+20)*GetUnitHealthModifier("pet");
			local realHealthGain = ((effectiveStat-20)*10+20)*GetUnitHealthModifier("pet");
			local healthGain = (realHealthGain - expectedHealthGain)*GetUnitMaxHealthModifier("pet");
			statFrame.tooltip2 = format(statFrame.tooltip2, healthGain);
		elseif ( statIndex == 4 ) then
			if ( UnitHasMana("pet") ) then
				local manaGain = ((effectiveStat-20)*15+20)*GetUnitPowerModifier("pet");
				statFrame.tooltip2 = format(statFrame.tooltip2, manaGain, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("pet"));
			else
				statFrame.tooltip2 = nil;
			end
		elseif ( statIndex == 5 ) then
			statFrame.tooltip2 = "";
			if ( UnitHasMana("pet") ) then
				statFrame.tooltip2 = format(MCF_MANA_REGEN_FROM_SPIRIT, GetUnitManaRegenRateFromSpirit("pet"));
			end
		end
	end
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetResistance(statFrame, unit, resistanceIndex)
	local base, resistance, positive, negative = UnitResistance(unit, resistanceIndex);
	local resistanceNameShort = _G["DAMAGE_SCHOOL"..resistanceIndex];
	local resistanceName = _G["RESISTANCE"..resistanceIndex.."_NAME"];
	local resistanceIconCode = "|TInterface\\PaperDollInfoFrame\\SpellSchoolIcon"..(resistanceIndex+1)..":0|t";
	_G[statFrame:GetName().."Label"]:SetText(resistanceIconCode.." "..format(STAT_FORMAT, resistanceNameShort));
	local text = _G[statFrame:GetName().."StatText"];
	MCFPaperDollFormatStat(resistanceName, base, positive, negative, statFrame, text);
	statFrame.tooltip = resistanceIconCode.." "..HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, resistanceName).." "..resistance..FONT_COLOR_CODE_CLOSE;
	
	if ( positive ~= 0 or negative ~= 0 ) then
		statFrame.tooltip = statFrame.tooltip.. " ( "..HIGHLIGHT_FONT_COLOR_CODE..base;
		if( positive > 0 ) then
			statFrame.tooltip = statFrame.tooltip..GREEN_FONT_COLOR_CODE.." +"..positive;
		end
		if( negative < 0 ) then
			statFrame.tooltip = statFrame.tooltip.." "..RED_FONT_COLOR_CODE..negative;
		end
		statFrame.tooltip = statFrame.tooltip..FONT_COLOR_CODE_CLOSE.." )";
	end
	
	statFrame.tooltip2 = format(MCF_RESISTANCE_TOOLTIP_SUBTEXT, _G["SPELL_SCHOOL"..resistanceIndex.."_CAP"], ResistancePercent(resistance, UnitLevel(unit)));
	
	-- TODO: Put this in the tooltip?
	--local petBonus = ComputePetBonus( "PET_BONUS_RES", resistance );
end

--MCFFIX READY
function MCFPaperDollFrame_SetArmor(statFrame, unit)
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit);
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, ARMOR));
	local text = _G[statFrame:GetName().."StatText"];

	MCFPaperDollFormatStat(ARMOR, base, posBuff, negBuff, statFrame, text);
	local armorReduction = MCFPaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel(unit));
	statFrame.tooltip2 = format(DEFAULT_STATARMOR_TOOLTIP, armorReduction);
	
	if ( unit == "player" ) then
		local petBonus = MCFComputePetBonus("PET_BONUS_ARMOR", effectiveArmor );
		if( petBonus > 0 ) then
			statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_ARMOR, petBonus);
		end
	end
	
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetDodge(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end
	
	local chance = GetDodgeChance();
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_DODGE, chance, 1);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, DODGE_CHANCE).." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE));
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetBlock(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end
	
	local chance = GetBlockChance();
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_BLOCK, chance, 1);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, BLOCK_CHANCE).." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(MCF_CR_BLOCK_TOOLTIP, GetCombatRating(CR_BLOCK), GetCombatRatingBonus(CR_BLOCK), GetShieldBlock());
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetParry(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end
	
	local chance = GetParryChance();
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_PARRY, chance, 1);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, PARRY_CHANCE).." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY));
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetResilience(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end

	local damageResilience = GetCombatRating(CR_RESILIENCE_CRIT_TAKEN);
	local damageRatingBonus = GetCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN);
	local maxBonus = GetMaxCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN);
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_RESILIENCE, damageResilience);
	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RESILIENCE).." "..damageResilience..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(RESILIENCE_TOOLTIP, damageRatingBonus, min(damageRatingBonus * RESILIENCE_CRIT_CHANCE_TO_DAMAGE_REDUCTION_MULTIPLIER, maxBonus), damageRatingBonus * RESILIENCE_CRIT_CHANCE_TO_CONSTANT_DAMAGE_REDUCTION_MULTIPLIER);
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetDamage(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DAMAGE));
	local text = _G[statFrame:GetName().."StatText"];
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	
	local minDamage;
	local maxDamage; 
	local minOffHandDamage;
	local maxOffHandDamage; 
	local physicalBonusPos;
	local physicalBonusNeg;
	local percent;
	minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond = (max(fullDamage,1) / speed);
	local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	
	local colorPos = "|cff20ff20";
	local colorNeg = "|cffff2020";

	-- epsilon check
	if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
		totalBonus = 0.0;
	end

	if ( totalBonus == 0 ) then
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(displayMin.." - "..displayMax);	
		else
			text:SetText(displayMin.."-"..displayMax);
		end
	else
		
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(color..displayMin.." - "..displayMax.."|r");	
		else
			text:SetText(color..displayMin.."-"..displayMax.."|r");
		end
		if ( physicalBonusPos > 0 ) then
			damageTooltip = damageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			damageTooltip = damageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			damageTooltip = damageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			damageTooltip = damageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		
	end
	statFrame.damage = damageTooltip;
	statFrame.attackSpeed = speed;
	statFrame.dps = damagePerSecond;
	statFrame.unit = unit;
	
	-- If there's an offhand speed then add the offhand info to the tooltip
	if ( offhandSpeed ) then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandDamageTooltip = max(floor(minOffHandDamage),1).." - "..max(ceil(maxOffHandDamage),1);
		if ( physicalBonusPos > 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		statFrame.offhandDamage = offhandDamageTooltip;
		statFrame.offhandAttackSpeed = offhandSpeed;
		statFrame.offhandDps = offhandDamagePerSecond;
	else
		statFrame.offhandAttackSpeed = nil;
	end
	
	statFrame:SetScript("OnEnter", MCFCharacterDamageFrame_OnEnter);
	
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetMeleeDPS(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MCF_STAT_DPS_SHORT));
	local text = _G[statFrame:GetName().."StatText"];
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	
	local minDamage;
	local maxDamage; 
	local minOffHandDamage;
	local maxOffHandDamage; 
	local physicalBonusPos;
	local physicalBonusNeg;
	local percent;
	minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond = (max(fullDamage,1) / speed);
	local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	
	local colorPos = "|cff20ff20";
	local colorNeg = "|cffff2020";
	local text;

	-- epsilon check
	if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
		totalBonus = 0.0;
	end

	if ( totalBonus == 0 ) then
		text = format("%.1F", damagePerSecond);
	else
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		text = color..format("%.1F", damagePerSecond).."|r";
	end
	
	-- If there's an offhand speed then add the offhand info
	if ( offhandSpeed ) then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandTotalBonus = (offhandFullDamage - offhandBaseDamage);
		
		-- epsilon check
		if ( offhandTotalBonus < 0.1 and offhandTotalBonus > -0.1 ) then
			offhandTotalBonus = 0.0;
		end
		local separator = " / ";
		if (damagePerSecond > 1000 and offhandDamagePerSecond > 1000) then
			separator = "/";
		end
		if ( offhandTotalBonus == 0 ) then
			text = text..separator..format("%.1F", offhandDamagePerSecond);
		else
			local color;
			if ( offhandTotalBonus > 0 ) then
				color = colorPos;
			else
				color = colorNeg;
			end
			text = text..separator..color..format("%.1F", offhandDamagePerSecond).."|r";	
		end
	end
	
	statFrame.Value:SetText(text);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetRangedDPS(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MCF_STAT_DPS_SHORT));
	local text = _G[statFrame:GetName().."StatText"];

	-- If no ranged attack then set to n/a
	local hasRelic = UnitHasRelicSlot(unit);	
	local rangedTexture = GetInventoryItemTexture("player", 18);
	if ( rangedTexture and not hasRelic ) then
		MCFPaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		MCFPaperDollFrame.noRanged = 1;
		statFrame.damage = nil;
		return;
	end

	local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitRangedDamage(unit);
	
	-- Round to the third decimal place (i.e. 99.9 percent)
	percent = math.floor(percent  * 10^3 + 0.5) / 10^3
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	local baseDamage;
	local fullDamage;
	local totalBonus;
	local damagePerSecond;
	local tooltip;

	if ( HasWandEquipped() ) then
		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = baseDamage * percent;
		totalBonus = 0;
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	else
		minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		totalBonus = (fullDamage - baseDamage);
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	end

	if ( totalBonus == 0 ) then
		text:SetText( format("%.1F", damagePerSecond));
	else
		local colorPos = "|cff20ff20";
		local colorNeg = "|cffff2020";
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		text:SetText(color..format("%.1F", damagePerSecond).."|r");
		if ( physicalBonusPos > 0 ) then
			tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		--statFrame.tooltip2 = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
	end

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetAttackSpeed(statFrame, unit)
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	speed = format("%.2F", speed);
	if ( offhandSpeed ) then
		offhandSpeed = format("%.2F", offhandSpeed);
	end
	local text;	
	if ( offhandSpeed ) then
		text = speed.." / "..offhandSpeed;
	else
		text = speed;
	end
	MCFPaperDollFrame_SetLabelAndText(statFrame, MCF_WEAPON_SPEED, text);

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..text..FONT_COLOR_CODE_CLOSE;
	
	statFrame:Show();
end

--MCFFIX READY (needs improvement because function GetOverrideSpellPowerByAP() doesn't work anymore)
function MCFPaperDollFrame_SetAttackPower(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, ATTACK_POWER));
	local text = _G[statFrame:GetName().."StatText"];
	local base, posBuff, negBuff = UnitAttackPower(unit);

	MCFPaperDollFormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff, statFrame, text);
	local damageBonus = max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER;
	local effectiveAP = max(0,base + posBuff + negBuff);
	--[[ if (GetOverrideSpellPowerByAP() ~= nil) then
		statFrame.tooltip2 = format(MELEE_ATTACK_POWER_SPELL_POWER_TOOLTIP, damageBonus, effectiveAP * GetOverrideSpellPowerByAP() + 0.5);
	else
		statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, damageBonus);
	end ]] --MCFFIX disabled if condition, copied tooltip generation (next line)
	statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, damageBonus);
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetRangedAttack(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	local hasRelic = UnitHasRelicSlot(unit);
	local rangedAttackBase, rangedAttackMod = UnitRangedAttack(unit);
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, COMBAT_RATING_NAME1));
	local text = _G[statFrame:GetName().."StatText"];

	-- If no ranged texture then set stats to n/a
	local rangedTexture = GetInventoryItemTexture("player", 18);
	if ( rangedTexture and not hasRelic ) then
		MCFPaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		MCFPaperDollFrame.noRanged = 1;
		statFrame.tooltip = nil;
		return;
	end
	
	if( rangedAttackMod == 0 ) then
		text:SetText(rangedAttackBase);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..rangedAttackBase..FONT_COLOR_CODE_CLOSE;
	else
		local color = RED_FONT_COLOR_CODE;
		if( rangedAttackMod > 0 ) then
	  		color = GREEN_FONT_COLOR_CODE;
			statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..(rangedAttackBase + rangedAttackMod).." ("..rangedAttackBase..color.." +"..rangedAttackMod..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
		else
			statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..(rangedAttackBase + rangedAttackMod).." ("..rangedAttackBase..color.." "..rangedAttackMod..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
		end
		text:SetText(color..(rangedAttackBase + rangedAttackMod)..FONT_COLOR_CODE_CLOSE);
	end
	local total = GetCombatRating(CR_WEAPON_SKILL) + GetCombatRating(CR_WEAPON_SKILL_RANGED);
	statFrame.tooltip2 = format(WEAPON_SKILL_RATING, total);
	if ( total > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2..format(WEAPON_SKILL_RATING_BONUS, GetCombatRatingBonus(CR_WEAPON_SKILL) + GetCombatRatingBonus(CR_WEAPON_SKILL_RANGED));
	end
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetRangedDamage(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DAMAGE));
	local text = _G[statFrame:GetName().."StatText"];

	-- If no ranged attack then set to n/a
	local hasRelic = UnitHasRelicSlot(unit);	
	local rangedTexture = GetInventoryItemTexture("player", 18);
	if ( rangedTexture and not hasRelic ) then
		MCFPaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		MCFPaperDollFrame.noRanged = 1;
		statFrame.damage = nil;
		return;
	end

	local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitRangedDamage(unit);
	
	-- Round to the third decimal place (i.e. 99.9 percent)
	percent = math.floor(percent  * 10^3 + 0.5) / 10^3
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	local baseDamage;
	local fullDamage;
	local totalBonus;
	local damagePerSecond;
	local tooltip;

	if ( HasWandEquipped() ) then
		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = baseDamage * percent;
		totalBonus = 0;
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	else
		minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		totalBonus = (fullDamage - baseDamage);
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	end

	if ( totalBonus == 0 ) then
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(displayMin.." - "..displayMax);	
		else
			text:SetText(displayMin.."-"..displayMax);
		end
	else
		local colorPos = "|cff20ff20";
		local colorNeg = "|cffff2020";
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(color..displayMin.." - "..displayMax.."|r");	
		else
			text:SetText(color..displayMin.."-"..displayMax.."|r");
		end
		if ( physicalBonusPos > 0 ) then
			tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		statFrame.tooltip = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
	end
	statFrame.attackSpeed = rangedAttackSpeed;
	statFrame.damage = tooltip;
	statFrame.dps = damagePerSecond;
	statFrame:SetScript("OnEnter", MCFCharacterRangedDamageFrame_OnEnter);
	statFrame:Show();
end

--MCFFIX READY ? Needs testing because values are weird
function MCFPaperDollFrame_SetRangedAttackSpeed(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	local text;
	-- If no ranged attack then set to n/a
	if ( MCFPaperDollFrame.noRanged ) then
		text = NOT_APPLICABLE;
		statFrame.tooltip = nil;
	else
		text = UnitRangedDamage(unit);
		text = format("%.2F", text);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..text..FONT_COLOR_CODE_CLOSE;
	end
	MCFPaperDollFrame_SetLabelAndText(statFrame, MCF_WEAPON_SPEED, text);
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetRangedAttackPower(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, ATTACK_POWER));
	local text = _G[statFrame:GetName().."StatText"];
	local base, posBuff, negBuff = UnitRangedAttackPower(unit);

	MCFPaperDollFormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff, statFrame, text);
	local totalAP = base+posBuff+negBuff;
	statFrame.tooltip2 = format(RANGED_ATTACK_POWER_TOOLTIP, max((totalAP), 0)/ATTACK_POWER_MAGIC_NUMBER);
	local petAPBonus = MCFComputePetBonus( "PET_BONUS_RAP_TO_AP", totalAP );
	if( petAPBonus > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_RANGED_ATTACK_POWER, petAPBonus);
	end
	
	local petSpellDmgBonus = MCFComputePetBonus( "PET_BONUS_RAP_TO_SPELLDMG", totalAP );
	if( petSpellDmgBonus > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_SPELLDAMAGE, petSpellDmgBonus);
	end
	
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetSpellBonusDamage(statFrame, unit)
	local text = _G[statFrame:GetName().."StatText"];
	local minModifier = 0;
	
	if (unit == "player") then
		local holySchool = 2;
		-- Start at 2 to skip physical damage
		minModifier = GetSpellBonusDamage(holySchool);
		
		if (statFrame.bonusDamage) then
			table.wipe(statFrame.bonusDamage);
		else
			statFrame.bonusDamage = {};
		end
		statFrame.bonusDamage[holySchool] = minModifier;
		for i=(holySchool+1), MAX_SPELL_SCHOOLS do
			local bonusDamage = GetSpellBonusDamage(i);
			minModifier = min(minModifier, bonusDamage);
			statFrame.bonusDamage[i] = bonusDamage;
		end
	elseif (unit == "pet") then
		minModifier = GetPetSpellBonusDamage();
		statFrame.bonusDamage = nil;
	end
	
	local spellHealing = GetSpellBonusHealing();
	if (spellHealing == minModifier) then
		_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLPOWER));
		statFrame.tooltip = STAT_SPELLPOWER;
		statFrame.tooltip2 = STAT_SPELLPOWER_TOOLTIP;
	else
		_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLDAMAGE));
		statFrame.tooltip = STAT_SPELLDAMAGE;
		statFrame.tooltip2 = STAT_SPELLDAMAGE_TOOLTIP;
	end
	
	text:SetText(minModifier);
	statFrame.minModifier = minModifier;
	statFrame.unit = unit;
	statFrame:SetScript("OnEnter", MCFCharacterSpellBonusDamage_OnEnter);
	statFrame:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_SetSpellBonusHealing(statFrame, unit)
	local text = _G[statFrame:GetName().."StatText"];
	local minDamage = 0;
	
	if (unit == "player") then
		local holySchool = 2;
		-- Start at 2 to skip physical damage
		minDamage = GetSpellBonusDamage(holySchool);		
		for i=(holySchool+1), MAX_SPELL_SCHOOLS do
			minDamage = min(minDamage, GetSpellBonusDamage(i));
		end
	elseif (unit == "pet") then
		--Healing is not needed for pets (see bug  238141)
		--minDamage = GetPetSpellBonusDamage();
		statFrame:Hide();
		return;
	end
	statFrame.bonusDamage = nil;
	
	local spellHealing = GetSpellBonusHealing();
	if (spellHealing == minDamage) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLHEALING));
	statFrame.tooltip = STAT_SPELLHEALING;
	statFrame.tooltip2 = STAT_SPELLHEALING_TOOLTIP;
	text:SetText(spellHealing);
	statFrame.minModifier = spellHealing;
	statFrame.unit = unit;
	statFrame:SetScript("OnEnter", MCFCharacterSpellBonusDamage_OnEnter);
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetSpellCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, SPELL_CRIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local holySchool = 2;
	-- Start at 2 to skip physical damage
	local minCrit = GetSpellCritChance(holySchool);
	statFrame.spellCrit = {};
	statFrame.spellCrit[holySchool] = minCrit;
	local spellCrit;
	for i=(holySchool+1), MAX_SPELL_SCHOOLS do
		spellCrit = GetSpellCritChance(i);
		minCrit = min(minCrit, spellCrit);
		statFrame.spellCrit[i] = spellCrit;
	end
	minCrit = format("%.2F%%", minCrit);
	text:SetText(minCrit);
	statFrame.minCrit = minCrit;
	statFrame:SetScript("OnEnter", MCFCharacterSpellCritChance_OnEnter);
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetMeleeCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MELEE_CRIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local critChance = GetCritChance();
	critChance = format("%.2F%%", critChance);
	text:SetText(critChance);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MELEE_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(MCF_CR_CRIT_MELEE_TOOLTIP, GetCombatRating(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_MELEE));
end

function MCFPaperDollFrame_SetRangedCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, RANGED_CRIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local critChance = GetRangedCritChance();
	critChance = format("%.2F%%", critChance);
	text:SetText(critChance);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, RANGED_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(MCF_CR_CRIT_RANGED_TOOLTIP, GetCombatRating(CR_CRIT_RANGED), GetCombatRatingBonus(CR_CRIT_RANGED));
end

--MCFFIX ready
function MCFMeleeHitChance_OnEnter(statFrame)

	if (MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	local hitChance = GetCombatRatingBonus(CR_HIT_MELEE);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(STAT_HIT_MELEE_TOOLTIP, GetCombatRating(CR_HIT_MELEE), GetCombatRatingBonus(CR_HIT_MELEE)));
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if (IsDualWielding()) then
		GameTooltip:AddLine(STAT_HIT_NORMAL_ATTACKS, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	end
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCFGetMeleeMissChance(i, false));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	if (IsDualWielding()) then
		GameTooltip:AddLine(STAT_HIT_SPECIAL_ATTACKS, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		for i=0, 3 do
			local missChance = format("%.2F%%", MCFGetMeleeMissChance(i, true));
			local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
			GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
	
	GameTooltip:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetMeleeHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local hitChance = GetCombatRatingBonus(CR_HIT_MELEE);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	text:SetText(hitChance);
	statFrame:SetScript("OnEnter", MCFMeleeHitChance_OnEnter);
	statFrame:Show();
end

--MCFFIX ready
function MCFRangedHitChance_OnEnter(statFrame)

	if (MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	local hitChance = GetCombatRatingBonus(CR_HIT_RANGED);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(STAT_HIT_RANGED_TOOLTIP, GetCombatRating(CR_HIT_RANGED), GetCombatRatingBonus(CR_HIT_RANGED)));
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCFGetRangedMissChance(i));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetRangedHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local hitChance = GetCombatRatingBonus(CR_HIT_RANGED);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	text:SetText(hitChance);
	statFrame:SetScript("OnEnter", MCFRangedHitChance_OnEnter);
	statFrame:Show();
end

--MCFFIX ready
function MCFSpellHitChance_OnEnter(statFrame)

	if (MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	local hitChance = GetCombatRatingBonus(CR_HIT_SPELL);--[[  + GetSpellHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(STAT_HIT_SPELL_TOOLTIP, GetCombatRating(CR_HIT_SPELL), GetCombatRatingBonus(CR_HIT_SPELL)));
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCFGetSpellMissChance(i));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetSpellHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local hitChance = GetCombatRatingBonus(CR_HIT_SPELL);--[[  + GetSpellHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	text:SetText(hitChance);
	statFrame:SetScript("OnEnter", MCFSpellHitChance_OnEnter);
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetEnergyRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken ~= "ENERGY") then
		statFrame:Hide();
		return;
	end
	
	local regenRate = GetPowerRegen();
	regenRate = format("%.2F", regenRate);
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, regenRate, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_ENERGY_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_ENERGY_REGEN_TOOLTIP;
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetFocusRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken ~= "FOCUS") then
		statFrame:Hide();
		return;
	end
	
	local regenRate = GetPowerRegen();
	regenRate = format("%.2F", regenRate);
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, regenRate, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_FOCUS_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_FOCUS_REGEN_TOOLTIP;
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetRuneRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local _, class = UnitClass(unit);
	if (class ~= "DEATHKNIGHT") then
		statFrame:Hide();
		return;
	end
	
	local _, regenRate = GetRuneCooldown(1); -- Assuming they are all the same for now
	regenRate = format(STAT_RUNE_REGEN_FORMAT, regenRate);
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, regenRate, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RUNE_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP;
	statFrame:Show();
end


--MCFFIX ready
function MCFPaperDollFrame_SetMeleeHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local haste = GetMeleeHaste();
	if (haste < 0) then
		haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
	else
		haste = "+"..format("%.2F%%", haste);
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, WEAPON_SPEED));	
	local text = _G[statFrame:GetName().."StatText"];
	text:SetText(haste);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, WEAPON_SPEED) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;
	
	local _, class = UnitClass(unit);	
	statFrame.tooltip2 = _G["STAT_HASTE_MELEE_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_MELEE_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(MCF_STAT_HASTE_BASE_TOOLTIP, GetCombatRating(CR_HASTE_MELEE), GetCombatRatingBonus(CR_HASTE_MELEE));
	
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetRangedHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local haste = GetRangedHaste();
	if (haste < 0) then
		haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
	else
		haste = "+"..format("%.2F%%", haste);
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, WEAPON_SPEED));
	local text = _G[statFrame:GetName().."StatText"];
	text:SetText(haste);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, WEAPON_SPEED) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;

	local _, class = UnitClass(unit);	
	statFrame.tooltip2 = _G["STAT_HASTE_RANGED_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_RANGED_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(MCF_STAT_HASTE_BASE_TOOLTIP, GetCombatRating(CR_HASTE_RANGED), GetCombatRatingBonus(CR_HASTE_RANGED));

	statFrame:Show();
end

function MCFPaperDollFrame_SetSpellPenetration(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, SPELL_PENETRATION));
	local text = _G[statFrame:GetName().."StatText"];
	local spellPenetration = GetSpellPenetration();
	text:SetText(spellPenetration);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE ..SPELL_PENETRATION.. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(SPELL_PENETRATION_TOOLTIP, spellPenetration, spellPenetration);
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetSpellHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local haste = GetCombatRatingBonus(CR_HASTE_SPELL); --UnitSpellHaste(unit); --MCFFIX disabled deleted function. GetCombatRatingBonus doesn't calculate talents so needs rework
	if (haste < 0) then
		haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
	else
		haste = "+"..format("%.2F%%", haste);
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, SPELL_HASTE));
	local text = _G[statFrame:GetName().."StatText"];
	text:SetText(haste);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, SPELL_HASTE) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;
	
	local _, class = UnitClass(unit);	
	statFrame.tooltip2 = _G["STAT_HASTE_SPELL_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_SPELL_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(MCF_STAT_HASTE_BASE_TOOLTIP, GetCombatRating(CR_HASTE_SPELL), GetCombatRatingBonus(CR_HASTE_SPELL));

	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetManaRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MANA_REGEN));
	local text = _G[statFrame:GetName().."StatText"];
	if ( not UnitHasMana("player") ) then
		text:SetText(NOT_APPLICABLE);
		statFrame.tooltip = nil;
		return;
	end
	
	local base, casting = GetManaRegen();
	-- All mana regen stats are displayed as mana/5 sec.
	base = floor( base * 5.0 );
	casting = floor( casting * 5.0 );
	text:SetText(base);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. MANA_REGEN .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(MANA_REGEN_TOOLTIP, base);
	statFrame:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetCombatManaRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MANA_REGEN_COMBAT));
	local text = _G[statFrame:GetName().."StatText"];
	if ( not UnitHasMana("player") ) then
		text:SetText(NOT_APPLICABLE);
		statFrame.tooltip = nil;
		return;
	end
	
	local base, casting = GetManaRegen();
	-- All mana regen stats are displayed as mana/5 sec.
	base = floor( base * 5.0 );
	casting = floor( casting * 5.0 );
	text:SetText(casting);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. MANA_REGEN_COMBAT .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(MANA_COMBAT_REGEN_TOOLTIP, casting);
	statFrame:Show();
end

--MCFFIX ready
function MCFExpertise_OnEnter(statFrame)

	if (MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	local expertise, offhandExpertise = GetExpertise();
	local expertisePercent, offhandExpertisePercent = GetExpertisePercent();
	expertisePercent = format("%.2F", expertisePercent);
	offhandExpertisePercent = format("%.2F", offhandExpertisePercent);
	
	local expertiseDisplay, expertisePercentDisplay;
	if (IsDualWielding()) then
		expertiseDisplay = expertise.." / "..offhandExpertise;
		expertisePercentDisplay = expertisePercent.."% / "..offhandExpertisePercent.."%";
	else
		expertiseDisplay = expertise;
		expertisePercentDisplay = expertisePercent.."%";
	end
	
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G["COMBAT_RATING_NAME"..CR_EXPERTISE]).." "..expertiseDisplay..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(CR_EXPERTISE_TOOLTIP, expertisePercentDisplay, GetCombatRating(CR_EXPERTISE), GetCombatRatingBonus(CR_EXPERTISE)), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
	GameTooltip:AddLine(" ");
	
	-- Dodge chance
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, DODGE_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local mainhandDodge, offhandDodge = MCFGetEnemyDodgeChance(i);
		mainhandDodge = format("%.2F%%", mainhandDodge);
		offhandDodge = format("%.2F%%", offhandDodge);
		local level = playerLevel + i;
		if (i == 3) then
			level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
		end
		local dodgeDisplay;
		if (IsDualWielding() and mainhandDodge ~= offhandDodge) then
			dodgeDisplay = mainhandDodge.." / "..offhandDodge;
		else
			dodgeDisplay = mainhandDodge.."  ";
		end
		GameTooltip:AddDoubleLine("      "..level, dodgeDisplay.."  ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	-- Parry chance
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, PARRY_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local mainhandParry, offhandParry = MCFGetEnemyParryChance(i);
		mainhandParry = format("%.2F%%", mainhandParry);
		offhandParry = format("%.2F%%", offhandParry);
		local level = playerLevel + i;
		if (i == 3) then
			level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
		end
		local parryDisplay;
		if (IsDualWielding() and mainhandParry ~= offhandParry) then
			parryDisplay = mainhandParry.." / "..offhandParry;
		else
			parryDisplay = mainhandParry.."  ";
		end
		GameTooltip:AddDoubleLine("      "..level, parryDisplay.."  ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end

--MCFFIX ready
function MCFPaperDollFrame_SetExpertise(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local expertise, offhandExpertise = GetExpertise();
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	local text;
	if( offhandSpeed ) then
		text = expertise.." / "..offhandExpertise;
	else
		text = expertise;
	end
	MCFPaperDollFrame_SetLabelAndText(statFrame, STAT_EXPERTISE, text);
	statFrame:SetScript("OnEnter", MCFExpertise_OnEnter);
	statFrame:Show();
end

--MCFFIX READY disabled completely because mastery doesn't exist in WotLK
--[[ function MCFMastery_OnEnter(statFrame)
	if (not MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	
	local _, class = UnitClass("player");
	local mastery = GetMastery();
	local masteryBonus = GetCombatRatingBonus(CR_MASTERY);
	
	local title = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_MASTERY).." "..format("%.2F", mastery)..FONT_COLOR_CODE_CLOSE;
	if (masteryBonus > 0) then
		title = title..HIGHLIGHT_FONT_COLOR_CODE.." ("..format("%.2F", mastery-masteryBonus)..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..format("%.2F", masteryBonus)..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
	end
	GameTooltip:SetText(title);
	
	local masteryKnown = IsSpellKnown(CLASS_MASTERY_SPELLS[class]);
	local primaryTalentTree = GetPrimaryTalentTree();
	if (masteryKnown and primaryTalentTree) then
		local masterySpell, masterySpell2 = GetTalentTreeMasterySpells(primaryTalentTree);
		if (masterySpell) then
			GameTooltip:AddSpellByID(masterySpell);
		end
		if (masterySpell2) then
			GameTooltip:AddLine(" ");
			GameTooltip:AddSpellByID(masterySpell2);
		end
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(format(STAT_MASTERY_TOOLTIP, GetCombatRating(CR_MASTERY), masteryBonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
	else
		GameTooltip:AddLine(format(STAT_MASTERY_TOOLTIP, GetCombatRating(CR_MASTERY), masteryBonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
		GameTooltip:AddLine(" ");
		if (masteryKnown) then
			GameTooltip:AddLine(STAT_MASTERY_TOOLTIP_NO_TALENT_SPEC, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true);
		else
			GameTooltip:AddLine(STAT_MASTERY_TOOLTIP_NOT_KNOWN, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true);
		end
	end
	GameTooltip:Show();
end ]]

--MCFFIX READY disabled completely because mastery doesn't exist in WotLK
--[[ function MCFPaperDollFrame_SetMastery(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	if (UnitLevel("player") < SHOW_MASTERY_LEVEL) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_MASTERY));
	local text = _G[statFrame:GetName().."StatText"];
	local mastery = GetMastery();
	mastery = format("%.2F", mastery);
	text:SetText(mastery);
	statFrame:SetScript("OnEnter", MCFMastery_OnEnter);
	statFrame:Show();
end ]]

--MCFFIX ready
--Assigned hard values to two variables in order to temporary fixing it. Probably needs another function to calculate it manually
function MCFPaperDollFrame_SetItemLevel(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_AVERAGE_ITEM_LEVEL));
	local text = _G[statFrame:GetName().."StatText"];
	local avgItemLevel, avgItemLevelEquipped = 77.77, 69.69 --GetAverageItemLevel();
	avgItemLevel = floor(avgItemLevel);
	avgItemLevelEquipped = floor(avgItemLevelEquipped);
	text:SetText(avgItemLevelEquipped .. " / " .. avgItemLevel);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_AVERAGE_ITEM_LEVEL).." "..avgItemLevel;
	if (avgItemLevelEquipped ~= avgItemLevel) then
		statFrame.tooltip = statFrame.tooltip .. "  " .. format(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, avgItemLevelEquipped);
	end
	statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
end

--MCFFIX ready
function MCFMovementSpeed_OnEnter(statFrame)
	if (MCFMOVING_STAT_CATEGORY) then return; end
	
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_MOVEMENT_SPEED).." "..format("%d%%", statFrame.speed+0.5)..FONT_COLOR_CODE_CLOSE);
	
	GameTooltip:AddLine(format(STAT_MOVEMENT_GROUND_TOOLTIP, statFrame.runSpeed+0.5));
	if (statFrame.unit ~= "pet") then
		GameTooltip:AddLine(format(STAT_MOVEMENT_FLIGHT_TOOLTIP, statFrame.flightSpeed+0.5));
	end
	GameTooltip:AddLine(format(STAT_MOVEMENT_SWIM_TOOLTIP, statFrame.swimSpeed+0.5));
	GameTooltip:Show();
	
	statFrame.UpdateTooltip = MCFMovementSpeed_OnEnter;
end

--MCFFIX ready
function MCFMovementSpeed_OnUpdate(statFrame, elapsedTime)
	local unit = statFrame.unit;
	local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit);
	runSpeed = runSpeed/BASE_MOVEMENT_SPEED*100;
	flightSpeed = flightSpeed/BASE_MOVEMENT_SPEED*100;
	swimSpeed = swimSpeed/BASE_MOVEMENT_SPEED*100;
	
	-- Pets seem to always actually use run speed
	if (unit == "pet") then
		swimSpeed = runSpeed;
	end

	-- Determine whether to display running, flying, or swimming speed
	local speed = runSpeed;
	local swimming = IsSwimming(unit);
	if (swimming) then
		speed = swimSpeed;
	elseif (IsFlying(unit)) then
		speed = flightSpeed;
	end
	
	-- Hack so that your speed doesn't appear to change when jumping out of the water
	if (IsFalling(unit)) then
		if (statFrame.wasSwimming) then
			speed = swimSpeed;
		end
	else
		statFrame.wasSwimming = swimming;
	end
	
	statFrame.Value:SetFormattedText("%d%%", speed+0.5);
	statFrame.speed = speed;
	statFrame.runSpeed = runSpeed;
	statFrame.flightSpeed = flightSpeed;
	statFrame.swimSpeed = swimSpeed;
end

function MCFPaperDollFrame_SetMovementSpeed(statFrame, unit)
	statFrame.Label:SetText(format(STAT_FORMAT, STAT_MOVEMENT_SPEED));
	
	statFrame.wasSwimming = nil;
	statFrame.unit = unit;
	MCFMovementSpeed_OnUpdate(statFrame);
	
	statFrame:SetScript("OnEnter", MCFMovementSpeed_OnEnter);
	statFrame:SetScript("OnUpdate", MCFMovementSpeed_OnUpdate);
end

--MCFFIX ready
function MCFCharacterSpellBonusDamage_OnEnter (self)
	if (MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, self.tooltip).." "..self.minModifier..FONT_COLOR_CODE_CLOSE);

	for i=2, MAX_SPELL_SCHOOLS do
		if (self.bonusDamage and self.bonusDamage[i] ~= self.minModifier) then
			GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G["DAMAGE_SCHOOL"..i]).." "..self.bonusDamage[i]..FONT_COLOR_CODE_CLOSE);
			GameTooltip:AddTexture("Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
		end
	end
	
	GameTooltip:AddLine(self.tooltip2);
	
	if (self.bonusDamage and self.unit == "player") then
		local petStr, damage;
		if (self.bonusDamage[6] == self.minModifier and self.bonusDamage[3] == self.minModifier) then
			petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG;
			damage = self.minModifier;
		elseif( self.bonusDamage[6] > self.bonusDamage[3] ) then
			petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG_SHADOW;
			damage = self.bonusDamage[6];
		else
			petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG_FIRE;
			damage = self.bonusDamage[3];
		end
		
		local petBonusAP = MCFComputePetBonus("PET_BONUS_SPELLDMG_TO_AP", damage );
		local petBonusDmg = MCFComputePetBonus("PET_BONUS_SPELLDMG_TO_SPELLDMG", damage );
		if( petBonusAP > 0 or petBonusDmg > 0 ) then
			GameTooltip:AddLine(format(petStr, petBonusAP, petBonusDmg), nil, nil, nil, 1 );
		end
	end
	GameTooltip:Show();
end

--MCFFIX ready
function MCFCharacterSpellCritChance_OnEnter (self)
	if (MCFMOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, SPELL_CRIT_CHANCE).." "..self.minCrit..FONT_COLOR_CODE_CLOSE);
	local spellCrit;
	for i=2, MAX_SPELL_SCHOOLS do
		spellCrit = format("%.2F%%", self.spellCrit[i]);
		if (spellCrit ~= self.minCrit) then
			GameTooltip:AddDoubleLine(_G["DAMAGE_SCHOOL"..i], spellCrit, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			GameTooltip:AddTexture("Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
		end
	end
	GameTooltip:AddLine(format(MCF_CR_CRIT_SPELL_TOOLTIP, GetCombatRating(CR_CRIT_SPELL), GetCombatRatingBonus(CR_CRIT_SPELL)));
	GameTooltip:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_OnShow (self)
	MCFCharacterStatsPane.initialOffsetY = 0;
	MCFCharacterFrameTitleText:SetText(UnitPVPName("player"));
	MCFPaperDollFrame_SetLevel();
	local activeSpec = GetActiveTalentGroup();
	if (activeSpec == 1) then
		MCFPaperDoll_InitStatCategories(MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
	else
		MCFPaperDoll_InitStatCategories(MCFPAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
	end
	if (MCF_GetSettings("characterFrameCollapsed") ~= "0") then
		MCFCharacterFrame_Collapse();
	else
		MCFCharacterFrame_Expand();
	end
	MCFCharacterFrameExpandButton:Show();
	MCFCharacterFrameExpandButton.collapseTooltip = MCF_STATS_COLLAPSE_TOOLTIP;
	MCFCharacterFrameExpandButton.expandTooltip = MCF_STATS_EXPAND_TOOLTIP;
	
	MCFSetPaperDollBackground(MCFCharacterModelFrame, "player");
	MCFPaperDollBgDesaturate(1);
	MCFPaperDollSidebarTabs:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_OnHide (self)
	MCFCharacterStatsPane.initialOffsetY = 0;
	MCFCharacterFrame_Collapse();
	MCFCharacterFrameExpandButton:Hide();
	if (MCFMOVING_STAT_CATEGORY) then
		MCFPaperDollStatCategory_OnDragStop(MCFMOVING_STAT_CATEGORY);
	end
	MCFPaperDollSidebarTabs:Hide();
end

--MCFFIXWORKINPROGRESS
--Disabled atm with debug message
function MCFPaperDollFrame_ClearIgnoredSlots ()
	--[[ EquipmentManagerClearIgnoredSlotsForSave(); ]]
	for k, button in next, itemSlotButtons do
		if ( button.ignored ) then
			button.ignored = nil;
			MCFPaperDollItemSlotButton_Update(button);
		end
	end
end

--MCFFIXWORKINPROGRESS disabled
function MCFPaperDollFrame_IgnoreSlotsForSet (setName)
	--[[ local set = C_EquipmentSet.GetEquipmentSetIDs(setName);
	for slot, item in ipairs(set) do
		if ( item == EQUIPMENT_SET_IGNORED_SLOT ) then
			EquipmentManagerIgnoreSlotForSave(slot);
			itemSlotButtons[slot].ignored = true;
			MCFPaperDollItemSlotButton_Update(itemSlotButtons[slot]);
		end
	end ]]
end

--MCFFIXWORKINPROGRESS disabled
function PaperDollFrame_IgnoreSlot(slot)
	--[[ EquipmentManagerIgnoreSlotForSave(slot); ]]
	itemSlotButtons[slot].ignored = true;
	MCFPaperDollItemSlotButton_Update(itemSlotButtons[slot]);
end

--MCFFIX READY
function MCFPaperDollItemSlotButton_OnLoad (self)
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	local slotName = self:GetName();
	local id, textureName, checkRelic = GetInventorySlotInfo(strsub(slotName,13));
	self:SetID(id);
	local texture = _G[slotName.."IconTexture"];
	texture:SetTexture(textureName);
	self.backgroundTextureName = textureName;
	self.checkRelic = checkRelic;
	self.UpdateTooltip = MCFPaperDollItemSlotButton_OnEnter;
	itemSlotButtons[id] = self;
	self.verticalFlyout = MCFVERTICAL_FLYOUTS[id];
	
	local popoutButton = self.popoutButton;
	if ( popoutButton ) then
		if ( self.verticalFlyout ) then
			popoutButton:SetHeight(16);
			popoutButton:SetWidth(38);
			
			popoutButton:GetNormalTexture():SetTexCoord(0.15625, 0.84375, 0.5, 0);
			popoutButton:GetHighlightTexture():SetTexCoord(0.15625, 0.84375, 1, 0.5);
			popoutButton:ClearAllPoints();
			popoutButton:SetPoint("TOP", self, "BOTTOM", 0, 4);
		else
			popoutButton:SetHeight(38);
			popoutButton:SetWidth(16);
			
			popoutButton:GetNormalTexture():SetTexCoord(0.15625, 0.5, 0.84375, 0.5, 0.15625, 0, 0.84375, 0);
			popoutButton:GetHighlightTexture():SetTexCoord(0.15625, 1, 0.84375, 1, 0.15625, 0.5, 0.84375, 0.5);
			popoutButton:ClearAllPoints();
			popoutButton:SetPoint("LEFT", self, "RIGHT", -8, 0);
		end
	end
end

--MCFFIX READY probably need to replace SHOW_COMPARE_TOOLTIP with something modern
function MCFPaperDollItemSlotButton_OnShow (self, isBag)
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("MERCHANT_UPDATE");
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	self:RegisterEvent("ITEM_LOCK_CHANGED");
	self:RegisterEvent("CURSOR_CHANGED");
	--self:RegisterEvent("SHOW_COMPARE_TOOLTIP");
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	if ( not isBag ) then
		self:RegisterEvent("BAG_UPDATE_COOLDOWN");
	end
	MCFPaperDollItemSlotButton_Update(self);
end

--MCFFIX READY probably need to replace SHOW_COMPARE_TOOLTIP with something modern
function MCFPaperDollItemSlotButton_OnHide (self)
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:UnregisterEvent("MERCHANT_UPDATE");
	self:UnregisterEvent("PLAYERBANKSLOTS_CHANGED");
	self:UnregisterEvent("ITEM_LOCK_CHANGED");
	self:UnregisterEvent("CURSOR_CHANGED");
	self:UnregisterEvent("BAG_UPDATE_COOLDOWN");
	--self:UnregisterEvent("SHOW_COMPARE_TOOLTIP");
	self:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
end

--MCFFIX ready (kinda)
--Probably needs rework because I just commented out part of code
function MCFPaperDollItemSlotButton_OnEvent (self, event, ...)
	local arg1, arg2 = ...;
	if ( event == "PLAYER_EQUIPMENT_CHANGED" ) then
		if ( self:GetID() == arg1 ) then
			MCFPaperDollItemSlotButton_Update(self);
		end
	elseif ( event == "ITEM_LOCK_CHANGED" ) then
		if ( not arg2 and arg1 == self:GetID() ) then
			MCFPaperDollItemSlotButton_UpdateLock(self);
		end
	elseif ( event == "BAG_UPDATE_COOLDOWN" ) then
		MCFPaperDollItemSlotButton_Update(self);
	elseif ( event == "CURSOR_CHANGED" ) then
		if ( CursorCanGoInSlot(self:GetID()) ) then
			self:LockHighlight();
		else
			self:UnlockHighlight();
		end
	--MCFFIX Disabled condition because it uses event that doesn't exist anymore
	--[[
	elseif ( event == "SHOW_COMPARE_TOOLTIP" ) then
		if ( (arg1 ~= self:GetID()) or (arg2 > NUM_SHOPPING_TOOLTIPS) ) then
			return;
		end

		local tooltip = _G["ShoppingTooltip"..arg2];
		local anchor = "ANCHOR_RIGHT";
		if ( arg2 > 1 ) then
			anchor = "ANCHOR_BOTTOMRIGHT";
		end
		tooltip:SetOwner(self, anchor);
		local hasItem, hasCooldown = tooltip:SetInventoryItem("player", self:GetID());
		if ( not hasItem ) then
			tooltip:Hide();
		end
	]]--
	elseif ( event == "UPDATE_INVENTORY_ALERTS" ) then
		MCFPaperDollItemSlotButton_Update(self);
	elseif ( event == "MODIFIER_STATE_CHANGED" ) then
		if ( IsModifiedClick("SHOWITEMFLYOUT") and self:IsMouseOver() ) then
			MCFPaperDollItemSlotButton_OnEnter(self);
		end
	end
end

--MCFFIX READY
function MCFPaperDollItemSlotButton_OnClick (self, button)
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

--MCFFIX READY
function MCFPaperDollItemSlotButton_OnModifiedClick (self, button)
	if ( HandleModifiedItemClick(GetInventoryItemLink("player", self:GetID())) ) then
		return;
	end
	if ( IsModifiedClick("SOCKETITEM") ) then
		SocketInventoryItem(self:GetID());
	end
end

--MCFFIX ready - needs fix for call of Cooldown related function
function MCFPaperDollItemSlotButton_Update (self)
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
			textureName = "Interface\\AddOns\\ModernCharacterFrame\\Textures\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp";
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
	
	if (not MCFPaperDollEquipmentManagerPane:IsShown()) then
		self.ignored = nil;
	end
	
	if ( self.ignored and self.ignoreTexture ) then
		self.ignoreTexture:Show();
	elseif ( self.ignoreTexture ) then
		self.ignoreTexture:Hide();
	end

	MCFPaperDollItemSlotButton_UpdateLock(self);

	-- Update repair all button status
	MerchantFrame_UpdateGuildBankRepair();
	MerchantFrame_UpdateCanRepairAll();
end

--MCFFIX READY
function MCFPaperDollItemSlotButton_UpdateLock (self)
	if ( IsInventoryItemLocked(self:GetID()) ) then
		--this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		SetItemButtonDesaturated(self, 1);
	else 
		--this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		SetItemButtonDesaturated(self, nil);
	end
end

--MCFFIXWORKINPROGRESS
function MCFPaperDollItemSlotButton_OnEnter (self)
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

--MCFFIX READY
function MCFPaperDollItemSlotButton_OnLeave (self)
	self:UnregisterEvent("MODIFIER_STATE_CHANGED");
	GameTooltip:Hide();
	ResetCursor();
end

--MCFFIX READY
function MCFPaperDollStatTooltip (self)
	if (MCFMOVING_STAT_CATEGORY ~= nil) then return; end
	if ( not self.tooltip ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.tooltip);
	if ( self.tooltip2 ) then
		GameTooltip:AddLine(self.tooltip2, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	GameTooltip:Show();
end

--MCFFIX READY
function MCFFormatPaperDollTooltipStat(name, base, posBuff, negBuff)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..name.." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end
	end
	return text;
end

--MCFFIX READY
function MCFColorPaperDollStat(base, posBuff, negBuff)
	local stat;
	local effective = max(0,base + posBuff + negBuff);
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		stat = effective;
	else 
		
		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			stat = RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
		else
			stat = GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
		end
	end
	return stat;
end

--MCFFIX READY
function MCFPaperDollFormatStat(name, base, posBuff, negBuff, frame, textString)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT,name).." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
		textString:SetText(effective);
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end

		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			textString:SetText(RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
		else
			textString:SetText(GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
		end
	end
	frame.tooltip = text;
end

--MCFFIX READY
function MCFCharacterAttackFrame_OnEnter (self)
	if (MCFMOVING_STAT_CATEGORY) then return; end
	-- Main hand weapon
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(INVTYPE_WEAPONMAINHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(self.weaponSkill);
	GameTooltip:AddLine(self.weaponRating);
	-- Check for offhand weapon
	if ( self.offhandSkill ) then
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine(self.offhandSkill);
		GameTooltip:AddLine(self.offhandRating);
	end
	GameTooltip:Show();
end

--MCFFIX READY
function MCFCharacterDamageFrame_OnEnter (self)
	if (MCFMOVING_STAT_CATEGORY) then return; end
	-- Main hand weapon
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( self.unit == "pet" ) then
		GameTooltip:SetText(INVTYPE_WEAPONMAINHAND_PET, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		GameTooltip:SetText(INVTYPE_WEAPONMAINHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, ATTACK_SPEED_SECONDS), format("%.2F", self.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE), self.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE_PER_SECOND), format("%.1F", self.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	-- Check for offhand weapon
	if ( self.offhandAttackSpeed ) then
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(format(STAT_FORMAT, ATTACK_SPEED_SECONDS), format("%.2F", self.offhandAttackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE), self.offhandDamage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE_PER_SECOND), format("%.1F", self.offhandDps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

--MCFFIX READY
function MCFCharacterRangedDamageFrame_OnEnter (self)
	if (MCFMOVING_STAT_CATEGORY) then return; end
	if ( not self.damage ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(INVTYPE_RANGED, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, ATTACK_SPEED_SECONDS), format("%.2F", self.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE), self.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE_PER_SECOND), format("%.1F", self.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:Show();
end

--MCFFIX READY
function MCFPaperDollFrame_GetArmorReduction(armor, attackerLevel)
	local levelModifier = attackerLevel;
	if ( levelModifier > 80 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier-59)) + (20 * (levelModifier - 80));
	elseif ( levelModifier > 59 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier-59));
	end
	local temp = 0.1*armor/(8.5*levelModifier + 40);
	temp = temp/(1+temp);

	if ( temp > 0.75 ) then
		return 75;
	end

	if ( temp < 0 ) then
		return 0;
	end

	return temp*100;
end

--MCFFIX READY
function MCFPaperDollFrame_CollapseStatCategory(categoryFrame)
	if (not categoryFrame.collapsed) then
		categoryFrame.collapsed = true;
		local index = 1;
		while (_G[categoryFrame:GetName().."Stat"..index]) do 
			_G[categoryFrame:GetName().."Stat"..index]:Hide();
			index = index + 1;
		end
		categoryFrame.CollapsedIcon:Show();
		categoryFrame.ExpandedIcon:Hide();
		categoryFrame:SetHeight(18);
		MCFPaperDollFrame_UpdateStatScrollChildHeight();
		categoryFrame.BgMinimized:Show();
		categoryFrame.BgTop:Hide();
		categoryFrame.BgMiddle:Hide();
		categoryFrame.BgBottom:Hide();
	end
end

--MCFFIX READY
function MCFPaperDollFrame_ExpandStatCategory(categoryFrame)
	if (categoryFrame.collapsed) then
		categoryFrame.collapsed = false;
		categoryFrame.CollapsedIcon:Hide();
		categoryFrame.ExpandedIcon:Show();
		MCFPaperDollFrame_UpdateStatCategory(categoryFrame);
		MCFPaperDollFrame_UpdateStatScrollChildHeight();
		categoryFrame.BgMinimized:Hide();
		categoryFrame.BgTop:Show();
		categoryFrame.BgMiddle:Show();
		categoryFrame.BgBottom:Show();
	end
end

--MCFFIX READY
function MCFPaperDollFrame_UpdateStatCategory(categoryFrame)
	if (not categoryFrame.Category) then
		categoryFrame:Hide();
		return;
	end
	
	local categoryInfo = MCFPAPERDOLL_STATCATEGORIES[categoryFrame.Category];
	
	categoryFrame.NameText:SetText(_G["STAT_CATEGORY_"..categoryFrame.Category]);
	
	if (categoryFrame.collapsed) then
		return;
	end
	
	local stat;
	local totalHeight = categoryFrame.NameText:GetHeight() + 10;
	local numVisible = 0;
	if (categoryInfo) then
		local prevStatFrame = nil;
		for index, stat in next, categoryInfo.stats do
			local statInfo = MCFPAPERDOLL_STATINFO[stat];
			if (statInfo) then
				local statFrame = _G[categoryFrame:GetName().."Stat"..numVisible+1];
				if (not statFrame) then
					statFrame = CreateFrame("FRAME", categoryFrame:GetName().."Stat"..numVisible+1, categoryFrame, "MCFStatFrameTemplate");
					if (prevStatFrame) then
						statFrame:SetPoint("TOPLEFT", prevStatFrame, "BOTTOMLEFT", 0, 0);
						statFrame:SetPoint("TOPRIGHT", prevStatFrame, "BOTTOMRIGHT", 0, 0);
					end
				end
				statFrame:Show();
				-- Reset tooltip script in case it's been changed
				statFrame:SetScript("OnEnter", MCFPaperDollStatTooltip);
				statFrame.tooltip = nil;
				statFrame.tooltip2 = nil;
				statFrame.UpdateTooltip = nil;
				statFrame:SetScript("OnUpdate", nil);
				statInfo.updateFunc(statFrame, MCFCharacterStatsPane.unit);
				if (statFrame:IsShown()) then
					numVisible = numVisible+1;
					totalHeight = totalHeight + statFrame:GetHeight();
					prevStatFrame = statFrame;
					-- Update Tooltip
					if (GameTooltip:GetOwner() == statFrame) then
						statFrame:GetScript("OnEnter")(statFrame);
					end
				end
			end
		end
	end
	
	local i;
	for index=1, numVisible do
		if (index%2 == 0) then
			local statFrame = _G[categoryFrame:GetName().."Stat"..index];
			if (not statFrame.Bg) then
				statFrame.Bg = statFrame:CreateTexture(statFrame:GetName().."Bg", "BACKGROUND");
				statFrame.Bg:SetPoint("LEFT", categoryFrame, "LEFT", 1, 0);
				statFrame.Bg:SetPoint("RIGHT", categoryFrame, "RIGHT", 0, 0);
				statFrame.Bg:SetPoint("TOP");
				statFrame.Bg:SetPoint("BOTTOM");
				statFrame.Bg:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				statFrame.Bg:SetAlpha(0.1);
			end
		end
	end
	
	-- Hide all other stats
	local index = numVisible + 1;
	while (_G[categoryFrame:GetName().."Stat"..index]) do 
		_G[categoryFrame:GetName().."Stat"..index]:Hide();
		index = index + 1;
	end
	
	-- Hack to fix category frames that only have 1 item in them
	if (totalHeight < 44) then
		categoryFrame.BgBottom:SetHeight(totalHeight - 2);
	else
		categoryFrame.BgBottom:SetHeight(46);
	end
	
	categoryFrame:SetHeight(totalHeight);
end

--MCFFIX READY
function MCFPaperDollFrame_UpdateStats()
	local index = 1;
	while(_G["MCFCharacterStatsPaneCategory"..index]) do
		MCFPaperDollFrame_UpdateStatCategory(_G["MCFCharacterStatsPaneCategory"..index]);
		index = index + 1;
	end
	MCFPaperDollFrame_UpdateStatScrollChildHeight();
end

--MCFFIX READY
function MCFPaperDollFrame_UpdateStatScrollChildHeight()
	local index = 1;
	local totalHeight = 0;
	while(_G["MCFCharacterStatsPaneCategory"..index]) do
		if (_G["MCFCharacterStatsPaneCategory"..index]:IsShown()) then
			totalHeight = totalHeight + _G["MCFCharacterStatsPaneCategory"..index]:GetHeight() + STATCATEGORY_PADDING;
		end
		index = index + 1;
	end
	MCFCharacterStatsPaneScrollChild:SetHeight(totalHeight+10-(MCFCharacterStatsPane.initialOffsetY or 0));
end

--MCFFIX READY
function MCFPaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, label));
	if ( isPercentage ) then
		text = format("%.2F%%", text);
	end
	_G[statFrame:GetName().."StatText"]:SetText(text);
end

--MCFFIX READY
function MCFComputePetBonus(stat, value)
	local temp, unitClass = UnitClass("player");
	unitClass = strupper(unitClass);
	if( unitClass == "WARLOCK" ) then
		if( WARLOCK_PET_BONUS[stat] ) then
			return value * WARLOCK_PET_BONUS[stat];
		else
			return 0;
		end
	elseif( unitClass == "HUNTER" ) then
		if( HUNTER_PET_BONUS[stat] ) then 
			return value * HUNTER_PET_BONUS[stat];
		else
			return 0;
		end
	end
	
	return 0;
end

--MCFFIX READY
function MCFPaperDoll_FindCategoryById(id)
	for categoryName, category in pairs(MCFPAPERDOLL_STATCATEGORIES) do
		if (category.id == id) then
			return categoryName;
		end
	end
	return nil;
end

--MCFFIX READY
function MCFPaperDoll_InitStatCategories(defaultOrder, orderCVarName, collapsedCVarName, unit)
	local category;
	local order = defaultOrder;

	-- Load order from cvar
	if (orderCVarName) then
		local orderString = MCF_GetSettings(orderCVarName); --MCFFIX replased GetCVar() with own MCF_GetSettings()
		local savedOrder = {};
		if (orderString and orderString ~= "") then
			for i in gmatch(orderString, "%d+,?") do
				i = gsub(i, ",", "");
				i = tonumber(i);
				if (i) then
					local categoryName = MCFPaperDoll_FindCategoryById(i);
					if (categoryName) then
						tinsert(savedOrder, categoryName);
					end
				end
			end
			 
			-- Validate the saved order
			local valid = true;
			if (#savedOrder == #defaultOrder) then
				for i, category1 in next, defaultOrder do
					local found = false;
					for j, category2 in next, savedOrder do
						if (category1 == category2) then
							found = true;
							break;
						end
					end
					if (not found) then
						valid = false;
						break;
					end
				end
			else
				valid = false;
			end
			
			if (valid) then
				order = savedOrder;
			else
				MCF_SetSettings(orderCVarName, ""); --MCFFIX replaced SetCVar with own function MCF_SetSettings()
			end
		end
	end

	-- Initialize stat frames
	table.wipe(StatCategoryFrames);
	for index=1, #order do
		local frame = _G["MCFCharacterStatsPaneCategory"..index];
		assert(frame);
		tinsert(StatCategoryFrames, frame);
		frame.Category = order[index];
		frame:Show();
		
		-- Expand or collapse
		local categoryInfo = MCFPAPERDOLL_STATCATEGORIES[frame.Category];
		if (categoryInfo and collapsedCVarName and MCF_GetSettings(collapsedCVarName, categoryInfo.id)) then -- MCFFIX replaced GetCVarBitfield() with own function MCF_GetSettings()
			MCFPaperDollFrame_CollapseStatCategory(frame);
		else
			MCFPaperDollFrame_ExpandStatCategory(frame);
		end
	end
	
	-- Hide unused stat frames
	local index = #order+1;
	while(_G["MCFCharacterStatsPaneCategory"..index]) do
		_G["MCFCharacterStatsPaneCategory"..index]:Hide();
		_G["MCFCharacterStatsPaneCategory"..index].Category = nil;
		index = index + 1;
	end	
	
	-- Set up stats data
	MCFCharacterStatsPane.defaultOrder = defaultOrder;
	MCFCharacterStatsPane.orderCVarName = orderCVarName;
	MCFCharacterStatsPane.collapsedCVarName = collapsedCVarName;
	MCFCharacterStatsPane.unit = unit;
	
	-- Update
	MCFPaperDoll_UpdateCategoryPositions();
	MCFPaperDollFrame_UpdateStats();
end

--MCFFIX READY
function MCFPaperDoll_SaveStatCategoryOrder()

	if (not MCFCharacterStatsPane.orderCVarName) then
		return;
	end

	-- Check if the current order matches the default order
	if (MCFCharacterStatsPane.defaultOrder and #MCFCharacterStatsPane.defaultOrder == #StatCategoryFrames) then
		local same = true;
		for index=1, #StatCategoryFrames do
			if (StatCategoryFrames[index].Category ~= MCFCharacterStatsPane.defaultOrder[index]) then
				same = false;
				break;
			end
		end
		if (same) then
			MCF_SetSettings(MCFCharacterStatsPane.orderCVarName, ""); --MCFFIX SetCVar() replaced with own function MCF_SetSettings()
			return;
		end
	end
		
	local cvarString = "";
	for index=1, #StatCategoryFrames do
		if (index ~= #StatCategoryFrames) then
			cvarString = cvarString..MCFPAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id..",";
		else
			cvarString = cvarString..MCFPAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id;
		end
	end
	MCF_SetSettings(MCFCharacterStatsPane.orderCVarName, cvarString); --MCFFIX SetCVar() replaced with own function MCF_SetSettings()
end

--MCFFIX READY
function MCFPaperDoll_UpdateCategoryPositions()
	local prevFrame = nil;
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		frame:ClearAllPoints();
	end
	
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		
		-- Indent the one we are currently dragging
		local xOffset = 0;
		if (frame == MCFMOVING_STAT_CATEGORY) then
			xOffset = STATCATEGORY_MOVING_INDENT;
		elseif (prevFrame and prevFrame == MCFMOVING_STAT_CATEGORY) then
			xOffset = -STATCATEGORY_MOVING_INDENT;
		end
		
		if (prevFrame) then
			frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0+xOffset, -STATCATEGORY_PADDING);
		else
			frame:SetPoint("TOPLEFT", 1+xOffset, -STATCATEGORY_PADDING+(MCFCharacterStatsPane.initialOffsetY or 0));
		end
		prevFrame = frame;
	end
end

--MCFFIX READY
function MCFPaperDoll_MoveCategoryUp(self)
	for index = 2, #StatCategoryFrames do
		if (StatCategoryFrames[index] == self) then
			tremove(StatCategoryFrames, index);
			tinsert(StatCategoryFrames, index-1, self);
			break;
		end
	end
	
	MCFPaperDoll_UpdateCategoryPositions();
	MCFPaperDoll_SaveStatCategoryOrder();
end

--MCFFIX READY
function MCFPaperDoll_MoveCategoryDown(self)
	for index = 1, #StatCategoryFrames-1 do
		if (StatCategoryFrames[index] == self) then
			tremove(StatCategoryFrames, index);
			tinsert(StatCategoryFrames, index+1, self);
			break;
		end
	end
	MCFPaperDoll_UpdateCategoryPositions();
	MCFPaperDoll_SaveStatCategoryOrder();
end

--MCFFIX READY
function MCFPaperDollStatCategory_OnDragUpdate(self)
	local _, cursorY = GetCursorPosition();
	cursorY = cursorY*GetScreenHeightScale();
	
	local myIndex = nil;
	local insertIndex = nil;
	local closestPos;
	
	-- Find position that will put the dragged frame closest to the cursor
	for index=1, #StatCategoryFrames+1 do -- +1 is to check the very last position at the bottom
		if (StatCategoryFrames[index] == self) then
			myIndex = index;
		end

		local frameY;
		if (index <= #StatCategoryFrames) then
			frameY = StatCategoryFrames[index]:GetTop();
		else
			frameY = StatCategoryFrames[#StatCategoryFrames]:GetBottom();
		end
		frameY = frameY - 8;  -- compensate for height of the toolbar area
		if (myIndex and index > myIndex) then
			-- Remove height of the dragged frame, since it's going to be moved out of it's current position
			frameY = frameY + self:GetHeight();
		end
		if (not closestPos or abs(cursorY - frameY)<closestPos) then
			insertIndex = index;
			closestPos = abs(cursorY-frameY);
		end
	end
	
	if (insertIndex > myIndex) then
		insertIndex = insertIndex - 1;
	end
	
	if ( myIndex ~= insertIndex) then
		tremove(StatCategoryFrames, myIndex);
		tinsert(StatCategoryFrames, insertIndex, self);
		MCFPaperDoll_UpdateCategoryPositions();
	end
end

--MCFFIX READY
function MCFPaperDollStatCategory_OnDragStart(self)
	MCFMOVING_STAT_CATEGORY = self;
	MCFPaperDoll_UpdateCategoryPositions();
	GameTooltip:Hide();
	self:SetScript("OnUpdate", MCFPaperDollStatCategory_OnDragUpdate);
	local i;
	local frame;
	for i, frame in next, StatCategoryFrames do
		if (frame ~= self) then
			frame:SetAlpha(0.6);
		end
	end
end

--MCFFIX READY
function MCFPaperDollStatCategory_OnDragStop(self)
	MCFMOVING_STAT_CATEGORY = nil;
	MCFPaperDoll_UpdateCategoryPositions();
	self:SetScript("OnUpdate", nil);
	local i;
	local frame;
	for i, frame in next, StatCategoryFrames do
		if (frame ~= self) then
			frame:SetAlpha(1);
		end
	end
	MCFPaperDoll_SaveStatCategoryOrder();
end

--MCFFIXWORKINPROGRESS (needs complete reworking (changing to modern flyout system))
function MCFPaperDollFrameItemFlyoutButton_OnClick (self)
	print("Function MCFPaperDollFrameItemFlyoutButton_OnClick just tried to run. It's disabled completely atm.");
	
	if ( self.location == PDFITEMFLYOUT_IGNORESLOT_LOCATION ) then
		local slot = MCFEquipmentFlyoutFrame.button;
		EquipmentManagerIgnoreSlotForSave(slot:GetID());
		slot.ignored = true;
		MCFPaperDollItemSlotButton_Update(slot);
		EquipmentFlyout_Show(slot);
		MCFPaperDollEquipmentManagerPaneSaveSet:Enable();
	elseif ( self.location == PDFITEMFLYOUT_UNIGNORESLOT_LOCATION ) then
		local slot = MCFEquipmentFlyoutFrame.button;
		EquipmentManagerUnignoreSlotForSave(slot:GetID());
		slot.ignored = nil;
		MCFPaperDollItemSlotButton_Update(slot);
		EquipmentFlyout_Show(slot);
		MCFPaperDollEquipmentManagerPaneSaveSet:Enable();
	elseif ( self.location == PDFITEMFLYOUT_PLACEINBAGS_LOCATION ) then
		if ( UnitAffectingCombat("player") and not INVSLOTS_EQUIPABLE_IN_COMBAT[MCFEquipmentFlyoutFrame.button:GetID()] ) then
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
			return;
		end
		local action = EquipmentManager_UnequipItemInSlot(MCFEquipmentFlyoutFrame.button:GetID());
		EquipmentManager_RunAction(action);
	elseif ( self.location ) then
		if ( UnitAffectingCombat("player") and not INVSLOTS_EQUIPABLE_IN_COMBAT[MCFEquipmentFlyoutFrame.button:GetID()] ) then
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
			return;
		end
		local action = EquipmentManager_EquipItemByLocation(self.location, self.id);
		EquipmentManager_RunAction(action);
	end
	
end

--MCFFIX READY
function MCFPaperDollFrameItemFlyout_GetItems(paperDollItemSlot, itemTable)
	GetInventoryItemsForSlot(paperDollItemSlot, itemTable);
end

--MCFFIXWORKINPROGRESS
function MCFPaperDollFrameItemFlyout_PostGetItems(itemSlotButton, itemDisplayTable, numItems)
	if (MCFPaperDollEquipmentManagerPane:IsShown() and (MCFPaperDollEquipmentManagerPane.selectedSetName or MCFGearManagerDialogPopup:IsShown())) then 
		if ( not itemSlotButton.ignored ) then
			tinsert(itemDisplayTable, 1, PDFITEMFLYOUT_IGNORESLOT_LOCATION);
		else
			tinsert(itemDisplayTable, 1, PDFITEMFLYOUT_UNIGNORESLOT_LOCATION);
		end
		numItems = numItems + 1;
	end
	if ( itemSlotButton.hasItem ) then
		tinsert(itemDisplayTable, 1, PDFITEMFLYOUT_PLACEINBAGS_LOCATION);
		numItems = numItems + 1;
	end
	return numItems;
end

--MCFFIXWORKINPROGRESS
function MCFGearSetButton_OnClick (self, button, down)
	print("Function MCFGearSetButton_OnClick just started execution.");

	if ( self.name and self.name ~= "" ) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);		-- inappropriately named, but a good sound.
		MCFPaperDollEquipmentManagerPane.selectedSetName = self.name;
		-- mark the ignored slots
		MCFPaperDollFrame_ClearIgnoredSlots();
		MCFPaperDollFrame_IgnoreSlotsForSet(self.name);
		MCFPaperDollEquipmentManagerPane_Update();
		MCFGearManagerDialogPopup:Hide();
	else
		-- This is the "New Set" button
		MCFGearManagerDialogPopup:Show();
		MCFPaperDollEquipmentManagerPane.selectedSetName = nil;
		MCFPaperDollFrame_ClearIgnoredSlots();
		MCFPaperDollEquipmentManagerPane_Update();
		-- Ignore shirt and tabard by default
		MCFPaperDollFrame_IgnoreSlot(4);
		MCFPaperDollFrame_IgnoreSlot(19);
	end
	StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET");
	StaticPopup_Hide("CONFIRM_OVERWRITE_EQUIPMENT_SET");

	print("Function MCFGearSetButton_OnClick just ended execution.");
end

--MCFFIX READY
function MCFGearSetButton_OnEnter (self)
	if ( self.name and self.name ~= "" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		GameTooltip:SetEquipmentSet(self.name);
	end
end

--MCFFIX
--Commented out these constants because they exist in the game (with another values)
--[[
NUM_GEARSET_ICONS_SHOWN = 15; --80
NUM_GEARSET_ICONS_PER_ROW = 5; --10
NUM_GEARSET_ICON_ROWS = 3; --8
GEARSET_ICON_ROW_HEIGHT = 36;
]]--
local MCFEM_ICON_FILENAMES = {};

--MCFFIX READY (need to test built-in template GearSetPopupButtonTemplate)
function MCFGearManagerDialogPopup_OnLoad (self)
	self.buttons = {};
	
	local rows = 0;
	
	local button = CreateFrame("CheckButton", "MCFGearManagerDialogPopupButton1", MCFGearManagerDialogPopup, "GearSetPopupButtonTemplate");
	button:SetPoint("TOPLEFT", 24, -85);
	button:SetID(1);
	tinsert(self.buttons, button);
	
	local lastPos;
	for i = 2, NUM_GEARSET_ICONS_SHOWN do
		button = CreateFrame("CheckButton", "MCFGearManagerDialogPopupButton" .. i, MCFGearManagerDialogPopup, "GearSetPopupButtonTemplate");
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

--MCFFIX ready
function MCFGearManagerDialogPopup_OnShow (self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
	self.name = nil;
	self.isEdit = false;
	MCFRecalculateGearManagerDialogPopup(); --MCFCHECK
end

--MCFFIX ready
function MCFGearManagerDialogPopup_OnHide (self)
	MCFGearManagerDialogPopup.name = nil;
	MCFGearManagerDialogPopup:SetSelection(true, nil);
	MCFGearManagerDialogPopupEditBox:SetText("");
	if (not MCFPaperDollEquipmentManagerPane.selectedSetName) then
		MCFPaperDollFrame_ClearIgnoredSlots(); --MCFCHECK
	end
	MCFEM_ICON_FILENAMES = nil;
	collectgarbage();
end

--MCFFIX ready (probably)
function MCFRecalculateGearManagerDialogPopup(setName, iconTexture)
	local popup = MCFGearManagerDialogPopup;
	if ( setName and setName ~= "") then
		MCFGearManagerDialogPopupEditBox:SetText(setName);
		MCFGearManagerDialogPopupEditBox:HighlightText(0);
	else
		MCFGearManagerDialogPopupEditBox:SetText("");
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
	MCFRefreshEquipmentSetIconInfo();
	local totalItems = #MCFEM_ICON_FILENAMES;
	local texture, _;
	if(popup.selectedTexture) then
		local foundIndex = nil;
		for index=1, totalItems do
			texture = MCFGetEquipmentSetIconInfo(index);
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
		FauxScrollFrame_OnVerticalScroll(MCFGearManagerDialogPopupScrollFrame, offset*GEARSET_ICON_ROW_HEIGHT, GEARSET_ICON_ROW_HEIGHT, nil);
	else
		FauxScrollFrame_OnVerticalScroll(MCFGearManagerDialogPopupScrollFrame, 0, GEARSET_ICON_ROW_HEIGHT, nil);
	end
	MCFGearManagerDialogPopup_Update();
end

--MCFFIX ready
--[[
RefreshEquipmentSetIconInfo() counts how many uniquely textured inventory items the player has equipped. 
]]
function MCFRefreshEquipmentSetIconInfo ()
	MCFEM_ICON_FILENAMES = {};
	MCFEM_ICON_FILENAMES[1] = "INV_MISC_QUESTIONMARK";
	local index = 2;

	for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		local itemTexture = GetInventoryItemTexture("player", i);
		if ( itemTexture ) then
			MCFEM_ICON_FILENAMES[index] = gsub( strupper(itemTexture), "INTERFACE\\ICONS\\", "" );
			if(MCFEM_ICON_FILENAMES[index]) then
				index = index + 1;
				--[[
				Currently checks all for duplicates, even though only rings, trinkets, and weapons may be duplicated. 
				This version is clean and maintainable.
				]]
				for j=INVSLOT_FIRST_EQUIPPED, (index-1) do
					if(MCFEM_ICON_FILENAMES[index] == MCFEM_ICON_FILENAMES[j]) then
						MCFEM_ICON_FILENAMES[index] = nil;
						index = index - 1;
						break;
					end
				end
			end
		end
	end
	GetMacroItemIcons(MCFEM_ICON_FILENAMES);
	GetMacroIcons(MCFEM_ICON_FILENAMES);
end

--MCFFIX ready (kinda)
--Function is simple but whole GearManager system needs reworking or replacing with modern system.
--[[ 
GetEquipmentSetIconInfo(index) determines the texture and real index of a regular index
	Input: 	index = index into a list of equipped items followed by the macro items. Only tricky part is the equipped items list keeps changing.
	Output: the associated texture for the item, and a index relative to the join point between the lists, i.e. negative for the equipped items
			and positive for the macro items//
]]
function MCFGetEquipmentSetIconInfo(index)
	return MCFEM_ICON_FILENAMES[index];

end

--MCFFIX ready
function MCFGearManagerDialogPopup_Update ()
	MCFRefreshEquipmentSetIconInfo();

	local popup = MCFGearManagerDialogPopup;
	local buttons = popup.buttons;
	local offset = FauxScrollFrame_GetOffset(MCFGearManagerDialogPopupScrollFrame) or 0;
	local button;	
	-- Icon list
	local texture, index, button, realIndex, _;
	for i=1, NUM_GEARSET_ICONS_SHOWN do
		local button = buttons[i];
		index = (offset * NUM_GEARSET_ICONS_PER_ROW) + i;
		if ( index <= #MCFEM_ICON_FILENAMES ) then
			texture = MCFGetEquipmentSetIconInfo(index);
			-- button.name:SetText(index); --dcw
			button.icon:SetTexture("INTERFACE\\ICONS\\"..texture);
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
	FauxScrollFrame_Update(MCFGearManagerDialogPopupScrollFrame, ceil(#MCFEM_ICON_FILENAMES / NUM_GEARSET_ICONS_PER_ROW) , NUM_GEARSET_ICON_ROWS, GEARSET_ICON_ROW_HEIGHT );
end

--MCFFIX ready
function MCFGearManagerDialogPopupOkay_Update ()
	local popup = MCFGearManagerDialogPopup;
	local button = MCFGearManagerDialogPopupOkay;
	
	if ( popup.selectedIcon and popup.name ) then
		button:Enable();
	else
		button:Disable();
	end
end

--MCFFIX ready (disabled atm - needs change to modern flyout system)
function MCFGearManagerDialogPopupOkay_OnClick (self, button, pushed)
	local popup = MCFGearManagerDialogPopup;
	local iconTexture = MCFGetEquipmentSetIconInfo(popup.selectedIcon);

	--[[ if ( GetEquipmentSetInfoByName(popup.name) ) then ]] --MCFFIX replaced with modern functions
	if ( C_EquipmentSet.GetEquipmentSetInfo(C_EquipmentSet.GetEquipmentSetID(popup.name)) ) then
		if (popup.isEdit and popup.name ~= popup.origName)  then
			-- Not allowed to overwrite an existing set by doing a rename
			UIErrorsFrame:AddMessage(EQUIPMENT_SETS_CANT_RENAME, 1.0, 0.1, 0.1, 1.0);
			return;
		elseif (not popup.isEdit) then
			local dialog = StaticPopup_Show("CONFIRM_OVERWRITE_EQUIPMENT_SET", popup.name);
			if ( dialog ) then
				dialog.data = popup.name;
				dialog.selectedIcon = popup.selectedIcon;
			else
				UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
			end
			return;
		end
	elseif ( C_EquipmentSet.GetNumEquipmentSets() >= MAX_EQUIPMENT_SETS_PER_PLAYER and not popup.isEdit) then
		UIErrorsFrame:AddMessage(EQUIPMENT_SETS_TOO_MANY, 1.0, 0.1, 0.1, 1.0);
		return;
	end
	
	if (popup.isEdit) then
		--Modifying a set
		MCFPaperDollEquipmentManagerPane.selectedSetName = popup.name;
		C_EquipmentSet.ModifyEquipmentSet(popup.origName, popup.name, iconTexture);
	else
		-- Saving a new set
		C_EquipmentSet.SaveEquipmentSet(popup.name, iconTexture);
	end
	popup:Hide();
end

--MCFFIX ready
function MCFGearManagerDialogPopupCancel_OnClick ()
	MCFGearManagerDialogPopup:Hide();
end

--MCFFIX ready
function MCFGearSetPopupButton_OnClick (self, button)
	local popup = MCFGearManagerDialogPopup;
	local offset = FauxScrollFrame_GetOffset(MCFGearManagerDialogPopupScrollFrame) or 0;
	popup.selectedIcon = (offset * NUM_GEARSET_ICONS_PER_ROW) + self:GetID();
 	popup.selectedTexture = nil;
	MCFGearManagerDialogPopup_Update();
	MCFGearManagerDialogPopupOkay_Update();
end

--MCFFIX ready (needs rework)
function MCFPaperDollEquipmentManagerPane_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = MCFPaperDollEquipmentManagerPane_Update;	
	HybridScrollFrame_CreateButtons(self, "MCFGearSetButtonTemplate", 2, -(self.EquipSet:GetHeight()+4));
	
	self:RegisterEvent("EQUIPMENT_SWAP_FINISHED");
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("BAG_UPDATE");
	
	print("function MCFPaperDollEquipmentManagerPane_OnLoad just executed"); --MCFFIX added this line
end

--MCFFIX ready
function MCFPaperDollEquipmentManagerPane_OnUpdate(self)
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
		MCFPaperDollEquipmentManagerPane_Update();
		self.queuedUpdate = false;
	end
end

--MCFFIXWORKINPROGRESS
function MCFPaperDollEquipmentManagerPane_OnShow(self)
	HybridScrollFrame_CreateButtons(MCFPaperDollEquipmentManagerPane, "MCFGearSetButtonTemplate");
	MCFPaperDollEquipmentManagerPane_Update();
	--[[ EquipmentFlyoutPopoutButton_ShowAll(); ]]
end

--MCFFIX READY
function MCFPaperDollEquipmentManagerPane_OnEvent(self, event, ...)

	if ( event == "EQUIPMENT_SWAP_FINISHED" ) then
		local completed, setName = ...;
		if ( completed ) then
			PlaySound(SOUNDKIT.PUT_DOWN_SMALL_CHAIN); -- plays the equip sound for plate mail
			if (self:IsShown()) then
				self.selectedSetName = setName;
				MCFPaperDollEquipmentManagerPane_Update();
			end
		end
	end


	if (self:IsShown()) then
		if ( event == "EQUIPMENT_SETS_CHANGED" ) then
			MCFPaperDollEquipmentManagerPane_Update();
		elseif ( event == "PLAYER_EQUIPMENT_CHANGED" or event == "BAG_UPDATE" ) then
			-- This queues the update to only happen once at the end of the frame
			self.queuedUpdate = true;
		end
	end
end

--MCFFIXWORKINPROGRESS
function MCFPaperDollEquipmentManagerPane_OnHide(self)
	--[[ EquipmentFlyoutPopoutButton_HideAll(); ]]
	MCFPaperDollFrame_ClearIgnoredSlots();
	MCFGearManagerDialogPopup:Hide();
	StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET");
	StaticPopup_Hide("CONFIRM_OVERWRITE_EQUIPMENT_SET");
end

--MCFFIX ready
--Disabled completely, needs rework
function MCFPaperDollEquipmentManagerPane_Update()
	--[[ local _, setID, isEquipped = GetEquipmentSetInfoByName(MCFPaperDollEquipmentManagerPane.selectedSetName or ""); ]] --MCFFIX replaced with a few lines below

	local setID, isEquipped
	if ( MCFPaperDollEquipmentManagerPane.selectedSetName ) then
		setID = C_EquipmentSet.GetEquipmentSetID(MCFPaperDollEquipmentManagerPane.selectedSetName);
		_, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(setID);
	end

	if (setID) then
		if (isEquipped) then
			MCFPaperDollEquipmentManagerPaneSaveSet:Disable();
			MCFPaperDollEquipmentManagerPaneEquipSet:Disable();
		else
			MCFPaperDollEquipmentManagerPaneSaveSet:Enable();
			MCFPaperDollEquipmentManagerPaneEquipSet:Enable();
		end
	else
		MCFPaperDollEquipmentManagerPaneSaveSet:Disable();
		MCFPaperDollEquipmentManagerPaneEquipSet:Disable();
		
		-- Clear selected equipment set if it doesn't exist
		if (MCFPaperDollEquipmentManagerPane.selectedSetName) then
			MCFPaperDollEquipmentManagerPane.selectedSetName = nil;
			MCFPaperDollFrame_ClearIgnoredSlots();
		end
	end

	local numSets = C_EquipmentSet.GetNumEquipmentSets();
	local numRows = numSets;
	if (numSets < MAX_EQUIPMENT_SETS_PER_PLAYER) then
		numRows = numRows + 1;  -- "Add New Set" button
	end

	HybridScrollFrame_Update(MCFPaperDollEquipmentManagerPane, numRows * MCFEQUIPMENTSET_BUTTON_HEIGHT + MCFPaperDollEquipmentManagerPaneEquipSet:GetHeight() + 20 , MCFPaperDollEquipmentManagerPane:GetHeight());
	
	local scrollOffset = HybridScrollFrame_GetOffset(MCFPaperDollEquipmentManagerPane);
	local buttons = MCFPaperDollEquipmentManagerPane.buttons;
	local selectedName = MCFPaperDollEquipmentManagerPane.selectedSetName;
	local name, texture, button, numLost;
	for i = 1, #buttons do
		if (i+scrollOffset <= numRows) then
			button = buttons[i];
			buttons[i]:Show();
			button:Enable();
			
			if (i+scrollOffset <= numSets) then
				-- Normal equipment set button
				name, texture, setID, isEquipped, _, _, _, numLost = C_EquipmentSet.GetEquipmentSetInfo(i+scrollOffset);
				button.name = name;
				button.text:SetText(name);
				if (numLost > 0) then
					button.text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				else
					button.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				end
				if (texture) then
					button.icon:SetTexture(texture);
				else
					button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
				end
							
				if (selectedName and button.name == selectedName) then
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
				button.icon:SetTexture("Interface\\AddOns\\ModernCharacterFrame\\Textures\\PaperDollInfoFrame\\Character-Plus");
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

--MCFFIX ready
function MCFPaperDollEquipmentManagerPaneSaveSet_OnClick (self)
	print("Function MCFPaperDollEquipmentManagerPaneSaveSet_OnClick just executed");
	local selectedSetName = MCFPaperDollEquipmentManagerPane.selectedSetName
	if (selectedSetName and selectedSetName ~= "") then
		local dialog = StaticPopup_Show("CONFIRM_SAVE_EQUIPMENT_SET", selectedSetName);
		if ( dialog ) then
			dialog.data = selectedSetName;
		else
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0);
		end
	end
end

--MCFFIX ready
--Temporary disabled
function MCFPaperDollEquipmentManagerPaneEquipSet_OnClick (self)
	print("Function MCFPaperDollEquipmentManagerPaneEquipSet_OnClick just executed");
	local selectedSetName = MCFPaperDollEquipmentManagerPane.selectedSetName;
	if ( selectedSetName and selectedSetName ~= "") then
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);	-- inappropriately named, but a good sound.
		--MCFFIX
		--EquipmentManager_EquipSet(selectedSetName);
	end
end

--MCFFIX READY
function MCFPaperDollTitlesPane_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = MCFPaperDollTitlesPane_UpdateScrollFrame;	
	HybridScrollFrame_CreateButtons(self, "MCFPlayerTitleButtonTemplate", 2, -4);
end

--MCFFIX READY
function MCFPaperDollTitlesPane_UpdateScrollFrame()
	local buttons = MCFPaperDollTitlesPane.buttons;
	local playerTitles = MCFPaperDollTitlesPane.titles;
	local numButtons = #buttons; -- 18
	local scrollOffset = HybridScrollFrame_GetOffset(MCFPaperDollTitlesPane);
	local playerTitle;
	for i = 1, numButtons do
		playerTitle = playerTitles[i + scrollOffset];
		if ( playerTitle ) then
			buttons[i]:Show();
			buttons[i].text:SetText(playerTitle.name);
			buttons[i].titleId = playerTitle.id;
			if ( MCFPaperDollTitlesPane.selected == playerTitle.id ) then
				buttons[i].Check:Show();
				buttons[i].SelectedBar:Show();
			else
				buttons[i].Check:Hide();
				buttons[i].SelectedBar:Hide();
			end
			
			if ((i+scrollOffset) == 1) then
				buttons[i].BgTop:Show();
				buttons[i].BgMiddle:SetPoint("TOP", buttons[i].BgTop, "BOTTOM");
			else
				buttons[i].BgTop:Hide();
				buttons[i].BgMiddle:SetPoint("TOP");
			end
			
			if ((i+scrollOffset) == #playerTitles) then
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

local function MCFPlayerTitleSort(a, b) return a.name < b.name; end 

--MCFFIX READY
function MCFPaperDollTitlesPane_Update()
	local playerTitles = { };
	local currentTitle = GetCurrentTitle();		
	local titleCount = 1;
	local buttons = MCFPaperDollTitlesPane.buttons;
	local fontstringText = buttons[1].text;
	local fontstringWidth;			
	local playerTitle = false;
	local tempName = 0;
	MCFPaperDollTitlesPane.selected = -1;
	playerTitles[1] = { };
	-- reserving space for None so it doesn't get sorted out of the top position
	playerTitles[1].name = "       ";
	playerTitles[1].id = -1;		
	for i = 1, GetNumTitles() do
		if ( IsTitleKnown(i) ~= false ) then		
			tempName, playerTitle = GetTitleName(i);
			if ( tempName and playerTitle ) then
				titleCount = titleCount + 1;
				playerTitles[titleCount] = playerTitles[titleCount] or { };
				playerTitles[titleCount].name = strtrim(tempName);
				playerTitles[titleCount].id = i;
				if ( i == currentTitle ) then
					MCFPaperDollTitlesPane.selected = i;
				end					
				fontstringText:SetText(playerTitles[titleCount].name);
			end
		end
	end

	table.sort(playerTitles, MCFPlayerTitleSort);
	playerTitles[1].name = PLAYER_TITLE_NONE;
	MCFPaperDollTitlesPane.titles = playerTitles;	

	HybridScrollFrame_Update(MCFPaperDollTitlesPane, titleCount * MCFPLAYER_TITLE_HEIGHT + 20 , MCFPaperDollTitlesPane:GetHeight());
	MCFPaperDollTitlesPane_UpdateScrollFrame();
end

--MCFFIX READY
function MCFPlayerTitleButton_OnClick(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	SetCurrentTitle(self.titleId);
end

--MCFFIX READY
function MCFSetTitleByName(name)
	name = strlower(name);
	for i = 1, GetNumTitles() do
		if ( IsTitleKnown(i) ~= false ) then
			local title = GetTitleName(i);
			title = strlower(strtrim(title));
			if(title:find(name) == 1) then
				SetCurrentTitle(i);
				return true;
			end
		end
	end
	return false;
end

--MCFFIX READY
function MCFSetPaperDollBackground(model, unit)
	local race, fileName = UnitRace(unit);
	local texture = DressUpTexturePath(fileName);
	--MCFFIX hack to make troll's texture actual troll's instead of orc's. Need to check other races (like gnomes). Files are in the game.
	if ( fileName == "Troll" ) then
		texture = "Interface\\DressUpFrame\\DressUpBackground-Troll"
	end

	model.BackgroundTopLeft:SetTexture(texture..1);
	model.BackgroundTopRight:SetTexture(texture..2);
	model.BackgroundBotLeft:SetTexture(texture..3);
	model.BackgroundBotRight:SetTexture(texture..4);
	
	-- HACK - Adjust background brightness for different races
	if ( strupper(fileName) == "BLOODELF") then
		model.BackgroundOverlay:SetAlpha(0.8);
	elseif (strupper(fileName) == "NIGHTELF") then
		model.BackgroundOverlay:SetAlpha(0.6);
	elseif ( strupper(fileName) == "SCOURGE") then
		model.BackgroundOverlay:SetAlpha(0.3);
	elseif ( strupper(fileName) == "TROLL" or strupper(fileName) == "ORC") then
		model.BackgroundOverlay:SetAlpha(0.6);
	elseif ( strupper(fileName) == "WORGEN" ) then
		model.BackgroundOverlay:SetAlpha(0.5);
	elseif ( strupper(fileName) == "GOBLIN" ) then
		model.BackgroundOverlay:SetAlpha(0.6);
	else
		model.BackgroundOverlay:SetAlpha(0.7);
	end
end

--MCFFIX READY
function MCFPaperDollBgDesaturate(on)
	MCFCharacterModelFrameBackgroundTopLeft:SetDesaturated(on);
	MCFCharacterModelFrameBackgroundTopRight:SetDesaturated(on);
	MCFCharacterModelFrameBackgroundBotLeft:SetDesaturated(on);
	MCFCharacterModelFrameBackgroundBotRight:SetDesaturated(on);
end

--MCFFIX READY
function MCFPaperDollFrame_UpdateSidebarTabs()
	for i = 1, #MCFPAPERDOLL_SIDEBARS do
		local tab = _G["MCFPaperDollSidebarTab"..i];
		if (tab) then
			if (_G[MCFPAPERDOLL_SIDEBARS[i].frame]:IsShown()) then
				tab.Hider:Hide();
				tab.Highlight:Hide();
				tab.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.78906250, 0.95703125);
			else
				tab.Hider:Show();
				tab.Highlight:Show();
				tab.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.61328125, 0.78125000);
			end
		end
	end
end

--MCFFIX READY
function MCFPaperDollFrame_SetSidebar(self, index)
	if (not _G[MCFPAPERDOLL_SIDEBARS[index].frame]:IsShown()) then
		for i = 1, #MCFPAPERDOLL_SIDEBARS do
			_G[MCFPAPERDOLL_SIDEBARS[i].frame]:Hide();
		end
		_G[MCFPAPERDOLL_SIDEBARS[index].frame]:Show();
		MCFPaperDollFrame.currentSideBar = _G[MCFPAPERDOLL_SIDEBARS[index].frame];
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		MCFPaperDollFrame_UpdateSidebarTabs();
	end
end
