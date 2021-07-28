// LOADS GROUPS SAVED AS VARIABLES

if (!isServer) exitWith {};

params ["_name"];

private _array = (missionNamespace getVariable [("MALO_saved_" + _name), []]);

MALO_fnc_loadGroups_unit = {

	params ["_namespace"];

	private _varname = _namespace getVariable ["_varname", (vehicleVarName _unit)];
	private _type = _namespace getVariable ["_type", (typeOf _unit)];
	private _position = _namespace getVariable ["_position", (position _unit)];

	private _unit = createUnit 

	[_unit, [_namespace, "_inventory"]] call BIS_fnc_loadInventory;

	_unit

};

MALO_fnc_loadGroups_group = {

	params ["_namespace"];

	private _id = _namespace getVariable ["_id"];
	private _side = _namespace getVariable ["_side"];
	private _waypoints = _namespace getVariable ["_waypoints"];
	private _combat_mode = _namespace getVariable ["_combat_mode"];
	private _speed_mode = _namespace getVariable ["_speed_mode"];
	
	private _group = createGroup _side;

	// CREATE UNITS
	private _units = (_namespace getVariable ["_units"]);
	{
		private _unit = call MALO_fnc_loadGroups_unit;
		_unit joinSilent _group;
		
	} forEach _units;

};


// LOAD EACH GROUP

{

	_x call MALO_fnc_loadGroups_group;

} forEach _array;