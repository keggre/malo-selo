// KILLS ALL UNITS OF A GIVEN SIDE WITHIN A GIVEN RADIUS

if (false) exitWith {};

params ["_side", "_position", "_radius"];

private _objects = nearestObjects [_position, ["Man", "car", "tank", "turret"], _radius];
private _units = [];

{

	if (side _x == _side) then {
		
		_units append [_x];

	};

} forEach _objects;

_units