fn_config = execVM "config.sqf";
waitUntil {scriptDone fn_config};

// VARS
MALO_init = true;
MALO_current_view_distance = 1;
MALO_next_view_distance = 1;
MALO_fog_value = .05;
MALO_ovc_value = .55;

setViewDistance MALO_current_view_distance;

// INIT
call MALO_fnc_initCivs;
call MALO_fnc_initFlee;
call MALO_fnc_initPois;
call MALO_fnc_initRadio;
call MALO_fnc_initSliders;
call MALO_fnc_initVillages;

// AMBIENT
fn_ambientArty = [] spawn MALO_fnc_ambientArty;
fn_ambientFire = [] spawn MALO_fnc_ambientFire;
fn_ambientPlane = [] spawn MALO_fnc_ambientPlane;

// LOAD
call MALO_fnc_load;

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
	call MALO_fnc_debug;
	call MALO_fnc_dynamicSimulation;
	call MALO_fnc_flee;
	call MALO_fnc_playerSquadSimulation;
	call MALO_fnc_reload;
	call MALO_fnc_simulationDistance;
	call Malo_fnc_supplyTruck;
	call MALO_fnc_viewDistance;
	call MALO_fnc_villages;
	call MALO_fnc_weather;

	sleep .05;

};
