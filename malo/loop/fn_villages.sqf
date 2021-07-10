if (false) exitWith {};

private _count = 0;

{

	// SET MARKER COLOR AND COUNT CAPTURED VILLAGES

	private _serb = call compile (_x + "_serb");

	if (_serb == true) then {

		_x setMarkerType "o_hq"; 

	} else {

		_x setMarkerType "b_hq"; 
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

	call compile ("

		if ('" + _x + "' in serb_villages) exitWith {};

		private _var = missionNamespace getVariable ['" + _x + "_civs', [always_alive]];

		if ({!alive _x} count _var > 0) then {

			{
				
				_car = nearestObject [_x, 'CAR'];

				if (isNull driver _car && _x distance _car < 10) then {

					_waypoint = group _x addWaypoint [position _car, 0];
					
					_waypoint setWaypointType 'GETIN';

				};

				group _x addWaypoint [getMarkerPos 'origin', 0];
				_x setUnitPos 'UP';
				_x setSpeedMode 'FULL';
				
			} forEach _var;

		};
	
	");
	
} forEach villages;


// PUT VILLAGE COUNT IN TASK

private _exists = "end_mission" call BIS_fnc_taskExists;

if (_exists == true) then {

	_description = "end_mission" call BIS_fnc_taskDescription;
	_description set [0, str _count + " villages remaining."];

	["end_mission", _description] call BIS_fnc_taskSetDescription;

};