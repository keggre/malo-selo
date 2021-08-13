// CHECKS FOR CHANGES IN THE MISSION SAVE FILE AND PUSHES THEM IF THE CONDITIONS ARE MET

if (false) exitWith {};



// GET THE SAVED MISSION PROGRESS IF EXISTS

MALO_saved_mission_progress = profileNamespace getVariable ["MALO_saved_mission_progress", "None"];


// EXIT IF THERE'S NOTHING TO SAVE

if (MALO_saved_mission_progress isEqualTo MALO_mission_progress) exitWith {};
if (count MALO_mission_progress < 1) exitWith {};


/*if (ObjNull in MALO_saved_mission_progress) then {
    {MALO_saved_mission_progress = MALO_saved_mission_progress - [objNull]} forEach MALO_saved_mission_progress;
};*/


// PRINT THE SAVE FILE IN THE GAME LOG

diag_log "MALO SELO MISSION PROGRESS";
diag_log str MALO_mission_progress;


// EXIT IF SAVING IS SET TO FALSE

if (MALO_CFG_saving == false) exitWith {};


hintSilent "Saving mission progress...";


// PREVENT OVERWRITES

MALO_overwrite_detected = false;

if ((MALO_saved_mission_progress isEqualTo "None") == false && MALO_CFG_overwrite == false) then {

	{

		if !(_x in MALO_mission_progress) exitWith {MALO_overwrite_detected = true;}

	} forEach MALO_saved_mission_progress;

	if (MALO_overwrite_detected == true) exitWith {};

};

if (MALO_overwrite_detected == true) exitWith {hintSilent "SAVING ERROR: overwrite not allowed! Change the setting in the config."};


// SAVE TO THE PROFILE NAMESPACE

profileNamespace setVariable ["MALO_saved_mission_progress", MALO_mission_progress];
saveProfileNamespace;


hint "Mission progress saved.";