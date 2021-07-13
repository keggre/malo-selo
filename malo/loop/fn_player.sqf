// RUNS LOCALLY

if (!hasInterface) exitWith {};
if (MALO_init == true) exitWith {};

// MARK AS RETURNING PLAYER
profileNamespace setVariable ["MALO_returning_player", true];

// SAVE INVENTORY
[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_saveInventory;

// SIMULATION
player enableSimulationGlobal true;
player triggerDynamicSimulation true;