// ADJUSTS VIEW DISTANCE BASED OFF VARIOUS FACTORS, INCLUDING FRAMERATE

if (!hasInterface) exitWith {if (MALO_CFG_dynamic_view_distance == true) then {setViewDistance MALO_CFG_dynamic_view_distance_max;} else {setViewDistance MALO_CFG_view_distance;};};

MALO_current_view_distance = (MALO_current_view_distance + (MALO_next_view_distance - MALO_current_view_distance) * MALO_tick / (MALO_CFG_dynamic_view_distance_smoothing /** 5*/));

setViewDistance MALO_current_view_distance;

view_distance_reducers = [

	// VILLAGES
	
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "chernogorsk", 2000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "dolina", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "elektrozavodsk", 2000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "guglovo", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "kamushovo", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "mogilevka", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "msta", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "nadezhdino", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "novy", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "orlovets", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "polana", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "pusta", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "shakhovka", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "solnychniy", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "staroye", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "stary", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "tulga", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "vyshnoye", 1000]

];

view_distance_increasers = [

	// ARTY POSITION
	[3000, position darty_2, 100]/*,

	// PEAKS
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_1", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_2", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_3", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_4", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_5", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_6", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_7", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_8", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_9", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_10", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_11", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_12", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_13", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_14", 250],
	[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_15", 250]*/

];

MALO_next_view_distance = MALO_CFG_view_distance;

if (MALO_CFG_dynamic_view_distance == true) then {

	// REDUCERS
	{[_x, true] call MALO_fnc_setViewDistance;} forEach view_distance_reducers;

	// ALTITUDE MODIFIER
	MALO_next_view_distance = MALO_next_view_distance + ((getPosASL player) select 2) * MALO_CFG_dynamic_view_distance_altitude_multiplier / 10;

	// TARGET FPS MODIFIER
	if (diag_fps < MALO_CFG_target_framerate) then {
		MALO_next_view_distance = MALO_next_view_distance * (diag_fps / (MALO_CFG_target_framerate * 2));
	};

	// INCREASERS
	{[_x, false] call MALO_fnc_setViewDistance;} forEach view_distance_increasers;

	// MIN
	if (MALO_next_view_distance < MALO_CFG_dynamic_view_distance_min) then {

		MALO_next_view_distance = MALO_CFG_dynamic_view_distance_min;

	};

	// MAX
	if (MALO_next_view_distance > MALO_CFG_dynamic_view_distance_max) then {

		MALO_next_view_distance = MALO_CFG_dynamic_view_distance_max;

	};

};

MALO_fog_value = (((3000 - MALO_next_view_distance) / 6000) + .05);
MALO_ovc_value =  (((3000 - MALO_next_view_distance) / 12000) + .5);

if (MALO_fog_value > .5) then {

	MALO_fog_value = .5;

};

if (MALO_ovc_value > 1) then {

	MALO_ovc_value = .75;

};