// FINDS BUILDINGS OF THE SELECTED TYPES WITHIN A RADIUS NEAR THE PLAYABLE UNITS AND SPAWNS A FIRE EFFECT IN THEM IF THEY REACH A DAMAGE THRESHOLD

if (!isServer) exitWith {};

private _delay_main = MALO_delay * 10; 					// DELAY FOR THE MAIN SCRIPT
private _delay_spawned = 1; 							// DELAY FOR THE SPAWNED SCRIPTS
private _radius = 3000;									// MAXIMUM RADIUS FROM ANY PLAYER IN WHICH FIRES WILL BE STARTED
private _thresh = .5;									// DAMAGE THRESHOLD TO START THE FIRE
private _step = (.1 / 60);								// HOW MUCH THE BUILDING DAMAGE IS AFFECTED EACH ITERATION OF THE LOCAL SCRIPT
private _spread = 50;									// MAXIMUM SPREAD DISTANCE IN METERS
private _limit = 20;									// MAXIMUM AMOUNT OF FIRES THAT CAN BE ACTIVE AT ANY GIVEN TIME
private _types = MALO_building_types;					// BUILDING TYPES TO CATCH FIRE

MALO_fire_count = 0;									// DON'T CHANGE

MALO_fnc_ambientFire_spawned = {

	params ["_object", "_delay", "_radius", "_step", "_spread", "_limit", "_types"];

	private _size = sizeOf (typeOf _object);
	private _position = position _object;
	private _group = createGroup sideLogic;

	private _fire_init = [
		[
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
		], 
		[
			.5,
			.5,
			.5,
			0,
			3,
			20,
			7.5,
			1,
			(_size * (2/3)),
			5.4,
			(_size * (1/4)),
			false
		]
	] call MALO_fnc_assembleModuleInit;

	private _smoke_init = [
		[
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
		], 
		[
			.5,
			.5,
			.5,
			0,
			3,
			20,
			7.5,
			1,
			(_size * (2/3)),
			5.4,
			(_size * (1/4)),
			false
		]
	] call MALO_fnc_assembleModuleInit;

	MALO_fire_count = MALO_fire_count + 1;

	while {true} do {

		sleep _delay;

		private _damage = damage _object;

		// BREAK IF CONDITIONS MET
		if (
			(
				!alive _object
			) || (
				_object distance (
					_object call MALO_fnc_getNearestPlayer
				) > _radius
			) || (
				MALO_fire_count > _limit;
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
		};
		private _fire = nearestObject [_position, "ModuleEffectsFire_F"];
		private _smoke = nearestObject [_position, "ModuleEffectsSmoke_F"];
	
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

	MALO_fire_count = MALO_fire_count - 1;

};

