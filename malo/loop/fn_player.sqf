// RUNS LOCALLY

if (!hasInterface) exitWith {};
if (MALO_init == true) exitWith {};

// SAVE INVENTORY
[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_saveInventory;

// SIMULATION
player enableSimulationGlobal true;
player triggerDynamicSimulation true;