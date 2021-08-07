// TEMPORARY CODE

if (!hasInterface) exitWith {};

// hintSilent (str diag_fps + " " + str MALO_current_view_distance + " " + str MALO_simulation_distance + " " + str MALO_delay);

/*if (alive cap_1) then {

	_i = 1;

	for "_i" from 1 to 9 do {

		call compile (

			"{_x setDamage 1;} forEach units group cap_" + str _i + ";"

		);

	};

};*/

// malo_delay = 1;

/*if ((rating player < 0)) then {
	
	player addRating abs (rating player)
	
};*/

/*{

	if !(dynamicSimulationEnabled _x) then {diag_log _x;};

} forEach allUnits;*/

// {call compile ("trg_e_obj_" + str _x + " spawn MALO_fnc_activateTrigger;");} forEach [1, 2, 3, 4, 5, 6];

// {_x enableSimulation false; _x enableDynamicSimulation true;} forEach (allUnits - playableUnits);

// {_x enableDynamicSimulation false; _x enableSimulation false;} forEach ((allMissionObjects "ALL") - (nearestObjects [player, [], 500]));

// hint (str MALO_ambient_fire_buildings + str MALO_ambient_fire_building_distances);

// hint str (player getVariable ["cooldown", "none"]);

// hint str diag_activeScripts;