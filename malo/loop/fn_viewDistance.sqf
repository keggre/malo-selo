if (!hasInterface) exitWith {if (MALO_dynamic_view_distance == true) then {setViewDistance MALO_dynamic_view_distance_max;} else {setViewDistance MALO_view_distance;};};

current_view_distance = (current_view_distance + (next_view_distance - current_view_distance) / (MALO_dynamic_view_distance_smoothing * 10));

setViewDistance current_view_distance;

60 setFog fog_value;
60 setOvercast ovc_value;

view_distance_reducers = [

	// VILLAGES
	
	[(MALO_view_distance / 1.5), getMarkerPos "chernogorsk", 2000],
	[(MALO_view_distance / 1.5), getMarkerPos "dolina", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "elektrozavodsk", 2000],
	[(MALO_view_distance / 1.5), getMarkerPos "guglovo", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "kamushovo", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "mogilevka", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "msta", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "nadezhdino", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "novy", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "orlovets", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "polana", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "pusta", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "shakhovka", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "solnychniy", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "staroye", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "stary", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "tulga", 1000],
	[(MALO_view_distance / 1.5), getMarkerPos "vyshnoye", 1000]

];

view_distance_increasers = [

	// ARTY POSITION
	[3000, position darty_2, 100]/*,

	// PEAKS
	[(MALO_view_distance * 1.5), getMarkerPos "peak_1", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_2", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_3", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_4", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_5", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_6", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_7", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_8", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_9", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_10", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_11", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_12", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_13", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_14", 250],
	[(MALO_view_distance * 1.5), getMarkerPos "peak_15", 250]*/

];

next_view_distance = MALO_view_distance;

if (MALO_dynamic_view_distance == true) then {

	// REDUCERS
	{[_x, true] call MALO_fnc_setViewDistance;} forEach view_distance_reducers;

	// ALTITUDE MODIFIER
	next_view_distance = next_view_distance + ((getPosASL player) select 2) * MALO_dynamic_view_distance_altitude_multiplier / 10;

	// TARGET FPS MODIFIER
	if (diag_fps < MALO_target_framerate) then {
		next_view_distance = next_view_distance * (diag_fps / (MALO_target_framerate * 2));
	};

	// INCREASERS
	{[_x, false] call MALO_fnc_setViewDistance;} forEach view_distance_increasers;

	// MIN
	if (next_view_distance < MALO_dynamic_view_distance_min) then {

		next_view_distance = MALO_dynamic_view_distance_min;

	};

	// MAX
	if (next_view_distance > MALO_dynamic_view_distance_max) then {

		next_view_distance = MALO_dynamic_view_distance_max;

	};

};

fog_value = (((3000 - next_view_distance) / 6000) + .05);
ovc_value =  (((3000 - next_view_distance) / 12000) + .5);

if (fog_value > .5) then {

	fog_value = .5;

};

if (ovc_value > 1) then {

	ovc_value = .75;

};