if (false) exitWith {};

MALO_simulated_units = [


	
];


{

	_x triggerDynamicSimulation false;

} forEach allUnits;

{

	_x triggerDynamicSimulation true;

} forEach units group player;