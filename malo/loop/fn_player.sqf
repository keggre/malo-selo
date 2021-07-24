// RUNS LOCALLY

if (!hasInterface) exitWith {};
if (MALO_init == true) exitWith {};


// MARK AS RETURNING PLAYER

profileNamespace setVariable ["MALO_returning_player", true];


// SAVE INVENTORY

[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_saveInventory;


// CREATE EVENT HANDLERS FOR PROFILE NAMESPACE SAVING
private _events = [
	"take"
];

{
	if !(player getVariable [(_x + "SaveEventCreated"), false]) then {
		player setVariable [(_x + "SaveEventCreated"), true, true];
		call compile ("
			player addEventHandler ['" + _x + "', {
				saveProfileNamespace;
				private _unit = _this select 0;
				_unit setVariable [('" + _x + "' + 'SaveEventCreated'), false, true];
				_unit removeEventHandler ['" + _x + "', _thisEventHandler];
			}];
		");
	};
} forEach _events;


// SIMULATION
player enableSimulationGlobal true;
player triggerDynamicSimulation true;