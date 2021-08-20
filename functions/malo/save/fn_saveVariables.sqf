// SAVES MISSION VARIABLES IN AN ARRAY

if (false) exitWith {};


// ARRAY OF PERSISTENT VARIABLE NAMES

MALO_persistent_variables = [];

{
	private _village = _x;
	MALO_persistent_variables append [(_village + "_discovered")];
} forEach villages;


// GET THE VARIABLES AND SAVE THEM TO THE PROFILE NAMESPACE

private _array = [];

{
	private _name = _x;
	if (!isNil _name) then {
		private _value = missionNamespace getVariable _name;
		_array append [[_name, _value]];
	};
} forEach MALO_persistent_variables;

profileNamespace setVariable ["MALO_saved_variables", _array];