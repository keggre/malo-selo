// MISSION SCRIPT

if (false) exitWith {};

private _mission_name = "poi7";
private _mission_required = "novy";

if (_mission_name in MALO_mission_progress) exitWith {};
if !(_mission_required in MALO_mission_progress) exitWith {};

////

[_missions_name, _mission_required] call MALO_fnc_missions_poi;