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
	private _details = magazinesDetail _vehicle;
	private _parsed = _details call MALO_fnc_parseMagazineDetail;

	private _deltas = [];
	{
		private _type = _x select 0;
		private _current = (_x select 1) select 0;
		private _capacity = (_x select 1) select 1;
		private _delta = _capacity - _current;
		if (_delta > 0) then {
			_deltas append [[_type, _delta]];
		};
	} forEach _parsed;

	if (count _deltas > 0) then {
		private _objects = nearestObjects [_vehicle, [], 10];
		{
			private _object = _x;
		} forEach _objects;
	};

} forEach _player;*/