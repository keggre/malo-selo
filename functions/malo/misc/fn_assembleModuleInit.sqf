// ASSEMBLES INIT FIELD FOR MODULES

if (false) exitWith {};

params ["_vars", "_vals"];

private _string = "";
private _i = 0;
for "_i" from 0 to count _vars - 1 do {
	private _var = _vars select _i;
	private _val = _vals select _i;
	_string = _string + ("this setVariable ['" + _var + "', " + str _val + ", true]; ");
};

_string