// MORE ADVANCED APPEND FUNCTION MEANT TO BE CALLED IN EDITOR INIT FIELDS

if (false) exitWith {};

params ["_varname", "_append"];

private _append = (if (typeName _append == "ARRAY") then {
	_append
} else {
	[_append]
});

missionNamespace setVariable [_varname, ((missionNamespace getVariable [_varname, []]) + _append)];