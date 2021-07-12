if (!isServer) exitWith {};

private _delay_1 = 1; 									// DELAY FOR THE SERVER SCRIPT
private _delay_2 = 60; 									// DELAY FOR THE LOCAL SCRIPTS
private _radius = MALO_CFG_min_simulation_distance;		// MAXIMUM RADIUS FROM ANY PLAYER IN WHICH FIRES WILL BE STARTED
private _thresh = .5;									// DAMAGE THRESHOLD TO START THE FIRE
private _step = .1;										// HOW MUCH THE BUILDING DAMAGE IS AFFECTED EACH ITERATION OF THE LOCAL SCRIPT
private _spread = 50;									// MAXIMUM SPREAD DISTANCE IN METERS
private _limit = 10;									// MAXIMUM AMOUNT OF FIRES THAT CAN BE ACTIVE AT ANY GIVEN TIME
private _types = ["Land_A_BuildingWIP","Land_A_FuelStation_Build","Land_A_GeneralStore_01","Land_A_GeneralStore_01a","Land_A_Hospital","Land_A_Pub_01","Land_a_stationhouse","Land_Barn_Metal","Land_Barn_W_01","Land_Church_03","Land_Farm_Cowshed_a","Land_Farm_Cowshed_b","Land_Farm_Cowshed_c","Land_Hlidac_budka","Land_HouseBlock_A1","Land_HouseB_Tenement","Land_HouseV2_01A","Land_HouseV2_02_Interier","Land_HouseV2_04_interier","Land_HouseV_1I1","Land_HouseV_1I4","Land_HouseV_1L1","Land_HouseV_1L2","Land_HouseV_2L","Land_Ind_Garage01","Land_Ind_Workshop01_01","Land_Ind_Workshop01_02","Land_Ind_Workshop01_04","Land_Ind_Workshop01_L","Land_kulna","Land_Mil_Barracks_i","Land_Mil_ControlTower","Land_Panelak","Land_Panelak2","Land_Rail_House_01","Land_rail_station_big","Land_Shed_Ind02","Land_Shed_W01","Land_stodola_old_open","Land_Tovarna2","Land_vez","Land_CarService_F","Land_Chapel_Small_V1_F","Land_Chapel_Small_V2_F","Land_Chapel_V1_F","Land_Chapel_V2_F","Land_d_Stone_Shed_V1_F","Land_FuelStation_Build_F","Land_FuelStation_Shed_F","Land_Hospital_main_F","Land_Hospital_side1_F","Land_Hospital_side2_F","Land_i_Addon_02_V1_F","Land_i_Addon_03mid_V1_F","Land_i_Addon_03_V1_F","Land_i_Addon_04_V1_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Shed_Ind_F","Land_i_Shop_01_V1_F","Land_i_Shop_01_V2_F","Land_i_Shop_01_V3_F","Land_i_Shop_02_V1_F","Land_i_Shop_02_V2_F","Land_i_Shop_02_V3_F","Land_i_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V2_F","Land_i_Stone_HouseBig_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F","Land_Metal_Shed_F","Land_MilOffices_V1_F","Land_Offices_01_V1_F","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_Unfinished_Building_01_F","Land_Unfinished_Building_02_F","Land_u_Addon_01_V1_F","Land_u_Addon_02_V1_F","Land_u_Barracks_V2_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_u_House_Small_01_V1_F","Land_u_House_Small_02_V1_F","Land_u_Shed_Ind_F","Land_u_Shop_01_V1_F","Land_u_Shop_02_V1_F","Land_WIP_F"];

MALO_ambient_fire_buildings = [];						// LEAVE EMPTY

