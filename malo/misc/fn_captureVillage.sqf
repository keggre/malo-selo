// RUNS WHEN A VILLAGE IS CAPTURED

if (false) exitWith {};

params["_name"];

// WAIT UNTIL VILLAGE IS LOADED
/*waitUntil {missionNamespace getVariable [(_name + "_discovered"), false]};*/

// SET [VILLAGE]_SERB TRUE
call compile (_name + "_serb = true;");

// CREATE LOCAL VARIABLES FROM THE VILLAGE GLOBAL VARIABLES
private _pois = call compile (_name + "_pois");
private _capsquad_nums = call compile (_name + "_capsquad_nums");

private _unit_radius = missionNamespace getVariable [_name + "_unit_radius", 100];
private _load_radius = missionNamespace getVariable [_name + "_load_radius", 500];

private _flag = missionNamespace getVariable [_name + "_flag", "None"];

// ACTIVATE THE POI TRIGGERS
{
	_trg = missionNamespace getVariable ("trg_" + _x);
	_trg setTriggerArea [5000,5000,0,false,100]; 
} forEach _pois;

// CHANGE THE VILLAGE FLAG TEXTURE
if !(_flag isEqualTo "None") then {
	_flag setFlagTexture "img\srpska.jpg";
};

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

// IF VILLAGE WAS CAPTURED IN PREVIOUS SAVE
if (_name in MALO_mission_progress) then {

	// DELETE CIVS
	private _var = missionNamespace getVariable [_name + "_civs", []];
	{deleteVehicle _x;} forEach _var;

	// DESTROY BUILDINGS
	call compile ("
		[ (getMarkerPos '" + _name + "'), " + str _load_radius + ", [], 0, .5, 1.25] spawn MALO_fnc_damageWithinRadius;
	");

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
	{_x enableAi "PATH";} forEach units un_check1_units; 
	{_x enableAi "PATH";} forEach units un_check2_units; 
	{
		call compile ("
			[({if (!isPlayer (driver _x)) then {deleteVehicle _x;};} forEach un_check" + (str _x) + "_objects_delete), (getMarkerPos 'un_check" + (str _x) + "'), 500] spawn MALO_fnc_noPlayersNearby;
		");
	} forEach [1,2];
	un_check1_apc setVehicleAmmo 0; 
	if (_name in MALO_mission_progress) then {
		{deleteVehicle _x;} forEach units un_check1_units; 
		{deleteVehicle _x;} forEach units un_check2_units; 
		deleteVehicle un_check1_apc;
	};
};

// TRENCH FALLBACKS FOR NOVY
if (_name == "novy") then {
	{_x enableAi "ALL";} forEach units t_enemy_1;  
	{_x enableAi "ALL";} forEach units t_enemy_2; 
	{_x enableAi "ALL";} forEach units t_friendly_1;
	if (_name in MALO_mission_progress) then {
		{deleteVehicle _x;} forEach units t_enemy_1;  
		{deleteVehicle _x;} forEach units t_enemy_2; 
		{deleteVehicle _x;} forEach units t_friendly_1;
	};
};

// ACTIVATE PLANE AND UN RETREAT FOR MSTA
if (_name == "msta") then {
	/*us_plane_1 enableSimulation true;*/
	{_x enableAi "PATH";} forEach units un_check3_units; 
	{_x enableAi "PATH";} forEach units un_check4_units; 
	{_x enableAi "PATH";} forEach units un_check5_units; 
	un_check3_apc setVehicleAmmo 0; 
	un_check4_apc setVehicleAmmo 0; 
	un_check5_apc setVehicleAmmo 0;
	if (_name in MALO_mission_progress) then {
		{deleteVehicle _x;} forEach units un_pilots_1; 
		deleteVehicle un_heli_1;
		deleteVehicle us_plane_1;
		{deleteVehicle _x;} forEach units un_check3_units; 
		{deleteVehicle _x;} forEach units un_check4_units; 
		{deleteVehicle _x;} forEach units un_check5_units; 
		deleteVehicle un_check3_apc; 
		deleteVehicle un_check4_apc; 
		deleteVehicle un_check5_apc;
	};
};

// TRENCH FALLBACK FOR PUSTA
if (_name == "pusta") then {
	{_x enableAi "ALL";} forEach units t_enemy_3;
	if (_name in MALO_mission_progress) then {
		{deleteVehicle _x} forEach units t_enemy_3;
	};
};

// STARY
if (_name == "stary") then {
	// nothing yet
};

//////////////////////////////////////////////

// ADD TO MISSION PROGRESS
[_name] spawn MALO_fnc_savePush;