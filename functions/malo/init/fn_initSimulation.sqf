// DEALS WITH PERFORMANCE RELATED THINGS

if (!isServer) exitWith {};

MALO_simulated_units = [];
MALO_simple_object_types = MALO_building_types + ["HOUSE", "BUILDING", "Land_Razorwire_F", "Land_BagFence_Long_F", "CUP_ker_deravej", "TREE", "RHS_mine_a200_bz", "CUP_les_dub", "144_vegetation_MB_T_Ulmus_Smalliviy", "LAND_RattanChair_01_F", "LAND_RattanTable_01_F"];

{
	_x triggerDynamicSimulation false;
} forEach (allUnits - playableUnits);

{
	private _group = _x;
	if (_group != player_squad) then {
		_group deleteGroupWhenEmpty true;
	};
} forEach allGroups;

// {_x enableDynamicSimulation true;} forEach (allUnits - playableUnits);

[] spawn {
	waitUntil {!MALO_init};
	if (MALO_CFG_use_simple_objects) then {
		{
			if (typeOf _x in MALO_simple_object_types) then {
				_x call BIS_fnc_replaceWithSimpleObject;
			};
		} forEach allMissionObjects "ALL";
		{
			if (!(typeof _x in MALO_serb_vehicles) && (selectRandom [true, true, false]) && (isNull driver _x)) then {
				_x call BIS_fnc_replaceWithSimpleObject;
			};
		} forEach vehicles;
	};
};