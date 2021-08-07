// SAVES GROUPS TO VARIABLES TO BE RESPAWNED LATER

if (!isServer) exitWith {};

params ["_name", "_groups"];

private _array = [];

MALO_fnc_saveGroups_unit = {

	params ["_unit"];

	private _namespace = (true call CBA_fnc_createNamespace);
	_namespace enableSimulation false;

	// SAVE VARNAME, TYPE, POSITION AND INVENTORY
	_namespace setVariable ["_varname", (vehicleVarName _unit)];
	_namespace setVariable ["_type", (typeOf _unit)];
	_namespace setVariable ["_position", (position _unit)];
	[_unit, [_namespace, "_inventory"]] call BIS_fnc_saveInventory;

	_namespace

};

MALO_fnc_saveGroups_group = {

	params ["_group"];

	private _namespace = (true call CBA_fnc_createNamespace);
	_namespace enableSimulation false;

	// SAVE GROUP ID
	_namespace setVariable ["_id", (groupId _group)];
	
	// SAVE UNITS
	private _units = [];
	{
		_units append [(_x call MALO_fnc_saveGroups_unit)]
	} forEach units _group;
	_namespace setVariable ["_units", _units];

	// SAVE SIDE, WAYPOINTS, COMBAT MODE AND SPEED MODE
	_namespace setVariable ["_side", (side _group)];
	_namespace setVariable ["_waypoints", (waypoints _group)];
	_namespace setVariable ["_combat_mode", (combatMode _group)];
	_namespace setVariable ["_speed_mode", (speedMode _group)];

	_namespace

};


// SAVE GROUPS AND THEIR UNITS TO ARRAY

{

	_array append [(_x call MALO_fnc_saveGroups_group)];

} forEach _groups;

missionNamespace setVariable [("MALO_saved_" + _name), _array, true];


// DELETE GROUPS AND THEIR UNITS

{

	{

		deleteVehicle _x;

	} forEach units _x;

	deleteGroup _x;

} forEach _groups;