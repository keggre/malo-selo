// KILLS ALL UNITS OF A GIVEN SIDE WITHIN A GIVEN RADIUS

if (!isServer) exitWith {};

params ["_side", "_position", "_radius"];

private _objects = nearestObjects [_position, ["Man", "car", "tank", "turret"], _radius];

_objects spawn MALO_fnc_deleteObjects;

{

	if (side _x == _side) then {
		
		_x setDamage 1;

	};

} forEach _objects;