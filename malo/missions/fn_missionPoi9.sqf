// MISSION SCRIPT

if (false) exitWith {};

private _mission_name = "poi9";
private _mission_required = "msta";

if (_mission_name in MALO_mission_progress) exitWith {};
if !(_mission_required in MALO_mission_progress) exitWith {};

////

[_mission_name, _mission_required] call MALO_fnc_missions_poi;