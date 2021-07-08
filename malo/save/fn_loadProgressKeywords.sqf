if (false) exitWith {};


// FIRST MISSION

MALO_KEY_shootout = {

	deleteVehicle civ_shootout;
	deleteVehicle tractor_shootout;
	deleteVehicle mortar_cutscene_tgt;
	
	house_shootout setDamage 1;

	trg_shootout_3 call MALO_fnc_activateTrigger;
	trg_shootout_5 call MALO_fnc_activateTrigger;

};


// SECOND MISSION

MALO_KEY_supply_truck = {

	trg_supply1 call MALO_fnc_activateTrigger;
	trg_supply_truck_2 call MALO_fnc_activateTrigger;
	trg_supply_truck_3 call MALO_fnc_activateTrigger;

	supplytruck1 setDir (markerDir "supply_truck_destination");
	supplytruck1 setPos (getMarkerPos "supply_truck_destination");

	waitUntil {["supply_truck_1"] call BIS_fnc_taskExists};

	["supply_truck_1",[supplytruck1]] call BIS_fnc_taskSetDestination; 

};


// VILLAGES

{

	call compile (

		"MALO_KEY_" + _x + " = {
			[trg_" + _x + "] call MALO_fnc_activateTrigger;
			[west, getMarkerPos '" + _x + "', 500] call MALO_fnc_killWithinRadius;
		};"

	);

} forEach villages;


// ELEKTRO OBJECTIVES

{

	call compile (

		"MALO_KEY_e_obj_" + str _x + " = {
			[trg_e_obj_" + str _x + "] call MALO_fnc_activateTrigger;
			[west, position trg_e_obj_" + str _x + ", 50] call MALO_fnc_killWithinRadius;
		};"

	);

} forEach [1, 2, 3, 4, 5, 6];


// SMUGGLER TRUCKS

{

	call compile (

		"MALO_KEY_smuggler_truck_" + str _x + " = {
			smuggler_truck_" + str _x + " setDamage 1;
		};"

	);

} forEach [1, 2, 3, 4, 5];


// TANK

MALO_KEY_tank = {

	[trg_tank_1] call MALO_fnc_activateTrigger;

	tank_1 setDir (markerDir "tank_destination");
	tank_1 setPos (getMarkerPos "tank_destination");

};


// POIS

MALO_KEY_poi1 = {

	trg_poi1 call MALO_fnc_activateTrigger;

	// waitUntil {["poi1"] call BIS_fnc_taskExists};

	trg_albanian call MALO_fnc_activateTrigger;

	{_x setDamage 1;} forEach units albanians;

	_poi = "poi1";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi2 = {

	trg_poi2 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi2"] call BIS_fnc_taskExists};

	trg_scout_1 call MALO_fnc_activateTrigger;
	trg_guglovo_load call MALO_fnc_activateTrigger;

	_poi = "poi2";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi3 = {

	trg_poi3 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi3"] call BIS_fnc_taskExists};

	trg_ambush_1 call MALO_fnc_activateTrigger;
	trg_ambush_2 call MALO_fnc_activateTrigger;
	trg_ambush_3 call MALO_fnc_activateTrigger;

	{_x setDamage 1;} forEach [ambush_truck_1, ambush_truck_2];

	_poi = "poi3";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi4 = {

	trg_poi4 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi4"] call BIS_fnc_taskExists};

	trg_arty call MALO_fnc_activateTrigger;

	_poi = "poi4";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi5 = {

	trg_poi5 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi5"] call BIS_fnc_taskExists};

	trg_pilot call MALO_fnc_activateTrigger;
	trg_pilot_capture call MALO_fnc_activateTrigger;

	deleteVehicle pilot;

	_poi = "poi5";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi6 = {

	trg_poi6 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi6"] call BIS_fnc_taskExists};

	trg_partisan call MALO_fnc_activateTrigger;

	_poi = "poi6";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi7 = {

	trg_poi7 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi7"] call BIS_fnc_taskExists};

	[west, position trg_arkan, 100] call MALO_fnc_killWithinRadius;

	trg_arkan call MALO_fnc_activateTrigger;
	trg_arkan_2 call MALO_fnc_activateTrigger;

	_poi = "poi7";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi8 = {

	trg_poi8 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi8"] call BIS_fnc_taskExists};

	trg_kidnap call MALO_fnc_activateTrigger;
	trg_kidnap_capture_1 call MALO_fnc_activateTrigger;
	trg_kidnap_capture_2 call MALO_fnc_activateTrigger;

	{deleteVehicle _x;} forEach units un_squad_1;

	_poi = "poi8";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};

MALO_KEY_poi9 = {

	trg_poi9 call MALO_fnc_activateTrigger;
	
	// waitUntil {["poi9"] call BIS_fnc_taskExists};

	trg_castle1_1 call MALO_fnc_activateTrigger;
	trg_castle1_2 call MALO_fnc_activateTrigger;
	trg_castle1_3 call MALO_fnc_activateTrigger;
	trg_castle1_4 call MALO_fnc_activateTrigger;

	[west, getMarkerPos "castle1", 250] call MALO_fnc_killWithinRadius;

	_poi = "poi9";
	waitUntil {[_poi] call BIS_fnc_taskExists};
	[_poi] call BIS_fnc_deleteTask;

};
