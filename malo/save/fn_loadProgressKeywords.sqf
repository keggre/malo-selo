if (false) exitWith {};

MALO_KEY_shootout = {

	civ_shootout setDamage 1;
	house_shootout setDamage 1;
	tractor_shootout setDamage 1;
	mortar_cutscene_tgt setDamage 1;

	trg_shootout_3 call MALO_fnc_activateTrigger;
	trg_shootout_5 call MALO_fnc_activateTrigger;

};

MALO_KEY_supply_truck = {

	trg_supply1 call MALO_fnc_activateTrigger;
	trg_supply_truck_2 call MALO_fnc_activateTrigger;
	trg_supply_truck_3 call MALO_fnc_activateTrigger;

	supplytruck1 setDir (markerDir "supply_truck_destination");
	supplytruck1 setPos (getMarkerPos "supply_truck_destination");

	waitUntil {["supply_truck_1"] call BIS_fnc_taskExists};

	["supply_truck_1",[supplytruck1]] call BIS_fnc_taskSetDestination; 

};

MALO_KEY_poi1 = {

	trg_poi1 call MALO_fnc_activateTrigger;
	trg_albanian call MALO_fnc_activateTrigger;

	{_x setDamage 1;} forEach units albanians;

};

MALO_KEY_poi2 = {

	trg_poi2 call MALO_fnc_activateTrigger;
	trg_ambush_1 call MALO_fnc_activateTrigger;
	trg_ambush_2 call MALO_fnc_activateTrigger;
	trg_ambush_3 call MALO_fnc_activateTrigger;

	{_x setDamage 1;} forEach [ambush_truck_1, ambush_truck_2];

};

MALO_KEY_poi3 = {};

MALO_KEY_poi4 = {};

MALO_KEY_poi5 = {};

MALO_KEY_poi6 = {};

MALO_KEY_poi7 = {};

MALO_KEY_poi8 = {};

MALO_KEY_poi9 = {};
