// CONTROLS MISSION SCRIPTS

if (false) exitWith {};

MALO_fnc_missions_poi = {
	params ["_mission_name", "_mission_required"];
	sleep (random [30, 60, 120]);
	private _trg = missionNamespace getVariable ["trg_" + _mission_name, objNull];
	_trg spawn MALO_fnc_activateTrigger;
	waitUntil {_mission_name in MALO_mission_progress};
};

private _configs = "true" configClasses (missionconfigFile >> "CfgFunctions" >> "MALO" >> "missions");
private _scripts = [];
{
	_scripts append [(configname _x)];
} forEach _configs;

private _var = missionNamespace getVariable ["MALO_missions_loaded", false];

{

	if (_var == false) then {

		call compile ("

			fn_" + _x + " = [] spawn MALO_fnc_" + _x + ";

		");

		MALO_missions_loaded = true;

	} else {

		call compile ("

			if (scriptDone fn_" + _x + ") then {

				fn_" + _x + " = [] spawn MALO_fnc_" + _x + ";

			};

		");

	};

} forEach _scripts;