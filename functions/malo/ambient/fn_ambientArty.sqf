// SHOOTS ARTILLERY AT SELECTED TARGETS FROM SELECTED GUNS

if (!isServer) exitWith {};

_guns = [

	// a_mortar_1
	
];

_targets = [

	// getMarkerPos "a_tgt_1"
	
];

while {MALO_CFG_ambient_arty} do {

	for "_i" from 0 to (count _guns - 1) do {

		// SELECT RANDOM DELAY
		_time = random [0,10,30];
		sleep _time; 

		// SELECT GUN, TARGET AND AMMO
		_gun = _guns select _i;
		_target = _targets select _i;
		_ammo = getArtilleryAmmo [_gun] select 0; 

		_gun setVehicleAmmo 1;

		// CHECK IF GUNNER IS PLAYER BEFORE SHOOTING		
		if (!isPlayer gunner _gun) then {
			_gun doArtilleryFire[_target,_ammo,5];
		};

	};

};