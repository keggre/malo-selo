// MOVES A GROUP TO A NEW GROUP ON A DIFFERENT SIDE, RETURNS THE NEW GROUP

if (false) exitWith {};

params ["_group_old", "_side"];

private _dynamic_simulation = dynamicSimulationEnabled _group_old;
private _group_new = createGroup _side;

_group_new enableDynamicSimulation _dynamic_simulation;

{
	private _unit = _x;
	if (!isPlayer _unit) then {
		[_unit] joinSilent _group_new;
	};
} forEach units _group_old;