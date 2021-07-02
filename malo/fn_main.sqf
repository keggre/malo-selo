// VARS
CHBN_adjustBrightness = MALO_night_brightness / 100;
current_view_distance = 1;
next_view_distance = 1;

publicVariable "current_view_distance";
publicVariable "next_view_distance";

// COMMANDS
setTimeMultiplier MALO_time_multiplier; 
setViewDistance current_view_distance;

// CALLS
call MALO_fnc_civs;
call MALO_fnc_initFlee;
call MALO_fnc_sliders;

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
	call MALO_fnc_playerSquadSimulation;
	call MALO_fnc_viewDistance;
	call MALO_fnc_radio;
	
	// CONDITIONS
	if (random [0, 50, 100] == 1) then {
		call MALO_fnc_flee;
	};

	sleep .05;

};