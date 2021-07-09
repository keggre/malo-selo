if (!hasInterface) exitWith {};
if (MALO_CFG_saving == false) exitWith {};

MALO_saved_mission_progress = profileNamespace getVariable ["MALO_saved_mission_progress", "None"];

if (MALO_saved_mission_progress isEqualTo MALO_mission_progress) exitWith {};
if (count MALO_mission_progress < 1) exitWith {};

if (ObjNull in MALO_saved_mission_progress) then {
    {MALO_saved_mission_progress = MALO_saved_mission_progress - [objNull]} forEach MALO_saved_mission_progress;
};

hintSilent "Saving mission progress...";

MALO_overwrite_detected = false;

if ((MALO_saved_mission_progress isEqualTo "None") == false && MALO_CFG_overwrite == false) then {

	{

		if !(_x in MALO_mission_progress) exitWith {MALO_overwrite_detected = true;}

	} forEach MALO_saved_mission_progress;

	if (MALO_overwrite_detected == true) exitWith {};

};

if (MALO_overwrite_detected == true) exitWith {hintSilent "SAVING ERROR: overwrite not allowed! Change the setting in the config."};

profileNamespace setVariable ["MALO_saved_mission_progress", MALO_mission_progress];
saveProfileNamespace;

hintSilent "Mission progress saved.";