[] spawn MALO_fnc_cutsceneOpening;

hintSilent "Initializing mission...";

fn_config = execVM "config.sqf";
waitUntil {scriptDone fn_config};

// VARS
MALO_init = true;
MALO_delay = .05;
MALO_min_delay = .05;
MALO_max_delay = .5;
MALO_current_view_distance = 1000;
MALO_next_view_distance = 1000;
MALO_fog_value = .5;
MALO_ovc_value = .75;

setViewDistance MALO_current_view_distance;
0 setFog MALO_fog_value;
0 setOvercast MALO_ovc_value;

east setFriend [independent, 1];
independent setFriend [east, 1];

east setFriend [civilian, 1];
civilian setFriend [east, 1];

west setFriend [independent, 1];
independent setFriend [west, 1];

// INIT
call MALO_fnc_initAnimals;
call MALO_fnc_initBuildings;
call MALO_fnc_initCivs;
call MALO_fnc_initFlee;
call MALO_fnc_initPois;
call MALO_fnc_initRadio;
call MALO_fnc_initSimulation;
call MALO_fnc_initSliders;
call MALO_fnc_initTasks;
call MALO_fnc_initVillages;

// LOAD
call MALO_fnc_load;

sleep .05;

if !("shootout" in MALO_mission_progress) then {
	trg_shootout_1 call MALO_fnc_activateTrigger;
	trg_shootout_2 call MALO_fnc_activateTrigger;
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
	call MALO_fnc_debug;
	call MALO_fnc_delay;
	call MALO_fnc_deleteTasks;
	call MALO_fnc_dynamicSimulation;
	call MALO_fnc_flee;
	call MALO_fnc_playerSquadSimulation;
	call MALO_fnc_reload;
	call MALO_fnc_simulationDistance;
	call Malo_fnc_supplyTruck;
	call MALO_fnc_viewDistance;
	call MALO_fnc_villages;
	call MALO_fnc_weather;

	// DELAY
	sleep MALO_delay;

};
