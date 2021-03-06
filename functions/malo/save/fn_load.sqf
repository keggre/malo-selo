// RUNS AT THE START OF THE MISSION AND LOADS MISSION PROGRESS FROM THE PROFILE NAMESPACE IF LOADING IS ENABLED

if (false) exitWith {};

sleep .05;


// GET THE MISSION PROGRESS FROM THE HOST'S PROFILE NAMESPACE

if (isServer) then {

	MALO_mission_progress = MALO_CFG_skip; 
	call MALO_fnc_loadProgress;

	publicVariable "MALO_mission_progress";

};


// IF PROGRESS NOT BEING LOADED

if (count MALO_mission_progress < 1 || MALO_CFG_loading == false) exitWith { 

	[] spawn {

		waitUntil {MALO_init == false};
		
		if (MALO_CFG_saving == true) then {
			MALO_TIP_saving_enabled = true;
		} else {
			MALO_TIP_saving_disabled = true;
		};

	};

};


// hintSilent "Loading mission progress...";


// LOAD VARIABLES
if (isServer) then {
	[] spawn MALO_fnc_loadVariables;
};


// LOAD INVENTORY
if (hasInterface) then {
	private _condition = profileNamespace getVariable ["MALO_returning_player", false];
	if (_condition) then {
		[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_loadInventory;
	};
};


// LOAD KEYWORDS

call MALO_fnc_loadKeywords;


// SPAWN KEYWORD FUNCTIONS

private _current = 0;
private _count = count MALO_mission_progress;

["MALO_load_mission_progress", "Loading mission progress..."] call BIS_fnc_startLoadingScreen;
{
	_current = _current + 1;
	try {
		call compile ("key_" + _x + " = [] call MALO_KEY_" + _x + ";");
	} catch {
		hintSilent (composeText ['FAILED TO LOAD: "' + _x + '"', 'EXCEPTION: "' + _exception + '"', 'Skipping.']);
	};
	progressLoadingScreen (_current / _count);
} forEach MALO_mission_progress;
"MALO_load_mission_progress" call BIS_fnc_endLoadingScreen;


// DISABLE DYNAMIC SIMULATION MOMENTARILY

enableDynamicSimulationSystem false;
uiSleep 5;
enableDynamicSimulationSystem true;


// HINT MISSION PROGRESS LOADED

MALO_TIP_progress_loaded = true;