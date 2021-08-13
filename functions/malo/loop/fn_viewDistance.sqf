// ADJUSTS VIEW DISTANCE BASED OFF VARIOUS FACTORS, INCLUDING FRAMERATE

if (!hasInterface) exitWith {if (MALO_CFG_dynamic_view_distance == true) then {setViewDistance MALO_CFG_dynamic_view_distance_max;} else {setViewDistance MALO_CFG_view_distance;};};

MALO_fnc_viewDistance_modifier = {

	params ["_modifier", "_is_reducer"];

	_distance = (_modifier select 0);
	_position = (_modifier select 1);
	_radius = (_modifier select 2);

	if (player distance _position < _radius) then {

		if (_is_reducer == true && MALO_next_view_distance > _distance) then {
		
			MALO_next_view_distance = _distance;

		} else {

			if (MALO_next_view_distance < _distance) then {

				MALO_next_view_distance = _distance;

			};

		};

	};

};

MALO_current_view_distance = (MALO_current_view_distance + (MALO_next_view_distance - MALO_current_view_distance) * MALO_tick / (MALO_CFG_dynamic_view_distance_smoothing /** 5*/));

setViewDistance MALO_current_view_distance;

private _average_alt = 208.51;

view_distance_reducers = [

	// VILLAGES
	
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "chernogorsk", 2000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "dolina", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "elektrozavodsk", 2000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "guglovo", 1000],
	[(MALO_CFG_view_distance / 1.5), getMarkerPos "kamyshovo", 1000],
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
	[3000, position darty_2, 500],

	// CHERNO BASE TEST
	[1000, position cherno_base_test, 500],

	// TRENCH BASES
	[2000, getMarkerPos "t_install_1", 500],
	[2000, getMarkerPos "t_install_2", 500],
	[2000, getMarkerPos "t_install_3", 500]

	// PEAKS
	/*[(MALO_CFG_view_distance * 1.5), getMarkerPos "peak_1", 250],
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
	{[_x, true] call MALO_fnc_viewDistance_modifier;} forEach view_distance_reducers;

	// ALTITUDE MODIFIER
	private _asl = (getPosASL player) select 2;
	private _atl = (getPosATL player) select 2;
	private _talt = _asl - _atl;
	private _avg_talt = _average_alt;
	private _taltma = _talt - _avg_talt;
	private _mult_1 = MALO_CFG_dynamic_view_distance_altitude_multiplier / 2;
	private _mult_2 = MALO_CFG_dynamic_view_distance_altitude_multiplier;
	private _mod_1 = _mult_1 * _taltma;
	private _mod_2 = _mult_2 * _atl;
	private _modifier = _mod_1 + _mod_2;
	MALO_next_view_distance = MALO_next_view_distance + _modifier;
	if (MALO_next_view_distance < 100) then {
		MALO_next_view_distance = 100;
	};

	// TARGET FPS MODIFIER
	if (diag_fps < MALO_CFG_target_framerate) then {
		MALO_next_view_distance = MALO_next_view_distance * (diag_fps / (MALO_CFG_target_framerate * 2));
	};

	// INCREASERS
	{[_x, false] call MALO_fnc_viewDistance_modifier;} forEach view_distance_increasers;

	// MIN
	if (MALO_next_view_distance < MALO_CFG_dynamic_view_distance_min) then {
		MALO_next_view_distance = MALO_CFG_dynamic_view_distance_min;
	};

	// MAX
	if (MALO_next_view_distance > MALO_CFG_dynamic_view_distance_max) then {
		MALO_next_view_distance = MALO_CFG_dynamic_view_distance_max;
	};

};

private _distance = if (MALO_next_view_distance < MALO_current_view_distance) then {MALO_next_view_distance} else {MALO_current_view_distance};
private _atl = (getPosATL player) select 2;
private _asl = (getPosASL player) select 2;

MALO_fog_value = (((3000 - _distance) / 6000) + (.002 * _atl) + .05);
MALO_ovc_value =  (((3000 - _distance) / 12000) + .5);

private _max_fog_value = .5 + (_asl / 1000);
if (_max_fog_value > 1) then {
	_max_fog_value = 1;
};

if (MALO_fog_value > _max_fog_value) then {
	MALO_fog_value = _max_fog_value;
};

if (MALO_ovc_value > 1) then {
	MALO_ovc_value = .75;
};