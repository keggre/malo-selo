// VEHICLE AMMO

if (!isServer) exitWith {};

/* ["MALO_infinite_ammo", this] call MALO_fnc_append; */

private _infinite_ammo = missionNamespace getVariable ["MALO_infinite_ammo", []];
private _player = call {
	private _players = units player_squad;
	private _vehicles = [];
	{
		private _player = _x;
		private _vehicle = vehicle _player;
		if (_player != _vehicle) then {
			_vehicles append [_vehicle];
		};
	} forEach _players;
	_vehicles
};

{
	private _vehicle = _x;
	if (!isNil {driver _vehicle}) then {
		if (!isPlayer (driver _vehicle)) then {
			_vehicle setVehicleAmmo 1;
		};
	};
} forEach _infinite_ammo;

/*{
	private _vehicle = _x;
	private _detail = magazinesDetail _vehicle;
	private _objects = nearestObjects [_vehicle, [], 10];
	{
		private _object = _x;
		private _
	} forEach _objects;
} forEach _player;*/