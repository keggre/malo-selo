// RUNS WHEN A VILLAGE LOADS

if (false) exitWith {};
if (missionNamespace setVariable [(_name + "_discovered"), false]) exitWith {};

params ["_name"];

// LOAD VILLAGE UNITS
(_name + "_enemies") call MALO_fnc_loadGroups;
(_name + "_civs") call MALO_fnc_loadGroups;

// SET VILLAGE VARIABLES
missionNamespace setVariable [(_name + "_discovered"), true, true];
missionNamespace setVariable [("MALO_tip_" + _name), true, true];