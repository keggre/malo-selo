// FINDS THE PLAYER CLOSEST TO THE OBJECT

if (false) exitWith {};

params ["_object"];

private _distance_1 = "None";
private _player = "None";

{

	private _distance_2 = _x distance _object;

	if (_distance_1 isEqualTo "None") then {
		_distance_1 = _distance_2;
	};

	if (_player isEqualTo "None") then {
		_player = _x;
	};

	if (_distance_1 > _distance_2) then {
		_distance_1 = _distance_2;
		_player = _x;
	};

} forEach playableUnits;

_player