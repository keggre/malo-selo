// ASSEMBLES INIT FIELD FOR MODULES

if (false) exitWith {};

private _array = _this;

private _string = "";
{
	private _var = _x select 0;
	private _val = _x select 1;
	_string = _string + ("this setVariable ['" + _var + "', " + str _val + ", true]; ");
} forEach _array;

_string