MALO_fnc_ambientFire_global = {

	params ["_object", "_step", "_types", "_spread", "_delay"];

	// FIRE VARIABLE NAMES
	private _vars = [
		"ColorRed",
		"ColorGreen",
		"ColorBlue",
		"Timeout",
		"ParticleLifeTime",
		"ParticleDensity",
		"ParticleSize",
		"ParticleSpeed",
		"EffectSize",
		"ParticleOrientation",
		"FireDamage"
	];

	// FIRE VARIABLE VALUES
	private _vals = [
		.5,
		.5,
		.5,
		0,
		2,
		20,
		1,
		1,
		sizeOf (typeOf _object),
		5.4,
		1
	];

	// ASSEMBLE STRING TO SET MODULE PARAMS
	private _string = "";
	private _i = 0;
	for "_i" from 0 to count _vars - 1 do {
		private _var = _vars select _i;
		private _val = _vals select _i;
		_string = _string + ("this setVariable ['" + _var + "', " + str _val + ", false]; ");
	};

	// CREATE THE FIRE
	private _group = createGroup sideLogic;
	"ModuleEffectsFire_F" createUnit [
		position _object,
		_group,
		_string
	];
	private _fire = nearestObject [position _object, "ModuleEffectsFire_F"];

	while {_object in MALO_ambient_fire_buildings} do {

		// DAMAGE THE BUILDING OVER TIME AND EXIT IF IT'S DESTROYED
		_object setDamage ((damage _object) + _step);
		if (damage _object >= 1) exitWith {};

		// DAMAGE NEARBY BUILDINGS
		{
			_x setDamage (damage _x + (_step * ((_spread - (_x distance _object)) / _spread) * ((damage _object) / 1)));

		} forEach (nearestObjects [_object, _types, _spread]);
		
		sleep _delay;

	};

	// REMOVE THE FIRE
	deleteVehicle _fire;

}; publicVariable "MALO_fnc_ambientFire_global";

while {MALO_CFG_ambient_fire} do {

	MALO_ambient_fire_building_distances = [];
	

	// MAKE AN ARRAY THAT STORES ALL THE DISTANCES FROM THE BUILDINGS TO THE NEAREST PLAYER

	{

		private _y = _x;

		private _distance_1 = _radius + 1;
		
		{

			private _distance_2 = _x distance _y;

			if (_distance_1 > _distance_2) then {

				_distance_1 = _distance_2;

			};

		} forEach playableUnits;

		MALO_ambient_fire_building_distances append [_distance_1];

	} forEach MALO_ambient_fire_buildings;
	

	// FIND ANY BUILDINGS THAT ARE TOO FAR AWAY FROM THE NEAREST PLAYER AND REMOVE THEM FROM THE ARRAYS

	{

		if (_x > _radius) then {

			private _spot = MALO_ambient_fire_building_distances find _x;

			MALO_ambient_fire_buildings deleteAt _spot;
			MALO_ambient_fire_building_distances deleteAt _spot;

		};

	} forEach MALO_ambient_fire_building_distances;


	// FIND ANY BUILDINGS THAT ARE ALREADY DESTOYED AND REMOVE THEM FROM THE ARRAYS

	{

		if (damage _x >= 1) then {

			private _spot = MALO_ambient_fire_buildings find _x;

			MALO_ambient_fire_buildings deleteAt _spot;
			MALO_ambient_fire_building_distances deleteAt _spot;

		};

	} forEach MALO_ambient_fire_buildings;


	// ADD A BUILDING TO THE ARRAY ACCORDING TO VARIOUS CONDITIONS

	{
		
		private _y = _x;

		{

			// THE DAMAGE MUST BE ABOVE THE THRESHOLD AND CANNOT BE GREATER THAN OR EQUAL TO 1
			if (damage _x < _thresh || damage _x >= 1) exitWith {};

			// THE BUILDING IS NOT FOUND IN THE ARRAY
			if !(_x in MALO_ambient_fire_buildings) then {

				private _condition = true;

				// THE FIRE LIMIT HAS BEEN REACHED
				if (count MALO_ambient_fire_buildings >= _limit) then {

					private _distance_1 = _x distance _y;
					private _distance_2 = selectMin MALO_ambient_fire_building_distances;
					private _spot = MALO_ambient_fire_building_distances find _distance_2;
					
					// THE BUILDING BEING ADDED IS CLOSER TO THE NEAREST PLAYER THAN THE BUILDING ON THE ARRAY THAT IS FURTHEST FROM THE NEAREST PLAYER
					if (_distance_1 < _distance_2) then {

						MALO_ambient_fire_buildings deleteAt _spot;
						MALO_ambient_fire_building_distances deleteAt _spot;

					} else {

						_condition = false;

					};
					
				};

				// IF EVERYTHING SEEMS RIGHT THE BUILDING WILL BE ADDED AND A SCRIPT SPAWNED
				if (_condition) then {
					MALO_ambient_fire_buildings append [_x];
					MALO_ambient_fire_building_distances append [0];
					[_x, _step, _types, _spread, _delay_2] remoteExec ["MALO_fnc_ambientFire_global", 0]; 
				};
				
			};

		} forEach (nearestObjects [_y, _types, _radius]);

	} forEach playableUnits;
	
	// BROADCASTED TO CLIENTS
	publicVariable "MALO_ambient_fire_buildings";

	sleep _delay_1;

};

// RUNS WHEN THE SETTING IS DISABLED IN THE CONFIG
MALO_ambient_fire_buildings = [];