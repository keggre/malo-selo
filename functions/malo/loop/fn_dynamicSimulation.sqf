// SETS DYNAMIC SIMULATION DISTANCES

if (false) exitWith {};

"Group" setDynamicSimulationDistance MALO_simulation_distance;
"Vehicle" setDynamicSimulationDistance (MALO_simulation_distance * 2);
"EmptyVehicle" setDynamicSimulationDistance (MALO_simulation_distance / 2);
"Prop" setDynamicSimulationDistance (MALO_simulation_distance / 2);