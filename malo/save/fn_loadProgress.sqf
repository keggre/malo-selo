if (!hasInterface) exitWith {};

if (MALO_CFG_loading == false) exitWith {};

MALO_saved_mission_progress = profileNamespace getVariable ["MALO_saved_mission_progress", false];
if (MALO_saved_mission_progress isEqualTo false) exitWith {};

if (ObjNull in MALO_saved_mission_progress) then {
    {MALO_saved_mission_progress = MALO_saved_mission_progress - [objNull]} forEach MALO_saved_mission_progress;
};

MALO_mission_progress = MALO_saved_mission_progress;