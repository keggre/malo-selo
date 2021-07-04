// VARS
current_view_distance = 1;
next_view_distance = 1;

// COMMANDS
setViewDistance current_view_distance;

// CALLS
call MALO_fnc_initCivs;
call MALO_fnc_initFlee;
call MALO_fnc_initSliders;
call MALO_fnc_initPois;
call MALO_fnc_initVillages;

// CONDITIONS
if (MALO_ambient_plane == true) then {
	ambient_plane_1 enableSimulation true;
	ambient_plane_1D enableSimulation true;
};

if (MALO_ambient_fire == true) then {
	fn_ambientFire = [] spawn MALO_fnc_ambientFire;
};

if (MALO_loading == true) then {
	call MALO_fnc_load;
};

while {true} do {

	// VARS
	CHBN_adjustBrightness = MALO_night_brightness / 100;

	// COMMANDS
	setTimeMultiplier MALO_time_multiplier; 

	// CALLS
	call MALO_fnc_reload;
	call MALO_fnc_playerSquadSimulation;
	call MALO_fnc_radio;
	call MALO_fnc_villages;
	call MALO_fnc_dynamicSimulation;
	call MALO_fnc_debug;
	
	// LOCALS
	[] remoteExec ["MALO_fnc_viewDistance", clientOwner];

	// CONDITIONS
	if (random [0, 50, 100] == 1) then {
		call MALO_fnc_flee;
	};

	if (MALO_saving == true) then {
		call MALO_fnc_save;
	};

	if (MALO_allow_war_crimes == true) then {
		call MALO_fnc_allowWarCrimes;
	};

	if (MALO_target_framerate == 0) then {
		MALO_simulation_distance = MALO_min_simulation_distance;
	} else {
		[] remoteExec ["MALO_fnc_autoConfig", clientOwner];
	};

	sleep .05;

};