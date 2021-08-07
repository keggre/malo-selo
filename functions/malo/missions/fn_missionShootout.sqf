// MISSION SCRIPT

if (false) exitWith {};

private _mission_name = "shootout";

if (_mission_name in MALO_mission_progress) exitWith {};

////

trg_shootout_1 call MALO_fnc_activateTrigger;

sleep 60;

trg_shootout_2 call MALO_fnc_activateTrigger;

waitUntil {_mission_name in MALO_mission_progress};