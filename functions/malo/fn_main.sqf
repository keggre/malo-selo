[] spawn MALO_fnc_cutsceneOpening;

hintSilent "Initializing mission...";

call compile preprocessFile "config.cfg";

// VARS
MALO_init = true;
MALO_delay = .05;
MALO_min_delay = .05;
MALO_max_delay = 1;
MALO_current_view_distance = 1000;
MALO_next_view_distance = 1000;
MALO_fog_value = .5;
MALO_ovc_value = .75;
MALO_serb_uniforms = ["SP_Camo_Oak_Insg", "VJ_OKLF_Camo"];
MALO_serb_vehicles = ["SRB_uaz_2", "O_Serbia_GAZ_66_01", "CUP_O_AN2_TK", "O_Serbia_Mi8AMT_01", "LIB_T34_85", "KOS_YUG_t72_grom"];
MALO_civ_vehicles = ["CUP_C_Skoda_Red_CIV","CFP_C_AFG_Zamak_Fuel_01","CUP_C_Ural_Open_Civ_03","CUP_C_S1203_CIV_CR","CFP_C_AFG_Zamak_Transport_Covered_01","CFP_C_AFG_Skoda_105_L_01","CUP_C_Volha_CR_CIV","CFP_C_CHERNO_WIN_Ural_Civ_03","CFP_C_AFRCHRISTIAN_Ikarus_01","CFP_C_AFG_Lada_01","CUP_C_Tractor_CIV","CFP_C_AFRISLAMIC_Ural_Yellow_01","CUP_C_Ikarus_Chernarus","CFP_C_AFG_Datsun_Pickup_Covered_01","CUP_C_Tractor_Old_CIV","CFP_C_AFRISLAMIC_Skoda_Green_01","CFP_C_AFRISLAMIC_Ural_Blue_01","CUP_C_Lada_CIV","CFP_C_AFG_Datsun_Pickup_01","CFP_C_AFRISLAMIC_Skoda_Blue_01","CFP_C_AFRISLAMIC_Skoda_White_01","CUP_C_Volha_Limo_TKCIV","CUP_C_Datsun","CUP_C_Lada_GreenTK_CIV","CUP_C_Volha_Blue_TKCIV"];

[] spawn {waitUntil {!MALO_init}; MALO_init_time = time;};

// CUTSCENE WEATHER AND VIEW DISTANCE
setViewDistance MALO_current_view_distance;
0 setFog MALO_fog_value;
0 setOvercast MALO_ovc_value;

// SIDE RELATIONS
private _side = east; {_side setFriend [_x, 1]; _x setFriend [_side, 1];} forEach [independent, civilian];
private _side = west; {_side setFriend [_x, 1]; _x setFriend [_side, 1];} forEach [independent, civilian];
private _side = independent; {_side setFriend [_x, 1]; _x setFriend [_side, 1];} forEach [civilian];

// INIT
["MALO", "init"] call MALO_fnc_callFunctions;

// LOAD
call MALO_fnc_load;

sleep .05;

// INITIAL VIEW DISTANCE
MALO_current_view_distance = 100;
MALO_next_view_distance = 100;

while {true} do {

	MALO_tick = time - (missionNamespace getVariable ["MALO_tick_time", 0]);
	MALO_tick_time = time;

	// VARS
	MALO_init = false;
	CHBN_adjustBrightness = (MALO_CFG_night_brightness / 100);

	setTimeMultiplier MALO_CFG_time_multiplier; 

	// FUNCTIONS
	["MALO", "loop"] call MALO_fnc_callFunctions;
	{["MALO", _x] call MALO_fnc_spawnFunction;} forEach ["ambient", "missions"];
	call MALO_fnc_save;

	// DELAY
	sleep MALO_delay;

};
