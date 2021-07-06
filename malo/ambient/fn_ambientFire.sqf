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

while {true} do {

for "_i" from 0 to (count _turrets - 1) do {

_turret = _turrets select _i;
_target = _targets select _i;
_burst = random [1, 5, 10];

_string =  [str _i, str _turret, str _target] joinString " ";

_turret setVehicleAmmo 1;
_turret doWatch _target; 
_turret action ["useWeapon", _turret, gunner _turret, 1];

};

_time = random [0,1,10];
sleep _time / 10;

};