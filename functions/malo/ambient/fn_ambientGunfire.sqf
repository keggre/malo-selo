// SHOOTS BURSTS AT SELECTED TARGETS FROM SELECTED GUNS

if (!isServer) exitWith {};

_turrets = [

	t_turret_1,
	t_turret_2,
	t_turret_3,
	t_turret_4
	
];

_targets = [

	getMarkerPos "t_tgt_1",
	getMarkerPos "t_tgt_2",
	getMarkerPos "t_tgt_3",
	getMarkerPos "t_tgt_4"

];

while {MALO_CFG_ambient_gunfire} do {

	for "_i" from 0 to (count _turrets - 1) do {

		// SELECT TURRET, TARGET AND FIRING MODE
		_turret = _turrets select _i;
		_target = _targets select _i;
		_burst = random [1, 5, 10];

		_turret setVehicleAmmo 1;

		// CHECK IF PLAYER BEFORE SHOOTING
		if (!isPlayer gunner _turret) then {
			_turret doWatch _target; 
			_turret action ["useWeapon", _turret, gunner _turret, 1];
		};

	};

	_time = random [0,1,10];
	sleep _time / 10;

};