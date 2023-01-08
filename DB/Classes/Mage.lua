local _, MLU = ...;

local _, class = UnitClass("player");
if (class ~= "MAGE") then return end;
MLU.SpellsByLevel = {
    [1] = {{id = 1459},},
	[4] = {{id = 5504},{id = 116},},
	[6] = {{id = 587},{id = 2136},{id = 143},},
	[8] = {{id = 5143},{id = 118},{id = 205},},
	[10] = {{id = 5505},{id = 7300},{id = 122},},
	
	[12] = {{id = 597},{id = 604},{id = 130},{id = 145},},
	[14] = {{id = 1449},{id = 1460},{id = 2137},{id = 837},},
	[16] = {{id = 5144},{id = 2120},},
	[18] = {{id = 1008},{id = 475},{id = 3140},},
	[20] = {{id = 1953},{id = 5506},{id = 12051},{id = 1463},{id = 12824},{id = 543},{id = 10},{id = 7301},{id = 7322},{id = 3561, faction = "Alliance"},{id = 3562, faction = "Alliance"},{id = 32271, faction = "Alliance"},{id = 3567, faction = "Horde"},{id = 3563, faction = "Horde"},{id = 32272, faction = "Horde"},},
	
	[22] = {{id = 8437},{id = 990},{id = 2138},{id = 2948},{id = 6143},},
	[24] = {{id = 5145},{id = 2139},{id = 8450},{id = 8400},{id = 2121},{id = 12505},},
	[26] = {{id = 120},{id = 865},{id = 8406},},
	[28] = {{id = 1461},{id = 759},{id = 8494},{id = 8444},{id = 6141},},
	[30] = {{id = 8455},{id = 8438},{id = 6127},{id = 8412},{id = 8457},{id = 8401},{id = 12522},{id = 7302},{id = 45438},{id = 3565, faction = "Alliance"},{id = 3566, faction = "Horde"},},

	[32] = {{id = 8416},{id = 6129},{id = 8422},{id = 8461},{id = 8407},},
	[34] = {{id = 6117},{id = 8445},{id = 8492},},
	[35] = {{id = 49360, faction = "Alliance"},{id = 49359, faction = "Alliance"},{id = 49361, faction = "Horde"},{id = 49358, faction = "Horde"},},
	[36] = {{id = 8451},{id = 8495},{id = 13018},{id = 8402},{id = 12523},{id = 8427},},
	[38] = {{id = 8439},{id = 3552},{id = 8413},{id = 8408},},
	[40] = {{id = 8417,},{id = 10138},{id = 12825},{id = 8458},{id = 8423},{id = 8446},{id = 6131},{id = 7320},{id = 10059, faction = "Alliance"},{id = 11416, faction = "Alliance"},{id = 32266, faction = "Alliance"},{id = 11417, faction = "Horde"},{id = 11418, faction = "Horde"},{id = 32267, faction = "Horde"},},
	
	[42] = {{id = 10169},{id = 10156},{id = 10144},{id = 10148},{id = 12524},{id = 10159},{id = 8462},},
	[44] = {{id = 10191},{id = 13019},{id = 10185},{id = 10179},},
	[46] = {{id = 10201},{id = 22782},{id = 10197},{id = 10205},{id = 13031},},
	[48] = {{id = 10211},{id = 10053},{id = 10173},{id = 10149},{id = 10215},{id = 12525},},
	[50] = {{id = 10139},{id = 10223},{id = 10160},{id = 10180},{id = 10219},{id = 11419, faction = "Alliance"},{id = 11420, faction = "Horde"},},
	
	[52] = {{id = 10145},{id = 10192},{id = 13020},{id = 10206},{id = 10186},{id = 10177},{id = 13032},},
	[54] = {{id = 10170},{id = 10202},{id = 10199},{id = 10150},{id = 12526},{id = 10230},},
	[56] = {{id = 23028},{id = 10157},{id = 10212},{id = 33041},{id = 10216},{id = 10181},},
	[58] = {{id = 10054},{id = 22783},{id = 10207},{id = 10161},{id = 13033},},
	[60] = {{id = 25345},{id = 28612},{id = 10140},{id = 10174},{id = 10193},{id = 12826},{id = 13021},{id = 10225},{id = 10151},{id = 18809},{id = 10187},{id = 28609},{id = 25304},{id = 10220},{id = 33690, faction = "Alliance"},{id = 35715, faction = "Horde"},},
	
	[61] = {{id = 27078},},
	[62] = {{id = 27080},{id = 25306},{id = 30482},},
	[63] = {{id = 27130},{id = 27075},{id = 27071},},
	[64] = {{id = 30451},{id = 33042},{id = 27086},{id = 27134},},
	[65] = {{id = 37420},{id = 27133},{id = 27073},{id = 27087},{id = 35717, faction = "Horde"},{id = 33691, faction = "Alliance"},},
	[66] = {{id = 27070},{id = 27132},{id = 30455},},
	[67] = {{id = 33944},{id = 27088},},
	[68] = {{id = 27101},{id = 66},{id = 27131},{id = 27085},},
	[69] = {{id = 33946},{id = 38699},{id = 27125},{id = 27128},{id = 27072},{id = 27124},},
	[70] = {{id = 44780},{id = 27127},{id = 27082},{id = 27126},{id = 38704},{id = 33717},{id = 27090},{id = 43987},{id = 30449},{id = 33933},{id = 33043},{id = 27079},{id = 38692},{id = 55359},{id = 33938},{id = 27074},{id = 32796},{id = 38697},{id = 33405},},
	
	[71] = {{id = 42894},{id = 43023},{id = 43045},{id = 53140},},
	[72] = {{id = 42925},{id = 42930},{id = 42913},},
	[73] = {{id = 43019},{id = 42890},{id = 42858},},
	[74] = {{id = 42872},{id = 42832},{id = 42939},{id = 53142},},
	[75] = {{id = 42843},{id = 42955},{id = 42944},{id = 42949},{id = 44614},{id = 42917},{id = 42841},{id = 43038},},
	[76] = {{id = 42896},{id = 42920},{id = 43015},},
	[77] = {{id = 43017},{id = 42985},{id = 42891},},
	[78] = {{id = 43010},{id = 42833},{id = 42859},{id = 42914},},
	[79] = {{id = 42846},{id = 43024},{id = 43020},{id = 42926},{id = 43046},{id = 42931},{id = 43012},{id = 42842},{id = 43008},},
	[80] = {{id = 44781},{id = 42897},{id = 43002},{id = 42921},{id = 42995},{id = 42956},{id = 55342},{id = 58659},{id = 42945},{id = 42950},{id = 42873},{id = 47610},{id = 55360},{id = 42940},{id = 43039},},
};