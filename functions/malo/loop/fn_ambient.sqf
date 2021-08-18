// CONTROLS SCRIPTS RELATED TO VARIOUS AMBIENT FEATURES

if (!isServer) exitWith {};

private _configs = "true" configClasses (missionconfigFile >> "CfgFunctions" >> "MALO" >> "ambient");
private _scripts = [];
{
	_scripts append [(configname _x)];
} forEach _configs;

private _var = missionNamespace getVariable ["MALO_ambients_loaded", false];

{
	if (_var == false) then {
		call compile ("
			fn_" + _x + " = [] spawn MALO_fnc_" + _x + ";
		");
		MALO_ambients_loaded = true;
	} else {
		call compile ("
			if (scriptDone fn_" + _x + ") then {
				fn_" + _x + " = [] spawn MALO_fnc_" + _x + ";
			};
		");
	};
} forEach _scripts;