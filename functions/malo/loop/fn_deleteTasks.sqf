// DELETES COMPLETED TASKS

if (!hasInterface) exitWith {};

private _tasks = player call BIS_fnc_tasksUnit;

{

	private _completed = _x call BIS_fnc_taskCompleted;

	if (_completed == true) then {

		_x call BIS_fnc_deleteTask;

	};

} forEach _tasks;