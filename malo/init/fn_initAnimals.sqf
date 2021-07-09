if (!isServer) exitWith {};

MALO_animal_spawn_types = [

  /*[marker text, types, spawn radius, animal radius, count]*/
	["sheep 1", ["Sheep_random_F"], MALO_CFG_view_distance, 10, 10],
	["goats 1", ["Goat_random_F"], MALO_CFG_view_distance, 5, 10],
	["chickens 1", ["Hen_random_F", "Cock_random_F"], MALO_CFG_view_distance, 2.5, 10]
	
];

{

	_y = _x;

	{

		if (markerText _y == _x select 0) then {
	
			_obj = createVehicle ["Sign_Sphere10cm_F", getMarkerPos _y, [], 0, "CAN_COLLIDE"];

			_obj setVariable ["animalCount", _x select 4];
			_obj setVariable ["radius", _x select 3];

			[_obj, _x select 1, _x select 2] spawn BIS_fnc_animalSiteSpawn;

			hideObject _obj;

		};

	} forEach MALO_animal_spawn_types;

} forEach allMapMarkers;