// ADJUSTS THE SIMULATION DISTANCE BASED OFF FRAMERATE

if (!hasInterface) exitWith {MALO_simulation_distance = MALO_CFG_max_simulation_distance;};
if (MALO_CFG_target_framerate == 0) exitWith {MALO_simulation_distance = MALO_CFG_min_simulation_distance;};

if (diag_fps < MALO_CFG_target_framerate) then {
	
	MALO_simulation_distance = MALO_simulation_distance - (100 * MALO_tick);

	if (MALO_simulation_distance < MALO_CFG_min_simulation_distance) then {

		MALO_simulation_distance = MALO_CFG_min_simulation_distance;

	};



} else {

	MALO_simulation_distance = MALO_simulation_distance + (100 * MALO_tick);

	if (MALO_simulation_distance > MALO_CFG_max_simulation_distance) then {

		MALO_simulation_distance = MALO_CFG_max_simulation_distance;

	};

};