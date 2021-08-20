// LOADS MISSION VARIABLES FROM PROFILE NAMESPACE

if (false) exitWith {};

waitUntil {!MALO_init};

private _array = profileNamespace getVariable ["MALO_saved_variables", []];

{
	private _name = _x select 0;
	private _value = _x select 1;
	missionNamespace setVariable [_name, _value, true];
} forEach _array;