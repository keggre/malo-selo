/*if (isServer) then {*/

	if (diag_fps < MALO_target_framerate) then {
		
		MALO_simulation_distance = MALO_simulation_distance - 10;

		if (MALO_simulation_distance < MALO_min_simulation_distance) then {

			MALO_simulation_distance = MALO_min_simulation_distance

		};

	} else {

		MALO_simulation_distance = MALO_simulation_distance + 10;

	};

	/*publicVariable "MALO_simulation_distance";

};*/

