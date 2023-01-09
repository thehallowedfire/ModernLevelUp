local _, MLU = ...;

local _, class = UnitClass("player");
if (class ~= "HUNTER") then return end;

MLU.SpellsByLevel = {
    [1] = {{id = 1494},},
    [4] = {{id = 13163},{id = 1978},},
	[6] = {{id = 3044},{id = 1130},},
	[8] = {{id = 3127},{id = 5116},{id = 14260},},
	[10] = {{id = 13165},{id = 13549},{id = 19883},},

	[12] = {{id = 136},{id = 14281},{id = 20736},{id = 2974},},
	[14] = {{id = 6197},{id = 1002},{id = 1513},},
	[16] = {{id = 5118},{id = 13795},{id = 1495},{id = 14261},},
	[18] = {{id = 14318},{id = 2643},{id = 13550},{id = 19884},},	
    [20] = {{id = 34074},{id = 3111},{id = 674},{id = 14282},{id = 781},{id = 1499},},
    
    [22] = {{id = 14323},{id = 3043},},
	[24] = {{id = 1462},{id = 14262},{id = 19885},},
	[26] = {{id = 3045},{id = 13551},{id = 14302},{id = 19880},},
	[28] = {{id = 14319},{id = 3661},{id = 20900},{id = 14283},{id = 13809},},
	[30] = {{id = 13161},{id = 14326},{id = 14288},{id = 5384},{id = 14269},},
	
    [32] = {{id = 1543},{id = 14263},{id = 19878},},
	[34] = {{id = 13552},{id = 13813},},
	[36] = {{id = 3662},{id = 20901},{id = 14284},{id = 3034},{id = 14303},},
	[38] = {{id = 14320},},	
    [40] = {{id = 13159}--[[ ,{id = 8737} ]],{id = 14324},{id = 1510},{id = 14310},{id = 14264},{id = 19882},},
	
    [42] = {{id = 14289},{id = 13553},{id = 20909},},
	[44] = {{id = 13542},{id = 20902},{id = 14285},{id = 14316},{id = 14270},},
	[46] = {{id = 20043},{id = 14327},{id = 14304},},
	[48] = {{id = 14321},{id = 14265},},
	[50] = {{id = 13554},{id = 56641},{id = 14294},{id = 19879},{id = 24132},},
	
    [52] = {{id = 13543},{id = 20903},{id = 14286},},
	[54] = {{id = 14290},{id = 20910},{id = 14317},},
	[56] = {{id = 20190},{id = 14305},{id = 14266},},
	[57] = {{id = 63668},},
	[58] = {{id = 14322},{id = 14325},{id = 13555},{id = 14295},{id = 14271},},
	[60] = {{id = 25296},{id = 13544},{id = 20904},{id = 14287},{id = 25294},{id = 25295},{id = 19801},{id = 19263},{id = 14311},{id = 24133},},
	
    [61] = {{id = 27025},},
	[62] = {{id = 34120},},
	[63] = {{id = 63669},{id = 27014},},
	[65] = {{id = 27023},},
	[66] = {{id = 34026},{id = 27067},},
	[67] = {{id = 27021},{id = 27016},{id = 27022},},
	[68] = {{id = 27044},{id = 27045},{id = 27046},{id = 34600},},
	[69] = {{id = 27019},{id = 63670},},
	[70] = {{id = 27065},{id = 60051},{id = 34477},{id = 36916},{id = 27068},},
	
    [71] = {{id = 53351},{id = 49051},{id = 49066},{id = 48995},},
	[72] = {{id = 48998},{id = 49055},},
	[73] = {{id = 49044},{id = 49000},},
	[74] = {{id = 61846},{id = 48989},{id = 49047},{id = 58431},},
	[75] = {{id = 53271},{id = 49049},{id = 61005},{id = 63671},{id = 60052},{id = 49011},},
	[76] = {{id = 49071},{id = 53338},},
	[77] = {{id = 49052},{id = 49067},{id = 48996},},
	[78] = {{id = 48999},{id = 49056},},
	[79] = {{id = 49045},{id = 49001},},
	[80] = {{id = 61847},{id = 62757},{id = 48990},{id = 49050},{id = 61006},{id = 49048},{id = 58434},{id = 63672},{id = 60053},{id = 60192},{id = 53339},{id = 49012},},
};