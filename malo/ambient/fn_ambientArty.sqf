if (!isServer) exitWith {};

_guns = [

	// a_mortar_1
	
];

_targets = [

	// getMarkerPos "a_tgt_1"
	
];

while {MALO_CFG_ambient_arty} do {

	for "_i" from 0 to (count _guns - 1) do {

		_time = random [0,10,30];
		sleep _time; 

		_gun = _guns select _i;
		_target = _targets select _i;
		_ammo = getArtilleryAmmo [_gun] select 0; 

		_gun setVehicleAmmo 1;
		
		if (!isPlayer gunner _gun) then {
			_gun doArtilleryFire[_target,_ammo,5];
		};

	};

};