if (false) exitWith {};

params ["_side", "_position", "_radius"];

private _objects = nearestObjects [_position, ["Man", "car", "tank"], _radius];

{

	if (side _x == _side) then {
		
		_x setDamage 1;

	};

} forEach _objects;