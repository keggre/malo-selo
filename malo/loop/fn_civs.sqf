// DEALS WITH CIVILIAN BEHAVIOR

if (!isServer) exitWith {};


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
		
		_civ setVariable ["targeted", false, true];

		switch (round(random 2)) do {
				
			case 0:{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			case 1:{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			case 2:{_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			default{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
		
		};

		private _objects = nearestObjects [_civ, _building_types, _radius];
		private _positions = _objects buildingPos -1;
		private _position = selectRandom _positions;

		_civ doMove _position;

		sleep _delay;

		_civ switchMove "";
	
	};

	_civ setVariable ["fleeing", false, true];

};


// RUNS LOCALLY AND ADDS CURSOR TARGET TO AN ARRAY

MALO_fnc_civs_targets = {

	if (!hasInterface) exitWith {};
	
	private _object = cursorTarget;

	if (_object isKindOf "MAN") then {

		_object spawn MALO_fnc_civs_targeted;

	};

};


// RUNS WHEN A UNIT IS TARGETED BY A PLAYER

MALO_fnc_civs_targeted = {

	params ["_unit"];

	MALO_cursor_targets append [_unit];
	publicVariable "MALO_cursor_targets";

	_unit setVariable ["targeted", true, true]

	while {_unit in MALO_cursor_targets} do {
		waitUntil {_unit !in MALO_cursor_targets};
		sleep 1;
	};

	sleep 1;

	_unit setVariable ["targeted", false, true];

};


// MAKES CIV SURRENDER

MALO_fnc_civs_surrender = {

	params ["_civ"];

	_civ setVariable ["surrender", true, true];

	if (_random <= _fear) then {
	
		_civ action ["Surrender", _civ]

		waitUntil {(_civ getVariable ["targeted", false]) == false};

		_civ switchMove "";

	};

	sleep 1;

	_civ setVariable ["surrender", false, true];

};

// LOOPING THROUGH ALL CIVS

{

	if (side _x != civilian) exitWith {};

	if (_x primaryWeapon != "") then {
		_x setVariable ["armed", false, true];
	};

	private _fear = _x getVariable ["fear", 1];
	private _armed = _x getVariable ["armed", true];
	private _will_flee = _x getVariable ["willFlee", false];
	private _fleeing = _x getVariable ["fleeing", false];
	private _targeted = _x getVariable ["targeted", false];
	private _surrender = _x getVariable ["surrender", false];

	// MAKE A LIST OF CURSOR TARGETS
	MALO_cursor_targets = [];
	publicVariable "MALO_cursor_targets";
	remoteExec ["MALO_fnc_civs_targets", 0]

	// IF A CIV ISN'T MOVING WHILE FLEEING

	if (((speed (vehicle _x)) == 0) && _fleeing) then {
		
		_x doMove (getMarkerPos "origin"); 

	};
	
	// ADD EVENT HANDLERS FOR FLEEING

	if (!_will_flee && !_armed && !_fleeing) then {
		
		private _random = ((random [0, 50, 100]) / 100);
		
		_x setVariable ["random", _random, true];
		_x setVariable ["willFlee", true, true];

		_x addEventHandler ["FiredNear", {

			private _civ = _this select 0;
			
			_civ spawn MALO_fnc_civs_flee;

			_civ setVariable ["willFlee", false, true];

		}];

		if (_targeted && !_surrender) then {

			_x spawn MALO_fnc_surrender;

		};

	};

} forEach (allUnits - switchableUnits - playableUnits);