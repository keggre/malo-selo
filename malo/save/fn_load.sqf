if (false) exitWith {};

sleep .05;

fn_intro = [] spawn MALO_fnc_intro;

if (isServer) then {

	MALO_mission_progress = MALO_CFG_skip; 
	call MALO_fnc_loadProgress;

	publicVariable "MALO_mission_progress";

};

if (count MALO_mission_progress < 1) exitWith { 

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

call MALO_fnc_loadProgressKeywords;

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

enableDynamicSimulationSystem false;
uiSleep 5;
enableDynamicSimulationSystem true;

private _fn = {

	_i = 0;

	for "_i" from 0 to 150 do {

		hint "Mission progress loaded.";
		uiSleep .1;

	};

};

[] spawn _fn;