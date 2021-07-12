// CURRENTLY UNFINISHED

if (false) exitWith {};

MALO_simulated_units = [];

{

	_x triggerDynamicSimulation false;

} forEach (allUnits - playableUnits);

// {_x enableDynamicSimulation true;} forEach (allUnits - playableUnits);