// DAMAGES BUILDINGS WITHIN A RADIUS TO A RANDOM DEGREE

if (!isServer) exitWith {};

params ["_position", "_radius", "_types", "_min", "_mid", "_max"];

private _objects = nearestObjects [_position, _types, _radius];

{
	
	if (damage _x < .1) then {

		_x setDamage (random [_min, _mid, _max]);
	
	};

} forEach _objects;