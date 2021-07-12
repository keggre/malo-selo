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

	private _fn = {

		waitUntil {MALO_init == false};
		
		if (MALO_CFG_saving == true) then {
			hint "Saving enabled. Mission progress will be saved automatically.";
		} else {
			hint "Saving not enabled. Mission progress will not be saved!";
		};

	};

	[] spawn _fn;

};

hintSilent "Loading mission progress...";


// LOAD INVENTORY
if ((profileNamespace getVariable ["MALO_saved_inventory", false]) !isEqualTo false) then {
	[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_loadInventory;
};


// LOAD KEYWORDS

call MALO_fnc_loadProgressKeywords;


// SPAWN KEYWORD FUNCTIONS

private _current = 0;
private _count = count MALO_mission_progress;

{

	_current = _current + 1;

	try {

		call compile ("key_" + _x + " = [] spawn MALO_KEY_" + _x + ";");

	} catch {

		hintSilent (composeText ['FAILED TO LOAD: "' + _x + '"', 'EXCEPTION: "' + _exception + '"', 'Skipping.']);

	};

	progressLoadingScreen (_current / _count);
	
} forEach MALO_mission_progress;


// DISABLE DYNAMIC SIMULATION MOMENTARILY

enableDynamicSimulationSystem false;
uiSleep 5;
enableDynamicSimulationSystem true;


// HINT MISSION PROGRESS LOADED

private _fn = {

	_i = 0;

	for "_i" from 0 to 150 do {

		hintSilent "Mission progress loaded.";
		uiSleep .1;

	};

};

[] spawn _fn;