if (false) exitWith {};

private _count = 0;

{

	private _serb = call compile (_x + "_serb");

	if (_serb == true) then {

		_x setMarkerType "o_hq"; 

	} else {

		_x setMarkerType "b_hq"; 
		_count = _count + 1;

	};

	call compile ("

		if (" + _x + "_discovered == true) then {
			
			'" + _x + "' setMarkerAlpha 1;

			if !('respawn_east_" + _x + "' in allMapMarkers) then {

				['" + _x + "'] spawn MALO_fnc_createRespawn;

			};

		};

	");

	"solnychniy" setMarkerAlpha 0;
	
} forEach villages;

private _exists = "end_mission" call BIS_fnc_taskExists;

if (_exists == true) then {

	_description = "end_mission" call BIS_fnc_taskDescription;
	_description set [0, str _count + " villages remaining."];

	["end_mission", _description] call BIS_fnc_taskSetDescription;

};