// VEHICLE AMMO

if (!isServer) exitWith {};

scopeName "main";

MALO_fnc_rearm_spawned = {

	private _giving = (_this select 0) select 0;
	private _recieving = (_this select 0) select 1;
	private _type = (_this select 1) select 0;
	private _count = (_this select 1) select 1;
	
	private 

};

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
	private _rearming = _x getVariable ["MALO_rearming"]

	if (!_rearming) then {

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
			private _delta = _deltas select 0;
			private _delta_type = _delta select 0;
			private _delta_count = _delta select 1;
			private _objects = nearestObjects [_vehicle, [], 10];
			{
				private _object = _x;
				private _providing_ammo = _object getVariable ["MALO_providing_ammo", false];
				if (!_providing_ammo) then {
					private _vehicle_ammo = _object getVariable ["MALO_vehicle_ammo", []];
					{

						private _type = _x select 0;
						private _current = (_x select 1) select 0;
						private _capacity = (_x select 1) select 1;

						private _count = if (_current > _delta_count) then {
							_current
						} else {
							_delta_count
						};

						if (_count > 0) then {
							private 
							[[_object, _vehicle], [_type, _count]] spawn MALO_fnc_rearm_spawned;
							breakTo "main";
						};

					} forEach _vehicle_ammo;
				};
			} forEach _objects;
		};

	};

} forEach _player;*/