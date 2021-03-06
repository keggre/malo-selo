// RUNS WHEN A VILLAGE IS CAPTURED

if (false) exitWith {};

params["_name"];

// WAIT UNTIL VILLAGE IS LOADED
/*waitUntil {missionNamespace getVariable [(_name + "_discovered"), false]};*/

// SET [VILLAGE]_SERB TRUE
call compile (_name + "_serb = true;");

// CREATE LOCAL VARIABLES FROM THE VILLAGE GLOBAL VARIABLES
/*private _pois = call compile (_name + "_pois");*/
private _capsquad_nums = call compile (_name + "_capsquad_nums");

private _unit_radius = missionNamespace getVariable [_name + "_unit_radius", 100];
private _load_radius = missionNamespace getVariable [_name + "_load_radius", 500];

private _flag = missionNamespace getVariable [_name + "_flag", "None"];

private _civs = missionNamespace getVariable [_name + "_civs", []];
private _objects_delete = missionNamespace getVariable [_name + "_objects_delete", []];

// ACTIVATE THE POI TRIGGERS
/*{
	_trg = missionNamespace getVariable ("trg_" + _x);
	_trg setTriggerArea [5000,5000,0,false,100]; 
} forEach _pois;*/

// CHANGE THE VILLAGE FLAG TEXTURE
/*if !(_flag isEqualTo "None") then {
	_flag setFlagTexture "images\srpska.jpg";
};*/

// NOTIFY THE USER THAT THE VILLAGE HAS BEEN CAPTURED
call compile ("hint ('We have captured ' + " + _name + "_fullname + '.');");

// KILL OFF THE VILLAGE MARKER (ACTUALLY A UNIT)
call compile (_name + "_marker setDamage 1;");

// ACTIVATE THE VILLAGE CAPSQUADS
{
	call compile ("[cap_" + str _x + ", getMarkerPos 'cap_marker_" + str _x + "'] spawn MALO_fnc_capsquads;");
} forEach _capsquad_nums;

// ADD RESPAWN MARKER
[_name] call MALO_fnc_createRespawn;

// SHOW VILLAGE MARKER
_name setMarkerAlpha 1;

// DELETE OBJECTS
(_civs + _objects_delete) spawn MALO_fnc_deleteObjects;

// IF VILLAGE WAS CAPTURED IN PREVIOUS SAVE
if (_name in MALO_mission_progress) then {

	// DESTROY BUILDINGS
	if (true /*_name != "pusta"*/) then {
		call compile ("
			[ (getMarkerPos '" + _name + "'), " + str _load_radius + ", MALO_building_types, 0, 0, 1] spawn MALO_fnc_damageWithinRadius;
		");
	};

};

// IF VILLAGE IS CAPTURED AND PLAYERS HAVE LEFT THE AREA
private _trg = createTrigger ["EmptyDetector", getMarkerPos _name];
_trg setTriggerArea [(_load_radius * 2), (_load_radius * 2), 0, false];
_trg setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];
_trg setTriggerStatements ["this", ("
	" + _name + "_jeep hideObjectGlobal false;
"), ""];

// UN RETREAT FOR GUGLOVO
if (_name == "guglovo") then {
	[1,2] spawn MALO_fnc_deleteUnCheckpoints;
	{_x enableAi "ALL";} forEach units lepo_selo_squad;
};

// TRENCH FALLBACKS FOR NOVY
if (_name == "novy") then {
	{
		private _units = units _x;
		{_x enableAi "ALL";} forEach _units;
		_units spawn MALO_fnc_deleteObjects; 
	} forEach [t_enemy_1, t_enemy_2, t_friendly_1];
	{deleteMarker _x;} forEach ["t_install_1", "t_install_2"];
};

// UN RETREAT FOR MSTA
if (_name == "msta") then {
	[3,4,5] spawn MALO_fnc_deleteUnCheckpoints; 
	([un_heli_1] + (units un_pilots_1)) spawn MALO_fnc_deleteObjects;
};

// TRENCH FALLBACK FOR PUSTA
if (_name == "pusta") then {
	{
		private _units = units _x;
		{_x enableAi "ALL";} forEach _units;
		_units spawn MALO_fnc_deleteObjects; 
	} forEach [t_enemy_3];	
	{deleteMarker _x;} forEach ["t_install_3"];
};

// ADD PANTERI FOR STARY
if (_name == "stary") then {
	/*[kapetan, "panteri"] call BIS_fnc_addCommMenuItem;*/
};

// ELEKTROZAVODSK RETREAT
if (_name == "elektrozavodsk") then {
	{
		private _num = _x;
		private _group = missionNamespace getVariable [("e_squad_obj_" + (str _num)), grpNull];
		{
			private _unit = _x;
			_unit setSkill .2;
		} forEach units _group;
	} forEach [1,2,3,4,5,6,7];
	{
		private _turret = _x;
		_turret setVehicleAmmo 0;
	} forEach [e_turret_1, e_turret_2];
	mortar_2_op setDamage 1;
	[6] spawn MALO_fnc_deleteUnCheckpoints;
};

//////////////////////////////////////////////

// ADD TO MISSION PROGRESS
[_name] spawn MALO_fnc_saveKeyword;