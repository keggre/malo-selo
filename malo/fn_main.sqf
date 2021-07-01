

// VARS
CHBN_adjustBrightness = MALO_night_brightness;

// COMMANDS
setTimeMultiplier MALO_time_multiplier; 
setViewDistance MALO_view_distance;

// CALLS
call MALO_fnc_civs;
call MALO_fnc_radio;
call MALO_fnc_initFlee;

// CONDITIONS
if (MALO_ambient_plane == true) then {
	ambient_plane_1 enableSimulation true;
	ambient_plane_1D enableSimulation true;
};

if (MALO_ambient_fire == true) then {
	fn_suppressingFire = [] spawn MALO_fnc_suppressingFire;
};

while {true} do {

	// CALLS
	call MALO_fnc_reload;
	call MALO_fnc_allowWarCrimes;
	
	// CONDITIONS
	if (random [0, 50, 100] == 1) then {
		call MALO_fnc_flee;
	};

	sleep .05;

};