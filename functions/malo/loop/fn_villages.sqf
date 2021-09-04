// MANAGES VARIOUS ASPECTS OF THE VILLAGES

if (false) exitWith {};

private _count = 0;

{

	// SET MARKER COLOR AND COUNT CAPTURED VILLAGES

	private _serb = missionNamespace getVariable [(_x + "_serb"), false];
	private _un = missionNamespace getVariable [(_x + "_un"), false];
	private _croat = missionNamespace getVariable [(_x + "_croat"), false];

	if (_serb) then {
		_x setMarkerType "malo_srpskaSquareFlag";
	} else {
		if (_un) then {
			_x setMarkerType "malo_unSquareFlag";
		} else {
			if (_croat) then {
				_x setMarkerType "malo_hercegSquareFlag";
			} else {
				_x setMarkerType "malo_bosniaSquareFlag"; 
			};
		};
		_count = _count + 1;
	};


	// CREATE SPAWNS AT DISCOVERED SERBIAN VILLAGES

	call compile ("

		if (" + _x + "_discovered == true && " + _x + "_serb == true) then {
			
			'" + _x + "' setMarkerAlpha 1;

			if !('respawn_east_" + _x + "' in allMapMarkers) then {

				['" + _x + "'] spawn MALO_fnc_createRespawn;

			};

		};

	");


	// FUCK THIS ONE SPECIFIC VILLAGE

	"solnychniy" setMarkerAlpha 0;


	// MAKE CIVS FLEE WHEN ONE IS KILLED

	/*call compile ("

		if ('" + _x + "' in serb_villages) exitWith {};

		private _var = missionNamespace getVariable ['" + _x + "_civs', [always_alive]];

		if ({!alive _x} count _var > 0) then {

			{

				group _x addWaypoint [[0,0,0], 0];
				_x setSpeedMode 'FULL';
				
			} forEach _var;

		};
	
	");*/
	
} forEach villages;


// PUT VILLAGE COUNT IN TASK

private _exists = "end_mission" call BIS_fnc_taskExists;

if (_exists == true) then {

	_description = "end_mission" call BIS_fnc_taskDescription;
	_description set [0, str _count + " villages remaining."];

	["end_mission", _description] call BIS_fnc_taskSetDescription;

};


// ACTIVATE CAPSQUADS IF CASUALTY THRESHOLD IS MET

{

	private _previous_count = missionNamespace getVariable [(_x + "_count"), 1];
	private _current_count = _x call MALO_fnc_getVillageCount;
	private _casualties = (if (_previous_count == 0) then {0} else {((_previous_count - _current_count) / _previous_count)});
	
	private _capsquad_nums = missionNamespace getVariable [_x + "_capsquad_nums", []];
	private _capsquad_count = count _capsquad_nums;

	private _player_count = (count (units player_squad));
	private _population = (_player_count / 7);

	private _i = 1;

	for "_i" from 1 to _capsquad_count do {

		private _thresh = ((_i / _capsquad_count) * _population);

		if (_casualties > _thresh) then {

			private _index = _i - 1;
			private _num = _capsquad_nums select _index;

			call compile ("[cap_" + str _num + ", getMarkerPos 'cap_marker_" + str _num + "'] spawn MALO_fnc_capsquads;");

		};

	};

} forEach villages;


// SHOW MARKER

{
	if (markerAlpha _x > 0) then {
		missionNamespace setVariable [(_x + "_discovered"), true, true];
	};
	
	if (missionNamespace getVariable [(_x + "_discovered"), false]) then {
		_x setMarkerAlpha 1;
	};
} forEach villages;