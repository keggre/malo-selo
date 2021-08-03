// LOADS THE MISSION PROGRESS VARIABLE FROM THE PROFILE NAMESPACE

if (false) exitWith {};

if (MALO_CFG_loading == false) exitWith {};

// RETRIEVE FROM PROFILENAMESPACE
MALO_saved_mission_progress = profileNamespace getVariable ["MALO_saved_mission_progress", false];
if (MALO_saved_mission_progress isEqualTo false) exitWith {};

// REMOVE OBJNULLS
if (ObjNull in MALO_saved_mission_progress) then {
    {MALO_saved_mission_progress = MALO_saved_mission_progress - [objNull]} forEach MALO_saved_mission_progress;
};

// REPLACE MISSION NAMES
private _replacements = [["kamushovo", "kamyshovo"]];
{
    private _find = _x select 0;
    private _replace = _x select 1;
    if (_find in MALO_saved_mission_progress) then {
        private _index = MALO_saved_mission_progress find _find;
        MALO_saved_mission_progress set [_index, _replace];
    };
} forEach _replacements;

// REPLACE THE CURRENT MISSION PROGRESS WITH THE LOADED ONE
MALO_mission_progress = MALO_saved_mission_progress;