// FINDS BUILDINGS OF THE SELECTED TYPES WITHIN A RADIUS NEAR THE PLAYABLE UNITS AND SPAWNS A FIRE EFFECT IN THEM IF THEY REACH A DAMAGE THRESHOLD

if (!isServer) exitWith {};

private _delay_main = MALO_delay * 10; 					// DELAY FOR THE MAIN SCRIPT
private _delay = 1; 									// DELAY FOR THE SPAWNED SCRIPTS
private _radius = 3000;									// MAXIMUM RADIUS FROM ANY PLAYER IN WHICH FIRES WILL BE STARTED
private _thresh = .5;									// DAMAGE THRESHOLD TO START THE FIRE
private _step = (.1 / 60);								// HOW MUCH THE BUILDING DAMAGE IS AFFECTED EACH ITERATION OF THE LOCAL SCRIPT
private _spread = 100;									// MAXIMUM SPREAD DISTANCE IN METERS
private _limit = 10;									// MAXIMUM AMOUNT OF FIRES THAT CAN BE ACTIVE AT ANY GIVEN TIME
private _types = MALO_building_types;					// BUILDING TYPES TO CATCH FIRE

MALO_ambient_fire_count = 0;

private _center = createCenter sideLogic;
private _group = createGroup _center;
_group deleteGroupWhenEmpty false;

MALO_fnc_ambientFire_spawned = {

	params ["_object", "_delay", "_radius", "_step", "_spread", "_limit", "_types", "_group"];

	private _size = sizeOf (typeOf _object);
	
	private _position = [
		(((position _object) select 0) + ((boundingCenter _object) select 0)),
		(((position _object) select 1) + ((boundingCenter _object) select 1)),
		(((position _object) select 2) + ((boundingCenter _object) select 2) + ((2/3) * (((boundingBox _object) select 1) select 2)))
	];

	private _fire_init = [
		["ColorRed", .5],
		["ColorGreen", .5],
		["ColorBlue", .5],
		["Timeout", 0],
		["ParticleLifeTime", 3],
		["ParticleDensity", 20],
		["ParticleSize", 7.5],
		["ParticleSpeed", 1],
		["EffectSize", (_size * (2/3))],
		["ParticleOrientation", 5.4],
		["FireDamage", (_size * (1/4))],
		["BIS_fnc_initModules_disableAutoActivation", false]
	] call MALO_fnc_assembleModuleInit;

	private _smoke_init = [
		["ColorRed", .5],
		["ColorGreen", .5],
		["ColorBlue", .5],
		["ColorAlpha", .5],
		["Timeout", 0],
		["ParticleLifeTime", 50],
		["ParticleDensity", 10],
		["ParticleSize", 7.5],
		["ParticleSpeed", 1],
		["ParticleLifting", 1],
		["WindEffect", 1],
		["EffectSize", (_size * (2/30))],
		["Expansion", 2], // 1
		["BIS_fnc_initModules_disableAutoActivation", false]
	] call MALO_fnc_assembleModuleInit;

	MALO_ambient_fire_count = MALO_ambient_fire_count + 1;

	while {MALO_CFG_ambient_fire} do {

		private _damage = damage _object;

		// BREAK IF CONDITIONS MET
		if (
			!(
				alive _object
			) || (
				_object distance (
					_object call MALO_fnc_getNearestPlayer
				) > _radius
			) || (
				MALO_ambient_fire_count > _limit
			) || !(
				simulationEnabled _object
			)
		) exitWith {};

		// CREATE THE FIRE AND SMOKE
		private _effects_created = _object getVariable ["MALO_fire_effects_created", false];
		if (!_effects_created) then {
			{
				private _type = _x select 0;
				private _init = _x select 1;
				_type createUnit [
					_position,
					_group,
					_init
				];
			} forEach [
				["ModuleEffectsFire_F", _fire_init], 
				["ModuleEffectsSmoke_F", _smoke_init]
			];
			_object setVariable ["MALO_fire_effects_created", true, true];
			_object setVariable ["MALO_fire_effect", (nearestObject [_position, "ModuleEffectsFire_F"])];
			_object setVariable ["MALO_smoke_effect", (nearestObject [_position, "ModuleEffectsSmoke_F"])];
		};
	
		// DAMAGE THE BUILDING
		_object setDamage (_damage + _step);

		// DAMAGE NEARBY BUILDINGS
		{
			_x setDamage (
				(
					damage _x
				) + (
					_step * (
						(_spread - (_x distance _object)) / 
						_spread
					) * (
						(damage _object) / 
						1
					)
				)
			);
		} forEach (nearestObjects [_object, _types, _spread]);

		sleep _delay;
	
	};

	// REMOVE THE FIRE AND SMOKE
	private _fire = _object getVariable ["MALO_fire_effect", objNull];
	private _smoke = _object getVariable ["MALO_smoke_effect", objNull];
	{
		{
			{deleteVehicle _x;} foreach _x;	
		}forEach [
			_x getVariable ["effectEmitter", []],
			_x getVariable ["effectLight", []],
			[_x]
		];
	} forEach [_fire, _smoke];
	_object setVariable ["MALO_fire_effects_created", false, true];

	MALO_ambient_fire_count = MALO_ambient_fire_count - 1;
	_object setVariable ["MALO_ambient_fire_active", false, true];

};

while {MALO_CFG_ambient_fire} do {

	{
		private _unit = _x;
		{
			private _object = _x;
			private _damage = damage _object;
			if (
				!(_object getVariable ["MALO_ambient_fire_active", false]) &&
				!(_object getVariable ["MALO_ambient_fire_disabled", false]) &&
				(_damage >= _thresh) &&
				(alive _object) &&
				(simulationEnabled _object)
			) then {
				_object setVariable ["MALO_ambient_fire_active", true, true];
				[_object, _delay, _radius, _step, _spread, _limit, _types, _group] spawn MALO_fnc_ambientFire_spawned;
			};
		} forEach (nearestObjects [_unit, _types, _radius]);
	} forEach playableUnits;

	sleep _delay_main;

};