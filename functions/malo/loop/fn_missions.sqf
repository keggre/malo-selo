// CONTROLS MISSION SCRIPTS

if (false) exitWith {};

MALO_fnc_missions_poi = {
	params ["_mission_name", "_mission_required"];
	sleep (random [30, 60, 120]);
	private _trg = missionNamespace getVariable ["trg_" + _mission_name, objNull];
	_trg spawn MALO_fnc_activateTrigger;
	waitUntil {_mission_name in MALO_mission_progress};
};

["MALO", "missions"] call MALO_fnc_spawnFunction;