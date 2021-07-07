if (false) exitWith {};

if (isServer) then {

	MALO_mission_progress = MALO_CFG_skip; 
	call MALO_fnc_loadProgress;

	publicVariable "MALO_mission_progress";

};

sleep .05;

if (count MALO_mission_progress < 1) exitWith {hint "Loading..."; sleep .05; hint "Loaded.";};

hintSilent "Loading progress...";

call MALO_fnc_loadProgressKeywords;

{

	try {

		call compile ("[] spawn MALO_KEY_" + _x + ";");
		sleep .1;

	} catch {

		hintSilent (composeText ['FAILED TO LOAD: "' + _x + '"', 'EXCEPTION: "' + _exception + '"', 'Skipping.']);
		sleep 5;

	};
	
} forEach MALO_mission_progress;

hint "Progress loaded.";