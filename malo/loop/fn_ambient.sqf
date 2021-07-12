// CONTROLS SCRIPTS RELATED TO VARIOUS AMBIENT FEATURES

if (!isServer) exitWith {};

private _scripts = [

	"Animals",
	"Arty",
	"Fire",
	"Gunfire",
	"Plane"

];

private _var = missionNamespace getVariable ["MALO_ambients_loaded", false];

{

	if (_var == false) then {

		call compile ("

			fn_ambient" + _x + " = [] spawn MALO_fnc_ambient" + _x + ";

		");

		MALO_ambients_loaded = true;

	} else {

		call compile ("

			if (scriptDone fn_ambient" + _x + ") then {

				fn_ambient" + _x + " = [] spawn MALO_fnc_ambient" + _x + ";

			};

		");

	};

} forEach _scripts;