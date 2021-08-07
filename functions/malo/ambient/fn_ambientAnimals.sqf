// CREATES ANIMAL SPAWN POINTS FROM MARKERS PLACED ON THE MAP IN THE EDITOR

if (!isServer) exitWith {};
if (MALO_CFG_ambient_animals == false) exitWith {};

MALO_animal_spawn_types = [

  /*[marker text, types, spawn radius, animal radius, count]*/
	["sheep 1", ["Sheep_random_F"], MALO_CFG_min_simulation_distance, 10, 10],
	["goats 1", ["Goat_random_F"], MALO_CFG_min_simulation_distance, 5, 5],
	["chickens 1", ["Hen_random_F", "Cock_random_F"], MALO_CFG_min_simulation_distance, 2.5, 10],
	["dogs 1", ["Fin_random_F"], MALO_CFG_min_simulation_distance, 100, 10]
	
];

MALO_animal_spawns= [];

{

	_y = _x;

	{

		if (markerText _y == _x select 0) then {
	
			private _obj = createVehicle ["Sign_Sphere10cm_F", getMarkerPos _y, [], 0, "CAN_COLLIDE"];

			_obj setVariable ["animalCount", _x select 4];
			_obj setVariable ["radius", _x select 3];

			[_obj, _x select 1, _x select 2] spawn BIS_fnc_animalSiteSpawn;

			MALO_animal_spawns append [_obj];
			hideObjectGlobal _obj;

		};

	} forEach MALO_animal_spawn_types;

} forEach allMapMarkers;

waitUntil {!MALO_CFG_ambient_animals};

{deleteVehicle _x;} forEach MALO_animal_spawns;

private _animal_types = [];

{_animal_types append (_x select 1);} forEach MALO_animal_spawn_types;

{
	if (typeOf _x in _animal_types) then {deleteVehicle _x;};
} forEach allMissionObjects "ALL";
