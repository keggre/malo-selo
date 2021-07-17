[] spawn MALO_fnc_cutsceneOpening;

hintSilent "Initializing mission...";

fn_config = execVM "config.sqf";
waitUntil {scriptDone fn_config};

// VARS
MALO_init = true;
MALO_delay = .05;
MALO_min_delay = .05;
MALO_max_delay = 5;
MALO_current_view_distance = 1000;
MALO_next_view_distance = 1000;
MALO_fog_value = .5;
MALO_ovc_value = .75;
MALO_serb_uniforms = ["SP_Camo_Oak_Insg", "VJ_OKLF_Camo"];
MALO_serb_vehicles = ["SRB_uaz_2", "O_Serbia_GAZ_66_01", "CUP_O_AN2_TK", "O_Serbia_Mi8AMT_01"];

setViewDistance MALO_current_view_distance;
0 setFog MALO_fog_value;
0 setOvercast MALO_ovc_value;

east setFriend [independent, 1];
independent setFriend [east, 1];

east setFriend [civilian, 1];
civilian setFriend [east, 1];

west setFriend [independent, 1];
independent setFriend [west, 1];

west setFriend [civilian, 1];
civilian setFriend [west, 1];

independent setFriend [civilian, 1];
civilian setFriend [independent, 1];

// INIT
call MALO_fnc_initBuildings;
call MALO_fnc_initCivs;
call MALO_fnc_initPois;
call MALO_fnc_initRadio;
call MALO_fnc_initSimulation;
call MALO_fnc_initOptions;
call MALO_fnc_initTasks;
call MALO_fnc_initVillages;

// LOAD
call MALO_fnc_load;

sleep .05;

if !("shootout" in MALO_mission_progress) then {
	[] spawn MALO_fnc_mission_shootout;
};

while {true} do {

	// VARS
	MALO_init = false;
	CHBN_adjustBrightness = (MALO_CFG_night_brightness / 100);

	setTimeMultiplier MALO_CFG_time_multiplier; 

	// SAVE
	[] spawn MALO_fnc_save;

	// LOOP
	call MALO_fnc_allowWarCrimes;
	call MALO_fnc_ambient;
	call MALO_fnc_civs;
	call MALO_fnc_combat;
	call MALO_fnc_debug;
	call MALO_fnc_delay;
	call MALO_fnc_deleteTasks;
	call MALO_fnc_dynamicSimulation;
	call MALO_fnc_player;
	call MALO_fnc_reload;
	call MALO_fnc_simulationDistance;
	call MALO_fnc_stealth;
	call MALO_fnc_supplyTruck;
	call MALO_fnc_tips;
	call MALO_fnc_viewDistance;
	call MALO_fnc_villages;
	call MALO_fnc_weather;

	// DELAY
	sleep MALO_delay;

};
