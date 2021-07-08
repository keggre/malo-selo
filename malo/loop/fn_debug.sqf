if (!hasInterface) exitWith {};

// hint (str diag_fps + " " + str MALO_current_view_distance + " " + str MALO_simulation_distance + " " + str MALO_delay);

if (alive cap_1) then {

	_i = 1;

	for "_i" from 1 to 9 do {

		call compile (

			"{_x setDamage 1;} forEach units group cap_" + str _i + ";"

		);

	};

};

malo_delay = 1;