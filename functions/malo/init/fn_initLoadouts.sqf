// SELECTS AI LOADOUTS

if (!isServer) exitWith {};

MALO_bosnian_loadouts = [

	[
		"SP_M81_Camo",
		"rhssaf_vest_md99_woodland_radio"

	],

	[
		"rhgref_uniform_woodland",
		"rhssaf_vest_md99_woodland_radio"

	]

]; publicVariable "MALO_bosnian_loadouts";

/*{

	private _leader = leader _x;
	private _group = _x;

	private _types = [];
	{_types append [typeOf _x];} forEach units _group;
	
	if (side _leader == west) then {

		private _excluded = [smugglers, tigrovi];
		if (_group in _excluded) exitWith {};

		private _excluded_types = ["LOP_UN_Infantry_Rifleman"];
		private _condition = false;
		{if (_x in _excluded_types) then {_condition = true};} forEach _types;
		if (_condition) exitWith {};

		private _loadout = selectRandom MALO_bosnian_loadouts;

		private _uniform = _loadout select 0;
		private _vest = _loadout select 1;

		{
			_x forceAddUniform _uniform;
			_x addVest _vest;

		} forEach units _group;

	};

} forEach allGroups;*/