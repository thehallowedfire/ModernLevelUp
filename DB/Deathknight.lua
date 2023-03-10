local _, MLU = ...;

local _, class = UnitClass("player");
if (class ~= "DEATHKNIGHT") then return end;

MLU.SpellsByLevel = {
	[55] = {{id = 53341},{id = 53343},},
	[56] = {{id = 50842},{id = 49998},{id = 46584},},
	[57] = {{id = 48263},{id = 47528},{id = 54447},{id = 53342},},
	[58] = {{id = 48721},{id = 45524},},
	[59] = {{id = 49926},{id = 55258},{id = 47476},},
	[60] = {{id = 51416},{id = 53331},{id = 51325},{id = 43265},{id = 49917},},

	[61] = {{id = 49896},{id = 49020},{id = 3714},},
	[62] = {{id = 48792},{id = 49892},},
	[63] = {{id = 54446},{id = 53323},{id = 49999},},
	[64] = {{id = 49927},{id = 45529},{id = 55259},},
	[65] = {{id = 56222},{id = 51417},{id = 57330},{id = 49918},},
	[66] = {{id = 49939},{id = 48743},},
	[67] = {{id = 49903},{id = 51423},{id = 56815},{id = 49936},{id = 55265},},
	[68] = {{id = 48707},{id = 49893},},
	[69] = {{id = 49928},{id = 55260},},
	[70] = {{id = 51418},{id = 51409},{id = 53344},{id = 51326},{id = 45463},{id = 49919},{id = 48265},},
	
	[72] = {{id = 49940},{id = 70164},{id = 62158},{id = 61999},},
	[73] = {{id = 49904},{id = 51424},{id = 49937},{id = 55270},},
	[74] = {{id = 49929},{id = 55261},},
	[75] = {{id = 47568},{id = 51419},{id = 57623},{id = 51410},{id = 51327},{id = 49923},{id = 49920},},
	[76] = {{id = 49894},},
	[78] = {{id = 49941},{id = 49909},},
	[79] = {{id = 51425},{id = 55271},},
	[80] = {{id = 49930},{id = 55262},{id = 55268},{id = 51411},{id = 42650},{id = 51328},{id = 49895},{id = 49924},{id = 49938},{id = 49921},},
};