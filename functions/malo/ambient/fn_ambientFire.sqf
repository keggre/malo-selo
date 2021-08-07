// FINDS BUILDINGS OF THE SELECTED TYPES WITHIN A RADIUS NEAR THE PLAYABLE UNITS AND SPAWNS A FIRE EFFECT IN THEM IF THEY REACH A DAMAGE THRESHOLD

if (!isServer) exitWith {};

private _delay_1 = MALO_delay * 2; 						// DELAY FOR THE SERVER SCRIPT
private _delay_2 = 1; 									// DELAY FOR THE LOCAL SCRIPTS
private _radius = 3000;									// MAXIMUM RADIUS FROM ANY PLAYER IN WHICH FIRES WILL BE STARTED
private _thresh = .5;									// DAMAGE THRESHOLD TO START THE FIRE
private _step = (.1 / 60);								// HOW MUCH THE BUILDING DAMAGE IS AFFECTED EACH ITERATION OF THE LOCAL SCRIPT
private _spread = 50;									// MAXIMUM SPREAD DISTANCE IN METERS
private _limit = 10;									// MAXIMUM AMOUNT OF FIRES THAT CAN BE ACTIVE AT ANY GIVEN TIME
private _types = MALO_building_types;					// BUILDING TYPES TO CATCH FIRE

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
		"FireDamage",
		"BIS_fnc_initModules_disableAutoActivation"
	];

	// FIRE VARIABLE VALUES
	private _vals = [
		.5,
		.5,
		.5,
		0,
		3,
		20,
		7.5,
		1,
		((sizeOf (typeOf _object)) * (2/3)),
		5.4,
		((sizeOf (typeOf _object)) * (1/4)),
		false
	];

	// ASSEMBLE STRING TO SET MODULE PARAMS
	private _string = "";
	private _i = 0;
	for "_i" from 0 to count _vars - 1 do {
		private _var = _vars select _i;
		private _val = _vals select _i;
		_string = _string + ("this setVariable ['" + _var + "', " + str _val + ", true]; ");
	};

	// CREATE THE FIRE AND SMOKE
	private _group = createGroup sideLogic;
	{
		if (_x == "ModuleEffectsSmoke_F") then {
			_vals set [4, 50];
			_vals set [7, 1];
		};
		
		_x createUnit [
			position _object,
			_group,
			_string
		];
	} forEach ["ModuleEffectsFire_F", "ModuleEffectsSmoke_F"];
	private _fire = nearestObject [position _object, "ModuleEffectsFire_F"];
	private _smoke = nearestObject [position _object, "ModuleEffectsSmoke_F"];

	while {(_object in MALO_ambient_fire_buildings) && (alive _object)} do {

		// DAMAGE THE BUILDING OVER TIME AND EXIT IF IT'S DESTROYED
		_object setDamage ((damage _object) + _step);
		if (damage _object >= 1) exitWith {};

		// DAMAGE NEARBY BUILDINGS
		{
			_x setDamage (damage _x + (_step * ((_spread - (_x distance _object)) / _spread) * ((damage _object) / 1)));

		} forEach (nearestObjects [_object, _types, _spread]);
		
		sleep _delay;

	};

	// REMOVE THE FIRE AND SMOKE
	{
		{
			{deleteVehicle _x;} foreach _x;	
		}forEach [
			_x getVariable ["effectEmitter", []],
			_x getVariable ["effectLight", []],
			[_x]
		];
	} forEach [_fire, _smoke];

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