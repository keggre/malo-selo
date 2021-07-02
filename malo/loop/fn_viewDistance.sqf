current_view_distance = (current_view_distance + (next_view_distance - current_view_distance) / MALO_dynamic_view_distance_smoothing);
setViewDistance current_view_distance;

view_distance_reducers = [

	// VILLAGES
	[(MALO_view_distance / 3), getMarkerPos "chernogorsk", 2000],
	[(MALO_view_distance / 3), getMarkerPos "dolina", 1000],
	[(MALO_view_distance / 3), getMarkerPos "elektrozavodsk", 2000],
	[(MALO_view_distance / 3), getMarkerPos "guglovo", 1000],
	[(MALO_view_distance / 3), getMarkerPos "kamushovo", 1000],
	[(MALO_view_distance / 3), getMarkerPos "mogilevka", 1000],
	[(MALO_view_distance / 3), getMarkerPos "msta", 1000],
	[(MALO_view_distance / 3), getMarkerPos "nadezhdino", 1000],
	[(MALO_view_distance / 3), getMarkerPos "novy", 1000],
	[(MALO_view_distance / 3), getMarkerPos "orlovets", 1000],
	[(MALO_view_distance / 3), getMarkerPos "polana", 1000],
	[(MALO_view_distance / 3), getMarkerPos "pusta", 1000],
	[(MALO_view_distance / 3), getMarkerPos "shakhovka", 1000],
	[(MALO_view_distance / 3), getMarkerPos "solnychniy", 1000],
	[(MALO_view_distance / 3), getMarkerPos "staroye", 1000],
	[(MALO_view_distance / 3), getMarkerPos "stary", 1000],
	[(MALO_view_distance / 3), getMarkerPos "tulga", 1000],
	[(MALO_view_distance / 3), getMarkerPos "vyshnoye", 1000]

];

view_distance_increasers = [

	// ARTY POSITION
	[3000, position darty_2, 100],

	// PEAKS
	[(MALO_view_distance * 3), getMarkerPos "peak_1", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_2", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_3", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_4", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_5", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_6", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_7", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_8", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_9", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_10", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_11", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_12", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_13", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_14", 250],
	[(MALO_view_distance * 3), getMarkerPos "peak_15", 250]

];

next_view_distance = MALO_view_distance;

if (MALO_dynamic_view_distance == true) then {

	//REDUCERS
	{[_x, true] call MALO_fnc_setViewDistance;} forEach view_distance_reducers;

	//INCREASERS
	{[_x, false] call MALO_fnc_setViewDistance;} forEach view_distance_increasers;

	next_view_distance = next_view_distance + ((getPosASL player) select 2) * MALO_dynamic_view_distance_altitude_multiplier / 10;

	if (next_view_distance < MALO_dynamic_view_distance_min) then {

		next_view_distance = MALO_dynamic_view_distance_min;

	};

	if (next_view_distance > MALO_dynamic_view_distance_max) then {

		next_view_distance = MALO_dynamic_view_distance_max;

	};

};

