// DEALS WITH CIVILIAN BEHAVIOR

if (!isServer) exitWith {};

MALO_flee_limit = 10;

MALO_flee_count = 0;


// MAKES CIV FLEE TO NEAREST BUILDING

MALO_fnc_civs_flee = {

	params ["_civ"];

	if (_civ getVariable ["fleeing", false]) exitWith {};

	_civ setVariable ["fleeing", true, true];
	
	private _building_types = MALO_building_types;
	private _radius = 100;
	private _delay = random [0, 45, 60];
	
	private _fear = _civ getVariable ["fear", 1];
	private _random = _civ getVariable ["random", 0];

	if (_random <= _fear) then {

		_civ switchMove "";

		switch (round(random 2)) do {
				
			case 0:{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			case 1:{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			case 2:{_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			default{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
		
		};

		private _objects = nearestObjects [_civ, _building_types, _radius];

		private _positions = [[0,0,0]];
		{
			{_positions append [_x];} forEach (_x buildingPos -1);
		} forEach _objects;

		private _position = selectRandom _positions;

		_civ doMove _position;

		MALO_flee_count = MALO_flee_count + 1;

		private _distance_1 = 0;
		while {(_distance_1 < 50) && !(MALO_flee_count > MALO_flee_limit)} do {
			private _distance_1 = 100;
			{
				private _distance_2 = _x distance _civ;
				if (_distance_1 > _distance_2) then {
					_distance_1 = _distance_2;
				};
				sleep MALO_delay;
			} forEach playableUnits;	
		};

		MALO_flee_count = MALO_flee_count - 1;

		_civ switchMove "";
	
	};

	_civ setVariable ["fleeing", false, true];

};


// RUNS LOCALLY AND ADDS CURSOR TARGET TO AN ARRAY

MALO_fnc_civs_targets = {

	if (!hasInterface) exitWith {};
	
	private _object = cursorObject;

	if (_object in MALO_cursor_targets) exitWith {};

	if ((_object isKindOf "MAN") && (primaryWeapon player != "") && (cameraView == "GUNNER")) then {

		MALO_cursor_targets append [_object];
		publicVariable "MALO_cursor_targets";

		_object spawn MALO_fnc_civs_targeted;

	};

};


// RUNS WHEN A UNIT IS TARGETED BY A PLAYER

MALO_fnc_civs_targeted = {

	params ["_unit"];

	_unit setVariable ["targeted", true, true];

	private _fleeing = _unit getVariable ["fleeing", false];
	private _surrender = _unit getVariable ["surrender", false];

	if !(_surrender || _fleeing) then {
		_unit setVariable ["surrender", true, true];
		_unit spawn MALO_fnc_civs_surrender;
	};

	while {_unit in MALO_cursor_targets} do {
		waitUntil {if (_unit in MALO_cursor_targets) then {false} else {true}};
		sleep 5;
	};

	sleep 1;

	_unit setVariable ["targeted", false, true];

};


// MAKES CIV SURRENDER

MALO_fnc_civs_surrender = {

	params ["_civ"];

	private _fear = _civ getVariable ["fear", 1];
	private _armed = _civ getVariable ["armed", true];
	private _random = _civ getVariable ["random", 0];

	if (_random <= _fear && !_armed) then {
	
		_civ action ["Surrender", _civ];

		while {_civ in MALO_cursor_targets} do {
			waitUntil {if (_civ in MALO_cursor_targets) then {false} else {true}};
			sleep (random [3, 5, 20]);
		};

		[_civ] spawn MALO_fnc_civs_flee;

	};

	sleep 1;

	_civ setVariable ["surrender", false, true];

};


// LOOP THROUGH NEARBY UNITS

private _units = [];
{_units append (nearestObjects [_x, ["MAN"], 50]);} forEach playableUnits;

/*private _close_units = [];
{_units append (nearestObjects [_x, ["MAN"], 10]);} forEach playableUnits;

private _serb_units = [];
{_serb_units append (missionNamespace getVariable [_x + "_civs", []]);} forEach serb_villages;*/

{
	if (!isPlayer _x) then {

		// DETERMINE IF UNIT IS ARMED OR UNARMED
		if (_x call MALO_fnc_isArmed) then {
			_x setVariable ["armed", true, true];
		} else {
			_x setVariable ["armed", false, true];
		};

		private _fear = _x getVariable ["fear", 1];
		private _armed = _x getVariable ["armed", false];
		private _will_flee = _x getVariable ["willFlee", false];
		private _fleeing = _x getVariable ["fleeing", false];
		private _targeted = _x getVariable ["targeted", false];
		private _surrender = _x getVariable ["surrender", false];

		// MAKE A LIST OF CURSOR TARGETS
		MALO_cursor_targets = [];
		publicVariable "MALO_cursor_targets";
		remoteExec ["MALO_fnc_civs_targets", 0];

		// IF A CIV ISN'T MOVING WHILE FLEEING
		if (((speed (vehicle _x)) == 0) && _fleeing) then {
			_x doMove (getMarkerPos "origin"); 
		};
		
		// BEHAVIOR EVENTS

		if !(_will_flee || _armed || _fleeing) then {
			
			private _random = ((random [0, 50, 100]) / 100);
			
			_x setVariable ["random", _random, true];
			_x setVariable ["willFlee", true, true];


			// FLEE IF FIRED NEAR

			_x addEventHandler ["FiredNear", {

				private _civ = _this select 0;
				
				_civ spawn MALO_fnc_civs_flee;

				_civ setVariable ["willFlee", false, true];

			}];

		};

	};

} forEach _units;