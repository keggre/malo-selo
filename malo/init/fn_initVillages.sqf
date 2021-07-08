if (!isServer) exitWith {};

villages = [
	"chernogorsk",
	"dolina",
	"elektrozavodsk",
	"guglovo",
	"kamushovo", 
	"mogilevka",
	"msta",
	"nadezhdino",
	"novy",
	"orlovets",
	"polana",
	"pusta",
	"shakhovka",
	"solnychniy",
	"staroye",
	"stary",
	"tulga",
	"vyshnoye"
]; publicVariable "villages";


serb_villages = [
	"dolina",
	"orlovets",
	"polana",
	"shakhovka",
	"solnychniy",
	"staroye"
];

village_capsquad_nums = [

	/*chernogorsk*/			[],
	/*dolina*/				[],
	/*elektrozavodsk*/		[],
	/*guglovo*/				[1],
	/*kamushovo*/			[],
	/*mogilevka*/			[],
	/*msta*/				[6,7],
	/*nadezhdino*/			[],
	/*novy*/				[2,3],
	/*orlovets*/			[],
	/*polana*/				[],
	/*pusta*/				[8,9],
	/*shakhovka*/			[],
	/*solnychniy*/			[],
	/*staroye*/				[],
	/*stary*/				[4,5],
	/*tulga*/				[],
	/*vyshnoye*/			[]

]; publicVariable "village_capsquad_nums";

village_fullnames = [
	"Chernogorsk",
	"Dolina",
	"Elektrozavodsk",
	"Guglovo",
	"Kamushovo", 
	"Mogilevka",
	"Msta",
	"Nadezhdino",
	"Novy Sobor",
	"Orlovets",
	"Polana",
	"Pusta",
	"Shakhovka",
	"Solnychniy",
	"Staroye",
	"Stary Sobor",
	"Tulga",
	"Vyshnoye"
]; publicVariable "village_fullnames";


// CREATE [VILLAGE]_SERB VARIABLE FOR EACH VILLAGE

{

	_condition = false;

	if (_x in serb_villages) then {

		_condition = true;

	} else {

		_condition = false;

	};

	call compile (_x + "_serb = " + (str _condition) + ";");
	publicVariable (_x + "_serb");

} forEach villages;


// CREATE [VILLAGE]_POIS LIST FOR EACH VILLAGE

{

	call compile (_x + "_pois = [];");
	publicVariable (_x + "_pois");
	
	_i = 0;

	for "_i" from 0 to (count poi_villages) - 1 do {

		_item1 = (poi_villages select _i);
		_item2 = (pois select _i);

		if (_item1 == _x) then {

			call compile (_x + "_pois append ['" + _item2 + "'];");
			publicVariable (_x + "_pois");

		};

	};

} foreach villages;


// CREATE [VILLAGE]_CAPSQUAD_NUMS FOR EACH VILLAGE

_i = 0;

for "_i" from 1 to (count villages) - 1 do {

	_item1 = (villages select _i);
	_item2 = str (village_capsquad_nums select _i);

	call compile (_item1 + "_capsquad_nums = " + _item2);
	publicVariable (_item1 + "_capsquad_nums");

};


// CREATE [VILLAGE]_FULLNAME VARIABLE FOR EACH VILLAGE

_i = 0;

for "_i" from 0 to (count villages) - 1 do {

	_item1 = (villages select _i);
	_item2 = (village_fullnames select _i);

	call compile (_item1 + "_fullname = '" + _item2 + "';");
	publicVariable (_item1 + "_fullname");

};
