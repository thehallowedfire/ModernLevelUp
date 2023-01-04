local _, L = ...;

if GetLocale() == "ruRU" then
    L["MCF_OPTIONS_DESCRIPTION"] = "Re-skins default Character frame into modern version.\n\nВерсия: " .. GetAddOnMetadata("ModernCharacterFrame", "Version") .. ".\nАвтор: Профессия — Flamegor (EU).";
    L["MCF_OPTIONS_TT_INTEGRATION_TITLE"] = "TacoTip's Gear Score";
    L["MCF_OPTIONS_TT_INTEGRATION_TITLE_DISABLED"] = "TacoTip's Gear Score "..RED_FONT_COLOR_CODE.."(аддон не загружен)"..FONT_COLOR_CODE_CLOSE;
    L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_LABEL"] = "Отображение Gear Score";
    L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_TOOLTIP"] = "Отображение значения Gear Score в панели характеристик в строке \"Ур. предметов\"";
    L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_LABEL"] = "Вариант отображения";
    L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_TOOLTIP"] = "Вариант отображения значения Gear Score в панели характеристик";
    L["MCF_OPTIONS_TT_INTEGRATION_COLOR_LABEL"] = "Окрашивание Gear Score";
    L["MCF_OPTIONS_TT_INTEGRATION_COLOR_TOOLTIP"] = "Включить окрашивание значения Gear Score согласно его величине";

    L["MCF_PLAYER_LEVEL"] = "|c%2$s%4$s (%3$s)|r %1$s-го уровня";
    L["MCF_PLAYER_LEVEL_NO_SPEC"] = "|c%2$s%3$s|r %1$s-го уровня";

    L["MCF_STATS_COLLAPSE_TOOLTIP"] = "Скрыть информацию о персонаже";
    L["MCF_STATS_EXPAND_TOOLTIP"] = "Показать информацию о персонаже";
    L["MCF_PET_STATS_COLLAPSE_TOOLTIP"] = "Скрыть информацию о питомце";
    L["MCF_PET_STATS_EXPAND_TOOLTIP"] = "Показать информацию о питомце";

    L["MCF_DEFAULT_STAT1_TOOLTIP"] = "Сила атаки увеличена на %d.";
    L["MCF_DEFAULT_STAT2_TOOLTIP"] = "Повышает вероятность нанести критический удар на %.2f%%.";
    L["MCF_DEFAULT_STAT3_TOOLTIP"] = "Максимальный уровень здоровья увеличен на %d.";
    L["MCF_DEFAULT_STAT4_TOOLTIP"] = "Запас маны увеличен на %d|nСила заклинаний увеличена (НЕПРАВИЛЬНО РАБОТАЕТ) на %d|nВероятность нанести критический удар заклинанием повышена на %.2f%%.";
    L["MCF_MANA_REGEN_FROM_SPIRIT"] = "Скорость восполнения маны +%d каждые 5 сек. (если персонаж не творит заклинания)";
    L["MCF_STAT_TOOLTIP_BONUS_AP"] = "Увеличивает силу атаки на %d\13";

    L["MCF_STAT_MOVEMENT_SPEED"] = "Скорость";
    L["MCF_STAT_ATTACK_POWER"] = "Сила атаки";
    L["MCF_STAT_DPS_SHORT"] = "Урон в сек";
    L["MCF_WEAPON_SPEED"] = "Скорость атаки";
    L["MCF_STAT_HASTE"] = "Скорость";
    L["MCF_STAT_ARMOR_PENETRATION"] = "Пробивание брони";

    L["MCF_CR_CRIT_MELEE_TOOLTIP"] = "Вероятность нанести дополнительный урон.\nРейтинг: %d (вероятность нанести критический удар +%.2f%%).";
    L["MCF_CR_CRIT_RANGED_TOOLTIP"] = "Вероятность нанести дополнительный урон в дальнем бою.\nРейтинг: %d (вероятность нанести критический удар +%.2f%%).";
    L["MCF_CR_CRIT_SPELL_TOOLTIP"] = "Вероятность нанести дополнительный урон заклинанием.\nРейтинг: %d (вероятность нанести критический удар заклинанием +%.2f%%).";
    L["MCF_STAT_HASTE_BASE_TOOLTIP"] = "\nРейтинг скорости: %d (скорость +%.2f%%)";
    L["MCF_MANA_REGEN_TOOLTIP"] = "%d ед. маны восполняется раз в 5 секунд, если вы не участвуете в бою.";
    L["MCF_CR_BLOCK_TOOLTIP"] = "Рейтинг блока %d увеличивает вероятность блокировать удар на %.2f%%.\nПри успешном блоке урон уменьшается на %d%%.";
    L["MCF_RESISTANCE_TOOLTIP_SUBTEXT"] = "Уменьшает урон, получаемый персонажем от атак, в ходе которых используется %s, в среднем на %.2f%%.";
    L["MCF_CR_ARMOR_PENETRATION_TOOLTIP"] = "Снижение брони противника (только для ваших атак).\nРейтинг: %d (броня противника уменьшена на %.2f%%).";

    L["MCF_STAT_AVERAGE_ITEM_LEVEL"] = "Ур. предметов";
    L["MCF_STAT_AVERAGE_ITEM_LEVEL_EQUIPPED"] = "(Надето %d)";
    L["MCF_STAT_GEARSCORE_LABEL"] = "Ур. предметов (GS)";
    L["MCF_STAT_GEARSCORE"] = "(Gear Score %d)";
end