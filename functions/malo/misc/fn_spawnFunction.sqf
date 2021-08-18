// SPAWNS A FUNCTION OF A GIVEN PREFIX AND CATEGORY

if (false) exitWith {};

params ["_prefix", "_category"];

private _configs = "true" configClasses (missionconfigFile >> "CfgFunctions" >> _prefix >> _category);
private _scripts = []; {_scripts append [(configname _x)];} forEach _configs;
private _condition = (missionNamespace getVariable [(_prefix + "_" + _category + "_functions_loaded"), false]);
private _index = (missionNamespace getVariable [(_prefix + "_" + _category + "_function_index"), 0]);

if (_condition) then {
	private _script = _scripts select _index;
	call compile ("
		if (scriptDone fn_" + _script + ") then {
			fn_" + _script + " = [] spawn " + _prefix + "_fnc_" + _script + ";
		};
	");
	_index = _index + 1;
	if (_index >= count _scripts) then {
		_index = 0;
	};
	missionNamespace setVariable [(_prefix + "_" + _category + "_function_index"), _index, true];
} else {
	{
		private _script = _x;
		call compile ("
			fn_" + _script + " = [] spawn " + _prefix + "_fnc_" + _script + ";
		");
	} forEach _scripts;
	missionNamespace setVariable [(_prefix + "_" + _category + "_functions_loaded"), true, true];
};