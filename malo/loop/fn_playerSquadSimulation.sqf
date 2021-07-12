// ENABLES SIMULATION FOR THE PLAYER SQUAD IN CASE OF JIP

if (!isServer) exitWith {};
if (MALO_init == true) exitWith {};

{_x enableSimulationGlobal true; _x triggerDynamicSimulation true;} forEach units player_squad;