// DELETES COMPLETED TASKS

if (!hasInterface) exitWith {};

MALO_tasks_last_checked = missionNamespace getVariable ["MALO_tasks_last_checked", time];

if (time - MALO_tasks_last_checked < 60) exitWith {};

MALO_tasks_last_checked = time;

private _tasks = player call BIS_fnc_tasksUnit;

{

	private _completed = _x call BIS_fnc_taskCompleted;

	if (_completed == true) then {

		_x call BIS_fnc_deleteTask;

	};

} forEach _tasks;