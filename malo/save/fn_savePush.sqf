// ADDS A KEYWORD TO THE MISSION PROGRESS ARRAY

if (!hasInterface) exitWith {};

params ["_name"];

if (_name in MALO_mission_progress) exitWith {};

MALO_mission_progress append [_name];