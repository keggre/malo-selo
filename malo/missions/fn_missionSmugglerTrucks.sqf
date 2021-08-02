// MISSION SCRIPT

if (false) exitWith {};

private _mission_required = "poi3";

if (missionNamespace getVariable ["smuggler_trucks_destroyed", false]) exitWith {};
if !(_mission_required in MALO_mission_progress) exitWith {};

////

sleep 30;

trg_smuggler_trucks call MALO_fnc_activateTrigger;

_trucks = [

	smuggler_truck_1,
	smuggler_truck_2,
	smuggler_truck_3,
	smuggler_truck_4,
	smuggler_truck_5

];

sleep 15;

_n = 0;

{
	
	_n = _n + 1;
	_name = ["smuggler_truck_task_", str _n] joinString "";

	[east, [_name, "smuggler_trucks"], ["", "smuggler truck"], _x, "CREATED", -1, false, "truck"] call BIS_fnc_taskCreate;

} forEach _trucks;

while {{!alive _x} count _trucks < count _trucks} do {

	sleep MALO_delay * 10;

	_n = 0;

	{
		_n = _n + 1;
		_name = ["smuggler_truck_task_", str _n] joinString "";

		if (!alive _x) then {

			[_name, "SUCCEEDED"] call BIS_fnc_taskSetState;
			["smuggler_truck_" + str _n] call MALO_fnc_saveKeyword;

		};

		_player_count = count playableUnits;
		_i = 0;

		for "_i" from 0 to _player_count - 1 do {

			_player = playableUnits select _i;

			if (_player distance _x < 50) then {

				_grp_old = group driver _x;
				_grp_new = createGroup west; 

				units _grp_old joinSilent _grp_new;

			}

		}

	} forEach _trucks;

};

_n = 0;

{
	_n = _n + 1;
	_name = ["smuggler_truck_task_", str _n] joinString "";

	[_name] call BIS_fnc_deleteTask;

} forEach _trucks;

_trucks spawn MALO_fnc_deleteObjects;

smuggler_trucks_destroyed = true;